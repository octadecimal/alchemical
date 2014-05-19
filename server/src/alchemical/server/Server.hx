package alchemical.server;

import alchemical.server.Server.Client;
import haxe.io.Bytes;
import haxe.io.BytesOutput;
import neko.net.ThreadServer;
import sys.net.Socket;

typedef Client = {
	var id:Int;
	var sock:Socket;
}

typedef Message = {
	var packet:InputPacket;
}

/**
 * ...
 * @author Dylan Heyes
 */
class Server extends ThreadServer<Client, Message>
{
	private var _database:Database;
	private var _commandMap:Array<Dynamic>;
	private var _numConnectedClients:UInt;
	private var _nextValidID:Int = -1;
	private var _clientMap:Array<Client>;
	
	/**
	 * Constructor.
	 */
	public function new() 
	{
		super();
		
		_database = new Database();
		
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
		Debugger.server("Server started. host=" + host + " port=" + port);
		super.run(host, port);
	}
	
	override public function clientConnected(s:Socket):Client 
	{
		var id:UInt = generateClientId();
		_numConnectedClients++;
		
		var client:Client = { id: id, sock: s };
		
		_clientMap[id] = client;
		
		Debugger.server("Client connected: " + id + " = " + s.peer());
		Debugger.server("Total connections: " + _numConnectedClients);
		Debugger.server("Total clients: " + _clientMap.length);
		
		return client;
	}
	
	override public function clientDisconnected(c:Client) 
	{
		_numConnectedClients--;
		_nextValidID = c.id;
		
		_clientMap[c.id] = null;
		
		Debugger.server("Client disconnected: " + Std.string(c.id));
		Debugger.server("Total connections: " + _numConnectedClients);
		Debugger.server("Total clients: " + _clientMap.length);
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
			return { msg: { packet: new InputPacket(buf) }, bytes: buf.length};
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
	
	private function sendToClient(client:Client, packet:OutputPacket):Void
	{
		var outBytes:Bytes = packet.getBytes();
		
		Debugger.server("Sending " + outBytes.length + " bytes to client " + client.id);
		
		client.sock.output.writeBytes(outBytes, 0, outBytes.length);
		client.sock.output.flush();
	}
	
	private function sendToAllClients(packet:OutputPacket):Void
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
		
		var packet:OutputPacket = new OutputPacket();
		packet.writeString(message);
		sendToAllClients(packet);
	}
	
	
	
	// REQUEST HANDLERS
	// =========================================================================================
	
	private function handleLoginRequest(client:Client, packet:InputPacket):Void
	{
		var user:String = packet.readString();
		var pass:String = packet.readString();
		
		if (_database.isValidUser(user, pass))
		{
			Debugger.server("Valid user logged in: " + user);
			
			var outPacket:OutputPacket = new OutputPacket();
			
			outPacket.writeCommand(2);		// Login command
			outPacket.writeBool(1);			// Success
			
			outPacket.writeInt16(4);		// Define world
			outPacket.writeInt16(0);		// World id
			outPacket.writeString("debug");	// World name
			outPacket.writeInt16(16);		// World width
			outPacket.writeInt16(16);		// World height
			outPacket.writeInt16(7);		// Sky layer 1
			outPacket.writeInt16(1);		// Sky layer 2
			outPacket.writeInt16(3);		// Sky layer 3
			outPacket.writeInt16(1);		// Sky layer 4
			
			sendToClient(client, outPacket);
			
			sendMessageToAllClients(user + " logged in.");
		}
		else
		{
			Debugger.server("Invalid user attempted log in: " + user);
		}
	}
}