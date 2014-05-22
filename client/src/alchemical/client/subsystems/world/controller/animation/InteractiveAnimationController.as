/**
 * Copyright 2014, Dylan Heyes
 */
package alchemical.client.subsystems.world.controller.animation 
{
	import alchemical.client.subsystems.input.enum.EActions;
	import alchemical.client.subsystems.world.entities.MovableEntity;
	import alchemical.client.subsystems.world.model.DynamicsNode;
	import flash.geom.Point;
	
	/**
	 * InteractiveAnimationController
	 * @author Dylan Heyes
	 */
	public class InteractiveAnimationController extends AnimationController
	{
		// Action handler map
		protected static var _actionDownStates:Vector.<Boolean>;
		
		/**
		 * Constrcutor.
		 * @param	entity
		 */
		public function InteractiveAnimationController(entity:MovableEntity) 
		{
			super(entity);
			
			_actionDownStates = new Vector.<Boolean>(EActions.NUM_ACTIONS);
		}
		
		
		
		// API
		// =========================================================================================
		
		public function handleKeyDown(action:uint):void 
		{
			_actionDownStates[action] = true;
		}
		
		public function handleKeyUp(action:uint):void 
		{
			_actionDownStates[action] = false;
		}
		
		override public function update():void
		{
			var entity:MovableEntity = _entity;
			var dynamics:DynamicsNode = entity.dynamics;
			var velocity:Point = dynamics.velocity;
			
			if (_actionDownStates[EActions.MOVE_UP])
			{
				dynamics.acceleration += Math.min(dynamics.thrust, dynamics.maxAcceleration);
			}
			
			if (_actionDownStates[EActions.MOVE_LEFT])
			{
				dynamics.angularAcceleration -= Math.min(dynamics.torque, dynamics.maxAngularAcceleration);
			}
			
			if (_actionDownStates[EActions.MOVE_RIGHT])
			{
				dynamics.angularAcceleration += Math.min(dynamics.torque, dynamics.maxAngularAcceleration);
			}
			
			var mag:Number = Math.atan(entity.rotation);
			
			dynamics.acceleration *= dynamics.friction;
			dynamics.angularAcceleration *= dynamics.angularFriction;
			
			const offset:Number = Math.PI / 2;
			
			entity.transform.x += Math.cos(offset + entity.rotation) * dynamics.acceleration;
			entity.transform.y += Math.sin(offset + entity.rotation) * dynamics.acceleration;
			entity.transform.rotation += dynamics.angularAcceleration;
			
			super.update();
		}
		
	}

}