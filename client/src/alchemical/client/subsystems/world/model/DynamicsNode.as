/**
 * Copyright 2014, Dylan Heyes
 */
package alchemical.client.subsystems.world.model 
{
	import flash.geom.Point;
	/**
	 * EntityDynamics
	 * @author Dylan Heyes
	 */
	public class DynamicsNode 
	{
		public var thrust:Number = 0.05;
		public var torque:Number = 0.005;
		
		public var maxAcceleration:Number = 3;
		public var maxAngularAcceleration:Number = 0.1;
		
		public var acceleration:Number = 0;
		public var angularAcceleration:Number = 0;
		
		public var friction:Number = 0.98;
		public var angularFriction:Number = 0.93;
		
		public var velocity:Point = new Point(0,0);
		
		
		public function DynamicsNode()
		{
			
		}
	}

}