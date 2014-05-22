/**
 * Copyright 2014, Dylan Heyes
 */
package alchemical.client.subsystems.world.entities 
{
	import alchemical.client.subsystems.world.controller.animation.InteractiveAnimationController;
	import alchemical.client.subsystems.world.model.DynamicsNode;
	import starling.display.Sprite;
	
	/**
	 * MovableEntity
	 * @author Dylan Heyes
	 */
	public class MovableEntity extends Entity
	{
		/**
		 * Constructor.
		 */
		public function MovableEntity(view:Sprite = null) 
		{
			super(view);
			_dynamics = new DynamicsNode();
		}
		
		
		
		// ACCESSORS
		// =========================================================================================
		
		/**
		 * Animation controller.
		 */
		public function set animationController(a:InteractiveAnimationController):void	{ _animationController = a; }
		public function get animationController():InteractiveAnimationController		{ return _animationController; }
		private var _animationController:InteractiveAnimationController;
		
		/**
		 * Dynamics.
		 */
		public function set dynamics(a:DynamicsNode):void								{ _dynamics = a; }
		public function get dynamics():DynamicsNode										{ return _dynamics; }
		private var _dynamics:DynamicsNode;
	}

}