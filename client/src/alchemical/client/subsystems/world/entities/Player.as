/**
 * Copyright 2014, Dylan Heyes
 */
package alchemical.client.subsystems.world.entities 
{
	import alchemical.client.subsystems.world.controller.animation.InteractiveAnimationController;
	import starling.display.Sprite;
	
	/**
	 * Player
	 * @author Dylan Heyes
	 */
	public class Player extends Sprite 
	{
		public function Player() 
		{
			super();
			
		}
		
		
		
		
		// ACCESSORS
		// =========================================================================================
		
		/**
		 * Ship.
		 */
		public function set ship(a:Ship):void	{ _ship = a; }
		public function get ship():Ship			{ return _ship; }
		private var _ship:Ship;
		
		/**
		 * Animation controller.
		 */
		public function set animationController(a:InteractiveAnimationController):void	{ _animationController = a; }
		public function get animationController():InteractiveAnimationController		{ return _animationController; }
		private var _animationController:InteractiveAnimationController;
	}

}