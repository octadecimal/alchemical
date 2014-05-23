/**
 * Copyright 2014, Dylan Heyes
 */
package alchemical.client.subsystems.world.entities 
{
	import alchemical.client.subsystems.world.controller.animation.AnimationController;
	import alchemical.client.subsystems.world.controller.animation.ForwardAnimationController;
	import alchemical.client.subsystems.world.model.DynamicsNode;
	import alchemical.client.subsystems.world.model.TransformNode;
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
		public function set animationController(a:AnimationController):void	{ _animationController = a; }
		public function get animationController():AnimationController		{ return _animationController; }
		private var _animationController:AnimationController;
		
		/**
		 * Dynamics.
		 */
		public function set dynamics(a:DynamicsNode):void							{ _dynamics = a; }
		public function get dynamics():DynamicsNode									{ return _dynamics; }
		private var _dynamics:DynamicsNode;
		
		/**
		 * Target position..
		 */
		public function set targetPosition(a:TransformNode):void					{ _targetPosition = a; }
		public function get targetPosition():TransformNode							{ return _targetPosition; }
		private var _targetPosition:TransformNode;
	}

}