/**
 * Copyright 2014, Dylan Heyes
 */
package alchemical.client.subsystems.world.model.vo 
{
	/**
	 * ShipEngineVO
	 * @author Dylan Heyes
	 */
	public class ShipEngineVO 
	{
		public var id:int;
		public var view:int;
		public var thrust:Number;
		public var torque:Number;
		
		public function ShipEngineVO(id:int = -1, view:int = -1, thrust:Number = 1, torque:Number = 1) 
		{
			this.id = id;
			this.view = view;
			this.thrust = thrust;
			this.torque = torque;
		}
		
	}

}