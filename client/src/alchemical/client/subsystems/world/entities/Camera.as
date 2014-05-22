/**
 * Copyright 2014, Dylan Heyes
 */
package alchemical.client.subsystems.world.entities
{
	import alchemical.client.subsystems.world.controller.animation.AnimationController;
	import flash.geom.Point;
	
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
				this.x = (target.x - this.x) / 2;
				this.y = (target.x - this.y) / 2;
			}
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