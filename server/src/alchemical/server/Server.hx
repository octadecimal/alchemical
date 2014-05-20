package alchemical.server;

import alchemical.server.db.Database;
import alchemical.server.io.InPacket;
import alchemical.server.io.OutPacket;
import alchemical.server.io.PacketBuilder;
import alchemical.server.Server.Client;
import alchemical.server.util.Debugger;
import haxe.io.Bytes;
import haxe.io.BytesOutput;
import neko.net.ThreadServer;
import sys.net.Socket;

typedef Client = {
	var id:Int;
	var sock:Socket;
	var player:Player;
}

typedef Message = {
	var packet:InPacket;
}

typedef World = {
	var id:UInt;
	var name:String;
	var width:Int;
	var height:Int;
	var numSkyLayers:Int;
	var skyLayers:Array<Int>;
	var players:Array<Player>;
}

typedef Player = {
	var id:UInt;
	var user:UInt;
	var name:String;
	var world:UInt;
	var entity:UInt;
	var x:Float;
	var y:Float;
}

/**
 * ...
 * @author Dylan Heyes
 */
class Server extends ThreadServer<Client, Message>
{
	private var _database:Database;
	private var _numConnectedClients:UInt;
	private var _nextValidID:Int = -1;
	
	private var _commandMap:Array<Client -> InPacket -> Void>;
	private var _clientMap:Array<Client>;
	private var _worldMap:Array<World>;
	
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
	
	override public function run(host:String, port:Int) 
	{
		_worldMap = _database.getWorlds();
		
		Debugger.server("Server started. host=" + host + " port=" + port);
		super.run(host, port);
	}
	
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
	
	override public function clientDisconnected(c:Client) 
	{
		_numConnectedClients--;
		_nextValidID = c.id;
		
		_clientMap[c.id] = null;
		
		Debugger.server("Client disconnected: " + Std.string(c.id));
		Debugger.server("Total connections: " + _numConnectedClients);
		Debugger.server("Clients buffer: " + _clientMap.length);
	}
	
	override public function readClientMessage(c:Client, buf:Bytes, pos:Int, len:Int):{msg:Message, bytes:Int} 
	{
		var completeMessage:Bool = false;
		var currentPosition:Int = pos;
		
		while (currentPosition < (pos + len) && !completeMessage)
		{
			//Debugger.server("Current: " + buf.get(currentPosition));
			completeMessage = (buf.get(currentPosition) == 1);
			currentPosition++;
		}
		
		if (completeMessage)
		{
			return { msg: { packet: new InPacket(buf) }, bytes: buf.length};
		}
		else
		{
			return null;
		}
	}
	
	override function clientMessage(c:Client, msg:Message) 
	{
		var command:Int = msg.packet.readCommand();
		
		Debugger.server("EXEC: " + c.id + " -> " + command);
		
		_commandMap[command](c, msg.packet);
	}
	
	
	
	// INTERNAL
	// =========================================================================================
	
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
	
	private function sendToClient(client:Client, packet:OutPacket):Void
	{
		var outBytes:Bytes = packet.getBytes();
		
		Debugger.server("Sending " + outBytes.length + " bytes to client: " + client.id);
		
		client.sock.output.writeBytes(outBytes, 0, outBytes.length);
		client.sock.output.flush();
	}
	
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
	
	private function sendMessageToAllClients(message:String):Void
	{
		Debugger.server("MSG ALL: " + message);
		
		var packet:OutPacket = new OutPacket();
		packet.writeString(message);
		sendToAllClients(packet);
	}
	
	
	
	// REQUEST HANDLERS
	// =========================================================================================
	
	private function handleLoginRequest(client:Client, packet:InPacket):Void
	{
		var user:String = packet.readString();
		var pass:String = packet.readString();
		
		var userID:UInt = _database.getUserIDByCredentials(user, pass);
		
		var outPacket:OutPacket = new OutPacket();
		
		if (userID > 0)
		{
			Debugger.server("Valid user logged in: " + user + " " + userID);
			
			client.player = _database.registerPlayer(userID);
			var world:World = _worldMap[client.player.world];
			
			_builder.loginSuccess(outPacket);
			_builder.defineWorld(outPacket, world);
			_builder.definePlayer(outPacket, client.player);
		}
		else
		{
			outPacket.writeBool(0);			// fail
			Debugger.server("Invalid user attempted log in: " + user);
		}
		
		sendToClient(client, outPacket);
	}
}