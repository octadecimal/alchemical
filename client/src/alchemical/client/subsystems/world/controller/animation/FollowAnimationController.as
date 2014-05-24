/**
 * Copyright 2014, Dylan Heyes
 */
package alchemical.client.subsystems.world.controller.animation 
{
	import alchemical.client.subsystems.input.enum.EActions;
	import alchemical.client.subsystems.world.entities.MovableEntity;
	import alchemical.client.subsystems.world.model.DynamicsNode;
	import alchemical.client.subsystems.world.model.TransformNode;
	import flash.geom.Vector3D;
	
	/**
	 * FollowAnimationController
	 * @author Dylan Heyes
	 */
	public class FollowAnimationController extends AnimationController 
	{
		/**
		 * Constructor.
		 */
		public function FollowAnimationController(entity:MovableEntity) 
		{
			super(entity);
			
			_entity.dynamics.velocity.x = 0;
			_entity.dynamics.velocity.y = 0;
		}
		
		
		
		// API
		// =========================================================================================
		
		override public function update():void 
		{
			var entity:TransformNode = _entity.transform;
			var target:TransformNode = _entity.targetPosition;
			var dynamics:DynamicsNode = _entity.dynamics;
			var theta:Number = 0;
			
			if (target)
			{
				// Get angular distance
				theta = Math.atan2(target.y - entity.y, target.x - entity.x);
				var distance:Number = theta - entity.rotation;
				while (distance > Math.PI) distance = distance - Math.PI * 2;
				while (distance < -Math.PI) distance = distance + Math.PI * 2;
				
				// Get angular threshold
				var scale:Number = Math.abs(distance / Math.PI);
				var inverseScale:Number = 1 - scale;
				
				// Apply torque
				if ((distance < 0 && distance > -Math.PI) || distance > Math.PI)
				{
					dynamics.angularAcceleration += dynamics.torque * inverseScale;
				}
				else
				{
					dynamics.angularAcceleration -= dynamics.torque * inverseScale;
				}
				
				// Apply thrust
				//if (scale > 0.25)
					dynamics.acceleration += dynamics.thrust * (scale*.5+.5);	
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