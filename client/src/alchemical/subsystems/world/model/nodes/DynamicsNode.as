/**
 * Copyright 2014, Dylan Heyes
 */
package alchemical.subsystems.world.model.nodes
{
	import flash.geom.Point;
	
	/**
	 * EntityDynamics
	 * @author Dylan Heyes
	 */
	public class DynamicsNode 
	{
		public var mass:Number = 1;
		
		public var thrust:Number = 2;
		public var torque:Number = 0.3;
		
		public var acceleration:Number = 0;
		public var angularAcceleration:Number = 0;
		
		public var friction:Number = 0.98;
		public var angularFriction:Number = 0.93;
		
		public var maxAcceleration:Number = 3;
		public var maxAngularAcceleration:Number = 0.1;
		
		public var velocity:Point = new Point(0, 0);
		
		public var destination:TransformNode;
		
		
		/**
		 * Constructor.
		 */
		public function DynamicsNode()
		{
			
		}
	}

}