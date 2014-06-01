/**
 * Copyright 2014, Dylan Heyes
 */
package alchemical.subsystems.world.model.vo.spawn 
{
	/**
	 * SpawnShipVO
	 * @author Dylan Heyes
	 */
	public class SpawnShipVO 
	{
		public var id:int;
		public var x:Number;
		public var y:Number;
		public var r:Number;
		
		public var engines:Vector.<int> = new Vector.<int>();
		
		public function SpawnShipVO(id:int, x:Number = 0, y:Number = 0, r:Number = 0) 
		{
			this.id = id;
			this.x = x;
			this.y = y;
			this.r = r;
		}
		
	}

}