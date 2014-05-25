/**
 * Copyright 2014, Dylan Heyes
 */
package alchemical.client.subsystems.network.model 
{
	import alchemical.client.subsystems.ui.model.ChatMessage;
	import alchemical.client.subsystems.world.model.vo.MovementVO;
	import alchemical.client.subsystems.world.model.vo.NPCVo;
	import alchemical.client.subsystems.world.model.vo.PlayerVO;
	import alchemical.client.subsystems.world.model.vo.ShipVO;
	import alchemical.client.subsystems.world.model.vo.WorldVO;
	import flash.utils.IDataInput;
	
	/**
	 * PacketReader
	 * @author Dylan Heyes
	 */
	public class PacketReader 
	{
		/**
		 * Reads a login success response.
		 * @return	True if login successful.
		 */
		public function loginSuccess(bytes:IDataInput):Boolean 
		{
			return bytes.readBoolean();
		}
		
		/**
		 * Reads a world definition.
		 * @return WorldVO object containing world parameters.
		 */
		public function defineWorld(bytes:IDataInput):WorldVO
		{
			var vo:WorldVO = new WorldVO();
			vo.id = bytes.readShort();
			vo.name = bytes.readUTF();
			vo.width = bytes.readShort();
			vo.height = bytes.readShort();
			vo.numSkyLayers = bytes.readShort();
			
			for (var i:int = 0; i < vo.numSkyLayers; i++)
			{
				vo.skyLayers.push(bytes.readShort());
			}
			
			return vo;
		}
		
		/**
		 * Reads a player definition.
		 * @return PlayerVO object containing the player parameters.
		 */
		public function definePlayer(bytes:IDataInput):PlayerVO
		{
			var vo:PlayerVO = new PlayerVO();
			vo.id = bytes.readShort();
			vo.name = bytes.readUTF();
			vo.entity = bytes.readShort();
			vo.x = bytes.readShort();
			vo.y = bytes.readShort();
			
			return vo;
		}
		
		/**
		 * Reads a ship definition.
		 * @return ShipVO object containing the ship parameters.
		 */
		public function defineShip(bytes:IDataInput):ShipVO 
		{
			var vo:ShipVO = new ShipVO();
			vo.id = bytes.readShort();
			vo.type = bytes.readShort();
			vo.hull = bytes.readShort();
			
			return vo;
		}
		
		/**
		 * Defines npcs for the current world the player is located in.
		 * @return Vector of NPCVo objects containing the NPC parameters.
		 */
		public function defineNPCs(bytes:IDataInput):Vector.<NPCVo> 
		{
			var npc:NPCVo;
			var npcs:Vector.<NPCVo> = new Vector.<NPCVo>();
			
			var count:int = bytes.readShort();
			
			for (var i:int = 0; i < count; i++)
			{
				npc = new NPCVo();
				
				npc.id = bytes.readShort();
				npc.world = bytes.readShort();
				npc.ship = bytes.readShort();
				npc.x = bytes.readShort();
				npc.y = bytes.readShort();
				npc.faction = bytes.readShort();
				
				npcs.push(npc);
			}
			
			return npcs;
		}
		
		/**
		 * Reads a npc movement command.
		 * @return A MovementVO object with the target position of the NPC.
		 */
		public function moveNPC(bytes:IDataInput):MovementVO
		{
			var vo:MovementVO =  new MovementVO();
			
			vo.id = bytes.readShort();
			vo.x = bytes.readShort();
			vo.y = bytes.readShort();
			
			return vo;
		}
		
		/**
		 * Reads an incoming chat message.
		 * @return A ChatMessage object.
		 */
		public function chatMessage(bytes:IDataInput):ChatMessage 
		{
			var type:int = bytes.readShort();
			var msgLen:int = bytes.readShort();
			var msg:String = bytes.readUTFBytes(msgLen);
			var nameLen:int = bytes.readShort();
			var name:String = bytes.readUTFBytes(nameLen);
			
			return new ChatMessage(type, msg, name);
		}
	}

}