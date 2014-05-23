/**
 * Copyright 2014, Dylan Heyes
 */
package alchemical.client.subsystems.world.controller.animation 
{
	import alchemical.client.subsystems.input.enum.EActions;
	import alchemical.client.subsystems.world.entities.MovableEntity;
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
				theta = Math.atan2(entity.y - target.y, entity.x - target.x);
				
				// Apply thrust
				dynamics.acceleration += dynamics.thrust;
			
				// Apply acceleration
				dynamics.velocity.x = Math.cos(theta) * dynamics.acceleration;
				dynamics.velocity.y = Math.sin(theta) * dynamics.acceleration;
				
				// Apply friction
				dynamics.acceleration *= dynamics.friction;
				dynamics.angularAcceleration *= dynamics.friction;		
			
				var d:Number = theta - entity.rotation;
				entity.rotation = entity.rotation + (d * 0.025);
			}
			else
			{
				// Apply friction
				dynamics.velocity.x *= 0.98;
				dynamics.velocity.y *= 0.98;
				dynamics.acceleration *= 0.98;
				dynamics.angularAcceleration *= 0.98;
			}
			
			// Integrate
			entity.x -= dynamics.velocity.x;
			entity.y -= dynamics.velocity.y;
			//entity.rotation += dynamics.angularAcceleration;		
		}
	}

}