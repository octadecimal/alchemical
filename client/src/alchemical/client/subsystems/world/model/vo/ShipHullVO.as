/**
 * Copyright 2014, Dylan Heyes
 */
package alchemical.client.subsystems.world.model.vo 
{
	/**
	 * ShipHullVO
	 * @author Dylan Heyes
	 */
	public class ShipHullVO 
	{
		public var id:int;
		public var mass:Number;
		
		public function ShipHullVO(id:int, mass:Number = 1) 
		{
			this.id = id;
			this.mass = mass;
		}
		
	}

}