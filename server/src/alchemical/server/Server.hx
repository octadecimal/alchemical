package alchemical.server;

import alchemical.server.const.Commands;
import alchemical.server.db.Database;
import alchemical.server.io.InPacket;
import alchemical.server.io.OutPacket;
import alchemical.server.io.PacketBuilder;
import alchemical.server.Server.Client;
import alchemical.server.util.Debugger;
import haxe.io.Bytes;
import neko.net.ThreadServer;
import sys.net.Socket;

/**
 * Alchimcal Server.
 * @author Dylan Heyes
 */
class Server extends ThreadServer<Client, Message>
{
	// Database connection
	private var _database:Database;
	
	// Number of currently connected clients
	private var _numConnectedClients:UInt;
	
	// Next available client id
	private var _nextValidID:Int = -1;
	
	// Maps
	private var _commandMap:Array<Client -> InPacket -> Void>;
	private var _clientMap:Array<Client>;
	private var _worldMap:Array<World>;
	
	// Packet handlers
	private var _builder:PacketBuilder;
	
	
	/**
	 * Constructor.
	 */
	public function new() 
	{
		super();
		
		_database = new Database();
		_builder = new PacketBuilder();
		
		_numConnectedClients = 0;
		
		updateTime = 0.16;
		initialBufferSize = 128;
		
		_commandMap = [];
		_clientMap = [];
		
		_commandMap[0] = handleLoginRequest;
		_commandMap[1] = handleLoginRequest;
		_commandMap[2] = handleLoginRequest;
	}
	
	
	
	// INTERNAL OVERRIDES
	// =========================================================================================
	
	/**
	 * Starts the server.
	 */
	override public function run(host:String, port:Int) 
	{
		_worldMap = _database.getWorlds();
		
		Debugger.info("Server started. host=" + host + " port=" + port);
		super.run(host, port);
	}
	
	/**
	 * Client has connected.
	 */
	override public function clientConnected(s:Socket):Client 
	{
		var id:UInt = generateClientId();
		_numConnectedClients++;
		
		var client:Client = { id: id, sock: s , player: null};
		
		_clientMap[id] = client;
		
		Debugger.server("Client connected: " + id + " = " + s.peer());
		Debugger.server("Total connections: " + _numConnectedClients);
		Debugger.server("Clients buffer: " + _clientMap.length);
		
		return client;
	}
	
	/**
	 * Client has disconnected.
	 */
	override public function clientDisconnected(c:Client) 
	{
		_numConnectedClients--;
		_nextValidID = c.id;
		
		_clientMap[c.id] = null;
		
		Debugger.server("Client disconnected: " + Std.string(c.id));
		Debugger.server("Total connections: " + _numConnectedClients);
		Debugger.server("Clients buffer: " + _clientMap.length);
	}
	
	/**
	 * Reads the incoming client message in realtime, searching for a full completed message.
	 */
	override public function readClientMessage(c:Client, buf:Bytes, pos:Int, len:Int):{msg:Message, bytes:Int} 
	{
		var completeMessage:Bool = false;
		var currentPosition:Int = pos;
		
		while (currentPosition < (pos + len) && !completeMessage)
		{
			completeMessage = (buf.get(currentPosition) == Commands.END);
			currentPosition++;
		}
		
		if (completeMessage)
		{
			return { msg: { packet: new InPacket(buf) }, bytes: buf.length};
		}
		
		return null;
	}
	
	/**
	 * Called when a complete message has been found by readClientMessage. Reads incomiing commands
	 * and calls the relevant command request handler as specified in _commandMap.
	 */
	override function clientMessage(c:Client, msg:Message) 
	{
		var command:Int = msg.packet.readCommand();
		
		Debugger.exec("client: "+c.id + " -> command: " + command);
		
		_commandMap[command](c, msg.packet);
	}
	
	
	
	// INTERNAL
	// =========================================================================================
	
	/**
	 * Generates an optimal unique client id.
	 */
	private function generateClientId():UInt
	{
		if (_nextValidID == -1)
		{
			return _numConnectedClients;
		}
		else
		{
			return _nextValidID;
		}
	}
	
	/**
	 * Sends a packet to the specified client.
	 */
	private function sendToClient(client:Client, packet:OutPacket):Void
	{
		var outBytes:Bytes = packet.getBytes();
		
		Debugger.data("Sending " + outBytes.length + " bytes to client: " + client.id);
		
		client.sock.output.writeBytes(outBytes, 0, outBytes.length);
		client.sock.output.flush();
	}
	
	/**
	 * Sends a packet to all connected clients.
	 */
	private function sendToAllClients(packet:OutPacket):Void
	{
		for (client in _clientMap)
		{
			if (client != null)
			{
				sendToClient(client, packet);
			}
		}
	}
	
	
	
	// REQUEST HANDLERS
	// =========================================================================================
	
	/**
	 * request: LOGIN
	 */
	private function handleLoginRequest(client:Client, packet:InPacket):Void
	{
		var user:String = packet.readString();
		var pass:String = packet.readString();
		
		var userID:UInt = _database.getUserIDByCredentials(user, pass);
		
		var outPacket:OutPacket = new OutPacket();
		
		if (userID > 0)
		{
			Debugger.info("Valid user logged in: " + user + " " + userID);
			
			// Get player
			client.player = _database.getPlayer(userID);
			
			// Get world player exists in
			var world:World = _worldMap[client.player.world];
			
			// Get player ship
			var ship:Ship = _database.getPlayerShip(client.player.ship);
			
			// Get world NPCS
			var npcs:Array<NPC> = _database.getNPCsByWorld(world.id);
			
			_builder.loginSuccess(outPacket);
			_builder.defineWorld(outPacket, world);
			_builder.definePlayer(outPacket, client.player);
			_builder.definePlayerShip(outPacket, client.player, ship);
			_builder.defineNPCs(outPacket, npcs);
		}
		else
		{
			outPacket.writeBool(0);			// fail
			Debugger.server("Invalid user attempted log in: " + user);
		}
		
		sendToClient(client, outPacket);
	}
}


// Client type
typedef Client = {
	var id:Int;
	var sock:Socket;
	var player:Player;
}


// Socket message type
typedef Message = {
	var packet:InPacket;
}


// World type
typedef World = {
	var id:UInt;
	var name:String;
	var width:Int;
	var height:Int;
	var numSkyLayers:Int;
	var skyLayers:Array<Int>;
	var players:Array<Player>;
}


// Player type
typedef Player = {
	var id:UInt;
	var user:UInt;
	var name:String;
	var world:UInt;
	var ship:Int;
	var x:Float;
	var y:Float;
}

// Ship type
typedef Ship = {
	var id:Int;
	var type:UInt;
	var hull:UInt;
}

// NPC type
typedef NPC = {
	var id:Int;
	var world:Int;
	var ship:Int;
	var x:Int;
	var y:Int;
	var faction:Int;
}