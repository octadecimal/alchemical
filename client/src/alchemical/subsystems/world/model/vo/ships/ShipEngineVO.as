/**
 * Copyright 2014, Dylan Heyes
 */
package alchemical.subsystems.world.model.vo.ships 
{
	/**
	 * ShipEngineVO
	 * @author Dylan Heyes
	 */
	public class ShipEngineVO 
	{
		public var id:int;
		public var name:String;
		public var texture:String;
		
		public var thrust:Number;
		public var torque:Number;
		public var fuelUsage:Number;
		public var weight:Number;
		
		public function ShipEngineVO(id:int, name:String, texture:String, thrust:Number, torque:Number, fuelUsage:Number, weight:Number) 
		{
			this.id = id;
			this.name = name;
			this.texture = texture;
			this.thrust = thrust;
			this.torque = torque;
			this.fuelUsage = fuelUsage;
			this.weight = weight;
		}
		
	}

}