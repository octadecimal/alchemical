/**
 * Copyright 2014, Dylan Heyes
 */
package alchemical.client.subsystems.network.gateways 
{
	import alchemical.client.debugger.Debugger;
	import alchemical.client.subsystems.network.enum.ENetcode;
	import alchemical.client.subsystems.network.events.NetworkEvent;
	import alchemical.client.subsystems.network.interfaces.INetworkGateway;
	import flash.events.TimerEvent;
	import flash.utils.ByteArray;
	import flash.utils.setTimeout;
	import flash.utils.Timer;
	import starling.animation.DelayedCall;
	import starling.events.EventDispatcher;
	
	/**
	 * SimulatedGateway
	 * @author Dylan Heyes
	 */
	public class SimulatedGateway extends EventDispatcher implements INetworkGateway 
	{
		/**
		 * Constructor.
		 */
		public function SimulatedGateway() 
		{
			_inBytes = new ByteArray();
			_outBytes = new ByteArray();
			_commandMap = new Vector.<Function>(ENetcode.TOTAL_COMMANDS);
			
			_commandMap[ENetcode.LOGIN] = handleLoginRequest;
			_commandMap[ENetcode.DEFINE_WORLD] = handleDefineWorldRequest;
			
			_timer = new Timer(16);
			_timer.addEventListener(TimerEvent.TIMER, onTimerTick);
			_timer.start();
		}
		
		
		
		// API
		// =========================================================================================
		
		public function send(bytes:ByteArray):void 
		{
			Debugger.log(this, "Sending " + bytes.length + " bytes.");
			
			bytes.position = 0;
			
			processNextRequest(bytes);
		}
		
		private function processNextRequest(bytes:ByteArray):void 
		{
			_commandMap[bytes.readShort()](bytes);
			
			if (bytes.bytesAvailable > 0)
			{
				processNextRequest(bytes);
			}
		}
		
		
		
		// INTERNAL
		// =========================================================================================
		
		private function flush():void 
		{
			Debugger.log(this, "Simulating " + _outBytes.length + " bytes.");
			_outBytes.position = 0;
			
			dispatchEvent(new NetworkEvent(NetworkEvent.DATA_RECEIVED, _outBytes));
			
			_outBytes = new ByteArray();
			
			_waitingForFlush = false;
		}
		
		
		
		// REQUEST SIMULATIONS
		// =========================================================================================
		
		private function handleLoginRequest(bytes:ByteArray):void
		{
			var user:String = bytes.readUTF();
			var pass:String = bytes.readUTF();
			
			simulateLoginResponse();
		}
		
		private function simulateLoginResponse():void 
		{
			// Code
			_outBytes.writeShort(ENetcode.LOGIN);
			
			// Success
			_outBytes.writeBoolean(true);
			
			// World declaration
			_outBytes.writeShort(ENetcode.DEFINE_WORLD);
			_outBytes.writeShort(0);	// World id
			_outBytes.writeUTF("debug");	// World name
			//_outBytes.writeShort(16);	// World width
			//_outBytes.writeShort(16);	// World height
			//_outBytes.writeShort(0);	// Sky layer: 1
			//_outBytes.writeShort(4);	// Sky layer: 2
			//_outBytes.writeShort(6);	// Sky layer: 3
			//_outBytes.writeShort(8);	// Sky layer: 4
			//_outBytes.writeFloat(0);	// Player position: x
			//_outBytes.writeFloat(0);	// Player position: y
		}
		
		private function handleDefineWorldRequest():void 
		{
			
		}
		
		
		
		// EVENTS
		// =========================================================================================
		
		private function onTimerTick(e:TimerEvent):void 
		{
			if (_outBytes.length > 0 && !_waitingForFlush)
			{
				_waitingForFlush = true;
				setTimeout(flush, Math.random() * 1000);
			}
		}
		
		
		
		// PRIVATE
		// =========================================================================================
		
		private var _outBytes:ByteArray;
		private var _inBytes:ByteArray;
		private var _mode:uint;
		
		private var  _commandMap:Vector.<Function>;
		
		private var _timer:Timer;
		private var _waitingForFlush:Boolean = false;
	}

}