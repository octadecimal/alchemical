package alchemical.server.physics;

import alchemical.server.Server.DynamicEntity;
import alchemical.server.Server.DynamicsNode;
import alchemical.server.Server.TransformNode;

/**
 * ...
 * @author Dylan Heyes
 */
class Physics
{
	static public inline var PI_2:Float = 6.28318530718;
	
	static public inline var FRICTION:Float = 0.98;
	static public inline var ANGULAR_FRICTION:Float = 0.93;
	
	/**
	 * Constructor.
	 */
	public function new() 
	{
		
	}
	
	
	
	// API
	// =========================================================================================
	
	/**
	 * Steps the physics forward by one tick (scaled by input timePassed) on the passed
	 * set of DynamicEntity objects.
	 * @param	entities
	 */
	public function step(entities:Array<DynamicEntity>, timePassed:Float):Void
	{
		var entity:DynamicEntity, transform:TransformNode, dynamics:DynamicsNode, destination:TransformNode;
		var theta:Float, distance:Float, scale:Float, inverseScale:Float;
		
		for (i in 0...entities.length)
		{
			entity = entities[i];
			transform = entity.transform;
			dynamics = entity.dynamics;
			destination = entity.dynamics.target;
			
			// Step toward target destination
			if (destination != null)
			{
				// Get angular distance
				theta = Math.atan2(destination.y - transform.y, destination.x - transform.x);
				distance = theta - transform.r;
				
				// Wrap to -PI -> PI
				while (distance > Math.PI) distance = distance - PI_2;
				while (distance < -Math.PI) distance = distance + PI_2;
				
				// Get angular thresholds
				scale = Math.abs(distance / Math.PI);
				inverseScale = 1 - scale;
				
				// Apply: Torque
				if ((distance < 0 && distance > -Math.PI) || distance > Math.PI)
				{
					dynamics.angularAcceleration += dynamics.torque * inverseScale * timePassed;
				}
				else
				{
					dynamics.angularAcceleration -= dynamics.torque * inverseScale * timePassed;
				}
				
				// Apply: Thrust
				dynamics.acceleration += dynamics.thrust * scale * timePassed;
			}
			
			// Apply: Velocity
			dynamics.vx = Math.cos(transform.r) * dynamics.acceleration;
			dynamics.vy = Math.sin(transform.r) * dynamics.acceleration;
			
			// Apply: Friction
			dynamics.acceleration *= FRICTION;
			dynamics.vx *= FRICTION;
			dynamics.vy *= FRICTION;
			dynamics.angularAcceleration = dynamics.angularAcceleration * ANGULAR_FRICTION;
			
			// Integrate
			transform.x -= dynamics.vx;
			transform.y -= dynamics.vy;
			transform.r += dynamics.angularAcceleration;
		}
	}
}