/**
 * Copyright 2014, Dylan Heyes
 */
package alchemical.client.subsystems.world.controller.animation 
{
	import alchemical.client.subsystems.world.entities.Entity;
	import alchemical.client.subsystems.world.model.DynamicsNode;
	import alchemical.client.subsystems.world.model.TransformNode;
	
	/**
	 * FollowAnimationController
	 * @author Dylan Heyes
	 */
	public class FollowAnimationController extends AnimationController 
	{
		/**
		 * Constructor.
		 */
		public function FollowAnimationController(entity:Entity) 
		{
			super(entity);
			
			_entity.dynamics.velocity.x = 0;
			_entity.dynamics.velocity.y = 0;
		}
		
		
		
		// API
		// =========================================================================================
		
		override public function update(passedTime:Number):void 
		{
			var entity:TransformNode = _entity.transform;
			var destination:TransformNode = _entity.dynamics.destination;
			var dynamics:DynamicsNode = _entity.dynamics;
			var theta:Number = 0;
			
			if (destination)
			{
				// Get angular distance
				theta = Math.atan2(destination.y - entity.y, destination.x - entity.x);
				var distance:Number = theta - entity.rotation;
				while (distance > Math.PI) distance = distance - Math.PI * 2;
				while (distance < -Math.PI) distance = distance + Math.PI * 2;
				
				// Get angular threshold
				var scale:Number = Math.abs(distance / Math.PI);
				var inverseScale:Number = 1 - scale;
				
				// Apply torque
				if ((distance < 0 && distance > -Math.PI) || distance > Math.PI)
				{
					dynamics.angularAcceleration += dynamics.torque * inverseScale * passedTime;
				}
				else
				{
					dynamics.angularAcceleration -= dynamics.torque * inverseScale * passedTime;
				}
				
				// Apply thrust
				//if (scale > 0.25)
					//dynamics.acceleration += dynamics.thrust * (scale*.5+.5) * passedTime;	
				dynamics.acceleration += dynamics.thrust * scale * passedTime;	
			}
				
			// Apply acceleration
			dynamics.velocity.x = Math.cos(entity.rotation) * dynamics.acceleration;
			dynamics.velocity.y = Math.sin(entity.rotation) * dynamics.acceleration;
			
			// Apply friction
			dynamics.acceleration *= dynamics.friction;
			dynamics.velocity.x *= dynamics.friction;
			dynamics.velocity.y *= dynamics.friction;
			dynamics.angularAcceleration *= dynamics.angularFriction;	
			
			// Integrate
			entity.x -= dynamics.velocity.x;
			entity.y -= dynamics.velocity.y;
			entity.rotation += dynamics.angularAcceleration;
		}
	}

}