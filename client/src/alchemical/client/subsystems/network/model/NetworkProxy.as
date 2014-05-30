/**
 * Copyright 2014, Dylan Heyes
 */
package alchemical.client.subsystems.network.model 
{
	import alchemical.client.core.enum.ComponentNames;
	import alchemical.client.core.notes.NetworkNotes;
	import alchemical.client.debugger.Debugger;
	import alchemical.client.subsystems.network.enum.ENetcode;
	import alchemical.client.subsystems.network.events.NetworkEvent;
	import alchemical.client.subsystems.network.interfaces.INetworkGateway;
	import alchemical.client.subsystems.network.model.packets.Packet;
	import alchemical.client.subsystems.network.model.vo.TransformNodeVO;
	import alchemical.client.subsystems.ui.model.ChatMessage;
	import alchemical.client.subsystems.world.model.TransformNode;
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
		private var _builder:PacketBuilder;
		private var _gateway:INetworkGateway;
		private var _packet:Packet;
		private var _flushTimer:Timer;
		private var _secondTimer:Timer;
		private var _commandMap:Vector.<Function>;
		private var _inBytes:uint, _outBytes:uint = 0;
		
		/**
		 * Constructor.
		 */
		public function NetworkProxy(gateway:INetworkGateway) 
		{
			super(ComponentNames.NETWORK, _gateway);
			
			_reader = new PacketReader();
			_builder = new PacketBuilder();
			
			_gateway = gateway;
			_gateway.addEventListener(NetworkEvent.DATA_RECEIVED, onDataReceived);
			
			_commandMap = new Vector.<Function>(ENetcode.TOTAL_COMMANDS);
			_commandMap[ENetcode.END] = handleEndResponse;
			_commandMap[ENetcode.LOGIN] = handleLoginResponse;
			_commandMap[ENetcode.DEFINE_WORLD] = handleDefineWorldResponse;
			_commandMap[ENetcode.DEFINE_PLAYER] = handleDefinePlayerResponse;
			_commandMap[ENetcode.DEFINE_PLAYER_SHIP] = handleDefinePlayerShipResponse;
			_commandMap[ENetcode.DEFINE_NPCS] = handleDefineNPCsResponse;
			_commandMap[ENetcode.MOVE_NPC] = handleMoveNPCResponse;
			_commandMap[ENetcode.CHAT_MESSAGE] = handleChatMessageResponse;
			_commandMap[ENetcode.ENTITY_TRANSFORM] = handleEntityTransformResponse;
			
			_packet = new Packet();
			
			_flushTimer = new Timer(FLUSH_RATE);
			_flushTimer.addEventListener(TimerEvent.TIMER, onFlushTimerTick);
			_flushTimer.start();
			
			_secondTimer = new Timer(1000);
			_secondTimer.addEventListener(TimerEvent.TIMER, onSecondTimerTick);
			_secondTimer.start();
			
			Debugger.log(this, "Created.");
		}
		
		
		
		// INTERNAL
		// =========================================================================================
		
		/**
		 * Flushes the current output packet, sending the packet to the server.
		 */
		private function flush():void
		{
			Debugger.log(this, "Flushing " + _packet.bytes.length + " bytes.");
			
			_outBytes += _packet.bytes.bytesAvailable;
			_packet.bytes.position = 0;
			_gateway.send(_packet);
			_packet = new Packet();
		}
		
		
		
		// REQUEST WRITERS
		// =========================================================================================
		
		/**
		 * Writes a login request to the current output packet.
		 * @param	user	User login credentials.
		 * @param	pass	User password credentials.
		 */
		public function writeLoginRequest(user:String, pass:String):void
		{
			_builder.login(_packet, user, pass);
		}
		
		/**
		 * Writes a chat message that was entered by the player.
		 * @param	chatMessage	ChatMessage object of player message.
		 */
		public function writeChatMessage(chatMessage:ChatMessage):void 
		{
			_builder.chatMessage(_packet, chatMessage);
		}
		
		
		
		// COMMAND HANDLERS
		// =========================================================================================
		
		/**
		 * Command: Login
		 */
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
		
		/**
		 * Command: Define world
		 */
		private function handleDefineWorldResponse(bytes:IDataInput):void 
		{
			Debugger.log(this, "Defining world...");
			var vo:WorldVO = _reader.defineWorld(bytes);
			
			sendNotification(NetworkNotes.WORLD_DEFINED, vo);
		}
		
		/**
		 * Command: Define player
		 */
		private function handleDefinePlayerResponse(bytes:IDataInput):void 
		{
			Debugger.log(this, "Defining player...");
			var vo:PlayerVO = _reader.definePlayer(bytes);
			Debugger.log(this, "Player defined: " + vo.id + " -> " + vo.name);
			
			sendNotification(NetworkNotes.PLAYER_DEFINED, vo);
		}
		
		/**
		 * Command: Player's ship
		 */
		private function handleDefinePlayerShipResponse(bytes:IDataInput):void 
		{
			Debugger.log(this, "Defining player ship...");
			var vo:ShipVO = _reader.defineShip(bytes);
			Debugger.log(this, "Player ship defined: " + vo.id);
			
			sendNotification(NetworkNotes.PLAYER_SHIP_DEFINED, vo);
		}
		
		/**
		 * Command: Define world NPCs
		 */
		private function handleDefineNPCsResponse(bytes:IDataInput):void 
		{
			Debugger.log(this, "Defining NPCs...");
			var npcs:Vector.<NPCVo> = _reader.defineNPCs(bytes);
			Debugger.log(this, "Defined NPCs: " + npcs.length);
			
			sendNotification(NetworkNotes.NPCS_DEFINED, npcs);
			sendNotification(NetworkNotes.LOGIN_SUCCESSFUL);
		}
		
		/**
		 * Command: Move NPC
		 */
		private function handleMoveNPCResponse(bytes:IDataInput):void 
		{
			var vo:MovementVO = _reader.moveNPC(bytes);
			sendNotification(NetworkNotes.NPC_MOVED, vo);
		}
		
		/**
		 * Command: Chat message received.
		 */
		private function handleChatMessageResponse(bytes:IDataInput):void 
		{
			var chatMessage:ChatMessage = _reader.chatMessage(bytes);
			sendNotification(NetworkNotes.CHAT_MESSAGE_RECEIVED, chatMessage);
		}
		
		/**
		 * Command: Entity transform data received.
		 */
		private function handleEntityTransformResponse(bytes:IDataInput):void 
		{
			var vo:TransformNodeVO = _reader.transformNode(bytes);
			sendNotification(NetworkNotes.TRANSFORM_NODE_RECEIVED, vo);
		}
		
		/**
		 * Command: End flag received.
		 */
		private function handleEndResponse(bytes:IDataInput):void 
		{
			
		}
		
		
		
		// EVENTS
		// =========================================================================================
		
		/**
		 * event: Flush timer ticked.
		 */
		private function onFlushTimerTick(e:TimerEvent):void 
		{
			if (_packet.bytes.length > 0)
			{
				flush();
			}
		}
		
		/**
		 * event: Incoming packet data received.
		 */
		private function onDataReceived(e:NetworkEvent):void 
		{
			var command:int;
			var bytes:IDataInput = e.bytes;
			
			_inBytes += e.bytes.bytesAvailable;
			
			while (e.bytes.bytesAvailable > 0)
			{
				// Get next command
				command = bytes.readShort();
				Debugger.log(this, "Executing command: " + command);
				
				// Execute mapped command
				_commandMap[command](bytes);
			}
		}
		
		/**
		 * event: Second has passed.
		 * @param	e
		 */
		private function onSecondTimerTick(e:TimerEvent):void 
		{
			_inBytesPerSecond = _inBytes;
			_outBytesPerSecond = _outBytes;
			
			_inBytes = _outBytes = 0;
		}
		
		
		
		// ACCESSORS
		// =========================================================================================
		
		/**
		 * In bytes per second.
		 */
		public function get inBytesPerSecond():uint		{ return _inBytesPerSecond; }
		private var _inBytesPerSecond:uint				= 0;
		
		/**
		 * Out bytes per second.
		 */
		public function get outBytesPerSecond():uint	{ return _outBytesPerSecond; }
		private var _outBytesPerSecond:uint				= 0;
	}

}