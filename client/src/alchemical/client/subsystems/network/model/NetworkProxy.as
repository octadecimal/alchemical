/**
 * Copyright 2014, Dylan Heyes
 */
package alchemical.client.subsystems.network.model 
{
	import alchemical.client.core.enum.ComponentNames;
	import alchemical.client.debugger.Debugger;
	import alchemical.client.game.enum.GameNotes;
	import alchemical.client.subsystems.network.enum.ENetcode;
	import alchemical.client.subsystems.network.enum.NetworkNotes;
	import alchemical.client.subsystems.network.events.NetworkEvent;
	import alchemical.client.subsystems.network.interfaces.INetworkGateway;
	import flash.events.TimerEvent;
	import flash.utils.ByteArray;
	import flash.utils.Timer;
	import org.puremvc.as3.patterns.proxy.Proxy;
	
	/**
	 * NetworkProxy
	 * @author Dylan Heyes
	 */
	public class NetworkProxy extends Proxy 
	{
		// Outoing queue flush rate
		static public const FLUSH_RATE:Number = 16;
		
		/**
		 * Constructor.
		 */
		public function NetworkProxy(gateway:INetworkGateway) 
		{
			super(ComponentNames.NETWORK, _gateway);
			
			_gateway = gateway;
			_gateway.addEventListener(NetworkEvent.DATA_RECEIVED, onDataReceived);
			
			_commandMap = new Vector.<Function>(ENetcode.TOTAL_COMMANDS);
			buildResponseMap();
			
			_bytes = new ByteArray();
			
			_timer = new Timer(FLUSH_RATE);
			_timer.addEventListener(TimerEvent.TIMER, onTimerTick);
			_timer.start();
			
			Debugger.log(this, "Created.");
		}
		
		
		
		// API
		// =========================================================================================
		
		public function flush():void
		{
			_bytes.position = 0;
			_gateway.send(_bytes);
			_bytes = new ByteArray();
		}
		
		public function writeLoginRequest(user:String, pass:String):void
		{
			_bytes.writeShort(ENetcode.LOGIN);
			_bytes.writeUTF(user);
			_bytes.writeUTF(pass);
		}
		
		
		
		// INTERNAL
		// =========================================================================================
		
		private function buildResponseMap():void
		{
			_commandMap[ENetcode.LOGIN] = handleLoginResponse;
			_commandMap[ENetcode.DEFINE_WORLD] = handleDefineWorldResponse;
		}
		
		
		
		// RESPONSE HANDLERS
		// =========================================================================================
		
		private function handleLoginResponse(bytes:ByteArray):void 
		{
			var success:Boolean = bytes.readBoolean();
			
			if (success)
			{
				Debugger.log(this, "Login success.");
				sendNotification(NetworkNotes.LOGIN_SUCCESSFUL);
			}
			else
			{
				Debugger.log(this, "Login failure.");
				sendNotification(NetworkNotes.LOGIN_SUCCESSFUL);
			}
		}
		
		private function handleDefineWorldResponse(bytes:ByteArray):void 
		{
			Debugger.log(this, "Defining world...");
			
			var worldID:int = bytes.readShort();
			var worldName:String = bytes.readUTF();
			
			Debugger.log(this, "World defined id=" + worldID + " name=" + worldName);
		}
		
		
		
		// EVENTS
		// =========================================================================================
		
		private function onTimerTick(e:TimerEvent):void 
		{
			if (_bytes.length > 0)
			{
				flush();
			}
		}
		
		private function onDataReceived(e:NetworkEvent):void 
		{
			while (e.bytes.bytesAvailable > 0)
			{
				_commandMap[e.bytes.readShort()](e.bytes);
			}
		}
		
		
		
		// PRIVATE
		// =========================================================================================
		
		private var _gateway:INetworkGateway;
		private var _bytes:ByteArray;
		private var _timer:Timer;
		private var _commandMap:Vector.<Function>;
	}

}