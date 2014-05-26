package alchemical.server;

import alchemical.server.const.Commands;
import alchemical.server.const.EntityStates;
import alchemical.server.db.Database;
import alchemical.server.io.InPacket;
import alchemical.server.io.OutPacket;
import alchemical.server.io.PacketBuilder;
import alchemical.server.physics.Physics;
import alchemical.server.Server.Client;
import alchemical.server.Server.NPC;
import alchemical.server.Server.World;
import alchemical.server.test.Tests;
import alchemical.server.util.Debugger;
import alchemical.server.util.Delays;
import alchemical.server.util.Tweens;
import haxe.io.Bytes;
import haxe.Timer;
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
	
	// Time memory
	private var _delays:Delays;
	private var _tweens:Tweens;
	private var _physics:Physics;
	private var _passedTime:Float;
	private var _lastUpdateTime:Float = Timer.stamp();
	
	// Tests
	private var _tests:Tests;
	
	
	/**
	 * Constructor.
	 */
	public function new() 
	{
		super();
		
		_tests = new Tests();
		
		_delays = new Delays();
		_tweens = new Tweens();
		_physics = new Physics();
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
		_commandMap[Commands.CHAT_MSG] = handleChatMessageReceived;
	}
	
	
	
	// INTERNAL OVERRIDES
	// =========================================================================================
	
	/**
	 * Starts the server.
	 */
	override public function run(host:String, port:Int) 
	{
		// Initialize worlds
		_worldMap = _database.getWorlds();
		
		// Initialize npcs
		for (i in 0..._worldMap.length)
		{
			var npcs:Array<NPC> = _database.getNPCsByWorld(i);
			_worldMap[i].npcs = npcs;
			
			for (j in 0...npcs.length)
			{
				_worldMap[i].entities.push(npcs[j]);
			}
		}
		
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
		
		var client:Client = { id: id, sock: s , player: null, world: null };
		
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
		
		_clientMap[c.id] = null; // TODO: Splice from array?
		
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
	
	private function sendToWorldPlayers(worldID:Int, packet:OutPacket):Void
	{
		for (client in _clientMap)
		{
			if (client != null && client.world != null)
			{
				if (client.world.id == worldID)
				{
					sendToClient(client, packet);
				}
			}
		}
	}
	
	
	
	// UPDATE
	// =========================================================================================
	
	override public function update() 
	{	
		super.update();
		
		var worldNPCs:Array<NPC>, npc:NPC;
		
		_passedTime = Timer.stamp() - _lastUpdateTime;
		
		// TEST!!!
		_tests.testPhysicsStepping(1000, _physics, _passedTime);
		
		// Update timers
		_delays.update(_passedTime);
		
		// Update tweens
		_tweens.update(_passedTime);
		
		// Loop through worlds
		for (i in 0..._worldMap.length)
		{
			// Update physics for entities in world
			_physics.step(_worldMap[i].entities, _passedTime);
			
			// Update world NPCs
			updateWorldNPCs(_worldMap[i]);
			
			// Send world outpacket
			if (_worldMap[i].outPacket != null)
			{
				sendToWorldPlayers(_worldMap[i].id, _worldMap[i].outPacket);
			}
			
			// Dispose outpacket
			_worldMap[i].outPacket = null;
		}
		
		_lastUpdateTime = Timer.stamp();
	}
	
	private function updateWorldNPCs(world:World):Void
	{
		var currentNPC:NPC;
		
		for (i in 0...world.npcs.length)
		{
			// Get current npc
			currentNPC = world.npcs[i];
			
			// Patrolling
			if (currentNPC.state == EntityStates.IDLE)
			{
				// Has no target position
				if (currentNPC.destination == null)
				{
					// Generate random target
					moveWorldNPCTo(world, currentNPC, Math.random() * 1920, Math.random() * 1080);
				}
			}
		}
	}
	
	private function moveWorldNPCTo(world:World, npc:NPC, x:Float, y:Float):Void
	{
		// Set state
		npc.state = EntityStates.PATROLLING;
		
		// Set npc target position
		npc.destination = { x: x, y: y, r: 0 };
		
		// Add to world outpacket
		_builder.moveWorldNPCTo(world, npc, npc.destination);
		
		_delays.add(3, function ():Void
		{
			npc.destination = null;
			npc.state = EntityStates.IDLE;
		});
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
			world.players.push(client.player);
			world.entities.push(client.player);
			
			// Set client world
			client.world = world;
			client.player.world = world.id;
			
			// Get player ship
			var ship:Ship = _database.getPlayerShip(client.player.ship);
			
			// Get world NPCS
			var npcs:Array<NPC> = world.npcs;
			
			// Build out packet
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
	
	private function handleChatMessageReceived(client:Client, packet:InPacket):Void
	{
		var type:Int = packet.readInt16();
		var msg:String = packet.readString();
		
		// Build out packet (gets queued into world outpacket)
		_builder.chatMessage(client.world, type, msg, client.player.name);
	}
}
	
	
	
// TYPEDEFS
// =========================================================================================

// Client type
typedef Client = {
	var id:Int;
	var sock:Socket;
	var player:Player;
	var world:World;
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
	var npcs:Array<NPC>;
	var entities:Array<DynamicEntity>;
	var outPacket:OutPacket;
}

// Ship type
typedef Ship = {
	var id:Int;
	var type:UInt;
	var hull:UInt;
}

// Transform
typedef TransformNode = {
	var x:Float;
	var y:Float;
	var r:Float;
}

// Dynamics
typedef DynamicsNode = {
	var mass:Float;
	var thrust:Float;
	var torque:Float;
	var acceleration:Float;
	var angularAcceleration:Float;
	var vx:Float;
	var vy:Float;
}

// Entity
typedef Entity = {
	var id:Int;
	var world:Int;
	var transform:TransformNode;
	var state:Int;
}

// Movable Entity
typedef DynamicEntity = {> Entity,
	var dynamics:DynamicsNode;
	var destination:TransformNode;
}

// Player
typedef Player = {> DynamicEntity,
	var user:Int;
	var name:String;
	var ship:Int;
}

// NPC
typedef NPC = {> DynamicEntity,
	 var ship:Int;
	 var faction:Int;
}

// Projectile
typedef Projectile = {> DynamicEntity,
	
}

// Structure
typedef Structure = {> Entity,
	
}