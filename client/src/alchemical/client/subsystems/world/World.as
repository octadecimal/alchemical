/**
 * Copyright 2014, Dylan Heyes
 */
package alchemical.client.subsystems.world
{
	import alchemical.client.subsystems.world.entities.Camera;
	import flash.geom.Rectangle;
	import starling.core.Starling;
	import starling.display.Sprite;
	import starling.events.EnterFrameEvent;
	
	/**
	 * World
	 * @author Dylan Heyes
	 */
	public class World extends Sprite 
	{
		/**
		 * Constructor.
		 */
		public function World() 
		{
			super();
			
			// Test
			//addEventListener(EnterFrameEvent.ENTER_FRAME, onUpdate);
		}
		
		// Test
		private function onUpdate(e:EnterFrameEvent):void 
		{
			if (Starling.current.nativeStage.mouseX == 0)
			{
				camera.transform.x -= 4;
			}
			else if (Starling.current.nativeStage.mouseX > 1900)
			{
				camera.transform.x += 4;
			}
			
			if (Starling.current.nativeStage.mouseY == 0)
			{
				camera.transform.y -= 4;
			}
			else if (Starling.current.nativeStage.mouseY > 1040)
			{
				camera.transform.y += 4;
			}
		}
		
		
		
		// ACCESSORS
		// =========================================================================================
		
		/**
		 * World sky.
		 */
		public function set sky(a:Sky):void		{ _sky = a; }
		public function get sky():Sky			{ return _sky; }
		private var _sky:Sky;
		
		/**
		 * Attached camera.
		 */
		public function set camera(a:Camera):void	{ _camera = a; }
		public function get camera():Camera		{ return _camera; }
		private var _camera:Camera;
		
		/**
		 * Visible world bounds.
		 */
		public function set worldBounds(a:Rectangle):void	{ _worldBounds = a; }
		public function get worldBounds():Rectangle		{ return _worldBounds; }
		private var _worldBounds:Rectangle;
	}

}