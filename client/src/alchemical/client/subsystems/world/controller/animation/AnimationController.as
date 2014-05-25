/**
 * Copyright 2014, Dylan Heyes
 */
package alchemical.client.subsystems.world.controller.animation 
{
	import alchemical.client.subsystems.world.entities.MovableEntity;
	/**
	 * AnimationController
	 * @author Dylan Heyes
	 */
	public class AnimationController 
	{
		protected static var _actionDownStates:Vector.<Boolean>;
		
		protected var _entity:MovableEntity;
		
		
		/**
		 * Constructor.
		 * @param	entity	Movable entity to be controlled.
		 */
		public function AnimationController(entity:MovableEntity) 
		{
			_entity = entity;
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
		
		public function update(passedTime:Number):void
		{
			
		}
	}

}