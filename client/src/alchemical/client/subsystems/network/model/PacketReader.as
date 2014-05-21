/**
 * Copyright 2014, Dylan Heyes
 */
package alchemical.client.subsystems.network.model 
{
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
		
		public function PacketReader() 
		{
			
		}
		
		public function loginSuccess(bytes:IDataInput):Boolean 
		{
			return bytes.readBoolean();
		}
		
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
		
		public function defineShip(bytes:IDataInput):ShipVO 
		{
			var vo:ShipVO = new ShipVO();
			vo.id = bytes.readShort();
			vo.type = bytes.readShort();
			vo.hull = bytes.readShort();
			
			return vo;
		}
	}

}