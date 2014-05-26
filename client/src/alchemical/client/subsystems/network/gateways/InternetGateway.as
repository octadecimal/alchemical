/**
 * Copyright 2014, Dylan Heyes
 */
package alchemical.client.subsystems.network.gateways 
{
	import alchemical.client.debugger.Debugger;
	import alchemical.client.subsystems.network.enum.ENetcode;
	import alchemical.client.subsystems.network.events.NetworkEvent;
	import alchemical.client.subsystems.network.interfaces.INetworkGateway;
	import alchemical.client.subsystems.network.model.NetworkSocket;
	import alchemical.client.subsystems.network.model.packets.Packet;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.events.SecurityErrorEvent;
	import flash.utils.setTimeout;
	import starling.events.EventDispatcher;
	
	/**
	 * InternetGateway
	 * @author Dylan Heyes
	 */
	public class InternetGateway extends EventDispatcher implements INetworkGateway
	{
		private var _host:String;
		private var _port:uint;
		
		/**
		 * Constructor.
		 */
		public function InternetGateway(host:String, port:uint) 
		{
			_host = host;
			_port = port;
			
			_socket = new NetworkSocket(host, port);
			
			_socket.addEventListener(Event.CONNECT, onSocketConnected);
			_socket.addEventListener(Event.CLOSE, onSocketClosed);
			_socket.addEventListener(IOErrorEvent.IO_ERROR, onSocketIOError);
			_socket.addEventListener(SecurityErrorEvent.SECURITY_ERROR, onSocketSecurityError);
			_socket.addEventListener(ProgressEvent.SOCKET_DATA, onSocketDataReceived);
			
			connect();
		}
		
		
		
		// API
		// =========================================================================================
		
		/**
		 * Connects the socket to the server.
		 */
		public function connect():void
		{
			_socket.connect(_host, _port);
		}
		
		/**
		 * Sends an out packet to the server.
		 * @param	packet
		 */
		public function send(packet:Packet):void 
		{
			if (_socket.connected)
			{
				Debugger.log(this, "Sending " + packet.bytes.length + " bytes.");
				
				_socket.writeBytes(packet.bytes);
				_socket.writeShort(ENetcode.END);
				fillSocket(_socket);
				
				Debugger.log(this, "Flushing " + _socket.bytesPending+ " bytes");
				_socket.flush();
			}
			else
			{
				Debugger.log(this, "Not connected, ignored sending.");
			}
		}
		
		
		
		// INTERNAL
		// =========================================================================================
		
		/**
		 * Fills the end of a packet with empty bytes. Would like to avoid this on the client side, as it
		 * isn't necessary on the server sisde.
		 */
		private function fillSocket(socket:NetworkSocket):void 
		{
			for (var i:int = _socket.bytesPending; i < 256; i++)
			{
				_socket.writeByte(0);
			}
		}
		
		
		
		// EVENTS
		// =========================================================================================
		
		/**
		 * event: Socket connected.
		 */
		private function onSocketConnected(e:Event):void 
		{
			Debugger.log(this, "Socket connected.");
			
			dispatchEvent(new NetworkEvent(NetworkEvent.CONNECTED));
		}
		
		/**
		 * event: Socket closed.
		 */
		private function onSocketClosed(e:Event):void 
		{
			Debugger.log(this, "Socket disconnected.");
			
			dispatchEvent(new NetworkEvent(NetworkEvent.DISCONNECTED));
		}
		
		/**
		 * event: Socket data received.
		 */
		private function onSocketDataReceived(e:ProgressEvent):void 
		{
			Debugger.log(this, "Received " + _socket.bytesAvailable+" bytes.");
			
			dispatchEvent(new NetworkEvent(NetworkEvent.DATA_RECEIVED, _socket));
		}
		
		
		
		// ERRORS
		// =========================================================================================
		
		/**
		 * error: Socket IO error.
		 */
		private function onSocketIOError(e:IOErrorEvent):void 
		{
			Debugger.log(this, "IO Error: " + e.errorID);
			
			if (e.errorID == 2031)
			{
				Debugger.log(this, "Server unreachable, reconnecting...");
				
				setTimeout(connect, 50);
			}
		}
		
		/**
		 * error: Socket security error.
		 */
		private function onSocketSecurityError(e:SecurityErrorEvent):void 
		{
			Debugger.log(this, "Security error: " + e.errorID);
		}
		
		
		
		// PRIVATE
		// =========================================================================================
		
		private var _socket:NetworkSocket;
	}

}