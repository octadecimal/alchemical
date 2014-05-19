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
	import starling.events.EventDispatcher;
	
	/**
	 * InternetGateway
	 * @author Dylan Heyes
	 */
	public class InternetGateway extends EventDispatcher implements INetworkGateway
	{
		/**
		 * Constructor.
		 */
		public function InternetGateway(host:String, port:uint) 
		{
			_socket = new NetworkSocket(host, port);
			
			_socket.addEventListener(Event.CONNECT, onSocketConnected);
			_socket.addEventListener(Event.CLOSE, onSocketClosed);
			_socket.addEventListener(IOErrorEvent.IO_ERROR, onSocketIOError);
			_socket.addEventListener(SecurityErrorEvent.SECURITY_ERROR, onSocketSecurityError);
			_socket.addEventListener(ProgressEvent.SOCKET_DATA, onSocketDataReceived);
			
			_socket.connect(host, port);
		}
		
		
		
		// API
		// =========================================================================================
		
		public function send(packet:Packet):void 
		{
			Debugger.log(this, "Sending " + packet.bytes.length + " bytes.");
			
			_socket.writeBytes(packet.bytes);
			_socket.writeShort(ENetcode.END);
			fillSocket(_socket);
			
			Debugger.log(this, "Flushing " + _socket.bytesPending+ " bytes");
			_socket.flush();
		}
		
		private function fillSocket(socket:NetworkSocket):void 
		{
			for (var i:int = _socket.bytesPending; i < 128; i++)
			{
				_socket.writeByte(0);
			}
		}
		
		
		
		// EVENTS
		// =========================================================================================
		
		private function onSocketConnected(e:Event):void 
		{
			Debugger.log(this, "Socket connected.");
			
			dispatchEvent(new starling.events.Event(Event.CONNECT));
		}
		
		private function onSocketClosed(e:Event):void 
		{
			Debugger.log(this, "Socket disconnected.");
		}
		
		private function onSocketDataReceived(e:ProgressEvent):void 
		{
			Debugger.log(this, "Received " + _socket.bytesAvailable+" bytes.");
			
			dispatchEvent(new NetworkEvent(NetworkEvent.DATA_RECEIVED, _socket));
		}
		
		
		
		// ERRORS
		// =========================================================================================
		
		private function onSocketIOError(e:IOErrorEvent):void 
		{
			Debugger.log(this, "IO Error: " + e.errorID);
		}
		
		private function onSocketSecurityError(e:SecurityErrorEvent):void 
		{
			Debugger.log(this, "Security error: " + e.errorID);
		}
		
		
		
		// PRIVATE
		// =========================================================================================
		
		private var _socket:NetworkSocket;
	}

}