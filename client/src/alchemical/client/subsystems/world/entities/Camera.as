/**
 * Copyright 2014, Dylan Heyes
 */
package alchemical.client.subsystems.world.entities
{
	import alchemical.client.subsystems.world.controller.animation.AnimationController;
	import flash.geom.Point;
	import starling.events.EnterFrameEvent;
	
	/**
	 * Camera
	 * @author Dylan Heyes
	 */
	public class Camera extends MovableEntity
	{
		/**
		 * Constructor.
		 */
		public function Camera() 
		{
			super();
		}
		
		
		
		// API
		// =========================================================================================
		
		public function update(passedTime:Number):void 
		{
			if (target)
			{
				transform.x = (target.transform.x - transform.x) / 2;
				transform.y = (target.transform.y - transform.y) / 2;
			}
		}
		
		public function projectPoint(position:Point):void 
		{
			position.x = transform.x + position.x;
			position.y = transform.y + position.y;
		}
		
		
		
		// ACCESSORS
		// =========================================================================================
		
		/**
		 * Target entity.
		 */
		public function set target(a:Entity):void							{ _target = a; }
		public function get target():Entity									{ return _target; }
		private var _target:Entity;
	}

}