/**
 * Copyright 2014, Dylan Heyes
 */
package alchemical.client.subsystems.network.model 
{
	import alchemical.client.core.enum.ComponentNames;
	import alchemical.client.debugger.Debugger;
	import alchemical.client.subsystems.network.enum.ENetcode;
	import alchemical.client.core.notes.NetworkNotes;
	import alchemical.client.subsystems.network.events.NetworkEvent;
	import alchemical.client.subsystems.network.interfaces.INetworkGateway;
	import alchemical.client.subsystems.network.model.packets.Packet;
	import alchemical.client.subsystems.world.model.vo.MovementVO;
	import alchemical.client.subsystems.world.model.vo.NPCVo;
	import alchemical.client.subsystems.world.model.vo.PlayerVO;
	import alchemical.client.subsystems.world.model.vo.ShipVO;
	import alchemical.client.subsystems.world.model.vo.WorldVO;
	import flash.events.TimerEvent;
	import flash.utils.IDataInput;
	import flash.utils.Timer;
	import org.puremvc.as3.patterns.proxy.Proxy;
	
	/**
	 * NetworkProxy
	 * @author Dylan Heyes
	 */
	public class NetworkProxy extends Proxy 
	{
		static public const FLUSH_RATE:Number = 16;
		
		private var _reader:PacketReader;
		private var _gateway:INetworkGateway;
		private var _packet:Packet;
		private var _timer:Timer;
		private var _commandMap:Vector.<Function>;
		
		/**
		 * Constructor.
		 */
		public function NetworkProxy(gateway:INetworkGateway) 
		{
			super(ComponentNames.NETWORK, _gateway);
			
			_reader = new PacketReader();
			
			_gateway = gateway;
			_gateway.addEventListener(NetworkEvent.DATA_RECEIVED, onDataReceived);
			
			_commandMap = new Vector.<Function>(ENetcode.TOTAL_COMMANDS);
			_commandMap[ENetcode.LOGIN] = handleLoginResponse;
			_commandMap[ENetcode.DEFINE_WORLD] = handleDefineWorldResponse;
			_commandMap[ENetcode.DEFINE_PLAYER] = handleDefinePlayerResponse;
			_commandMap[ENetcode.DEFINE_PLAYER_SHIP] = handleDefinePlayerShipResponse;
			_commandMap[ENetcode.DEFINE_NPCS] = handleDefineNPCsResponse;
			_commandMap[ENetcode.MOVE_NPC] = handleMoveNPCResponse;
			
			_packet = new Packet();
			
			_timer = new Timer(FLUSH_RATE);
			_timer.addEventListener(TimerEvent.TIMER, onTimerTick);
			_timer.start();
			
			Debugger.log(this, "Created.");
		}
		
		
		
		// INTERNAL
		// =========================================================================================
		
		private function flush():void
		{
			Debugger.log(this, "Flushing " + _packet.bytes.length + " bytes.");
			
			_packet.bytes.position = 0;
			_gateway.send(_packet);
			_packet = new Packet();
		}
		
		
		
		// REQUEST WRITERS
		// =========================================================================================
		
		public function writeLoginRequest(user:String, pass:String):void
		{
			_packet.writeCommand(ENetcode.LOGIN);
			_packet.writeString(user);
			_packet.writeString(pass);
		}
		
		
		
		// RESPONSE HANDLERS
		// =========================================================================================
		
		private function handleLoginResponse(bytes:IDataInput):void 
		{
			var success:Boolean = bytes.readBoolean();
			
			if (success)
			{
				Debugger.log(this, "Login success.");
			}
			else
			{
				Debugger.log(this, "Login failure.");
				sendNotification(NetworkNotes.LOGIN_FAILURE);
			}
		}
		
		private function handleDefineWorldResponse(bytes:IDataInput):void 
		{
			Debugger.log(this, "Defining world...");
			var vo:WorldVO = _reader.defineWorld(bytes);
			
			sendNotification(NetworkNotes.WORLD_DEFINED, vo);
		}
		
		private function handleDefinePlayerResponse(bytes:IDataInput):void 
		{
			Debugger.log(this, "Defining player...");
			var vo:PlayerVO = _reader.definePlayer(bytes);
			Debugger.log(this, "Player defined: " + vo.id + " -> " + vo.name);
			
			sendNotification(NetworkNotes.PLAYER_DEFINED, vo);
		}
		
		private function handleDefinePlayerShipResponse(bytes:IDataInput):void 
		{
			Debugger.log(this, "Defining player ship...");
			var vo:ShipVO = _reader.defineShip(bytes);
			Debugger.log(this, "Player ship defined: " + vo.id);
			
			sendNotification(NetworkNotes.PLAYER_SHIP_DEFINED, vo);
		}
		
		private function handleDefineNPCsResponse(bytes:IDataInput):void 
		{
			Debugger.log(this, "Defining NPCs...");
			var npcs:Vector.<NPCVo> = _reader.defineNPCs(bytes);
			Debugger.log(this, "Defined NPCs: " + npcs.length);
			
			sendNotification(NetworkNotes.NPCS_DEFINED, npcs);
			sendNotification(NetworkNotes.LOGIN_SUCCESSFUL);
		}
		
		private function handleMoveNPCResponse(bytes:IDataInput):void 
		{
			var vo:MovementVO = _reader.moveNPC(bytes);
			
			Debugger.log(this, "Moving NPC " + vo.id + " to: " + vo.x + "," + vo.y);
			
			sendNotification(NetworkNotes.NPC_MOVED, vo);
		}
		
		
		
		// EVENTS
		// =========================================================================================
		
		private function onTimerTick(e:TimerEvent):void 
		{
			if (_packet.bytes.length > 0)
			{
				flush();
			}
		}
		
		private function onDataReceived(e:NetworkEvent):void 
		{
			var command:int;
			var bytes:IDataInput = e.bytes;
			
			while (e.bytes.bytesAvailable > 0)
			{
				command = bytes.readShort();
				
				Debugger.log(this, "Executing command: " + command);
				
				_commandMap[command](bytes);
			}
		}
	}

}