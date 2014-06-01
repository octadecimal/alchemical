/**
 * Copyright 2014, Dylan Heyes
 */
package alchemical.subsystems.world.model.vo.ships 
{
	/**
	 * ShipHullVO
	 * @author Dylan Heyes
	 */
	public class ShipHullVO 
	{
		public var id:int;
		public var name:String;
		public var texture:String;
		
		public var mass:Number;
		public var armor:Number;
		
		public var enginebays:Vector.<ShipEnginebayVO> = new Vector.<ShipEnginebayVO>();
		
		public function ShipHullVO() 
		{
			
		}
		
	}

}