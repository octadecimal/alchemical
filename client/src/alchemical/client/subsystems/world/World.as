/**
 * Copyright 2014, Dylan Heyes
 */
package alchemical.client.subsystems.world
{
	import alchemical.client.subsystems.world.entities.Camera;
	import starling.display.Sprite;
	
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
	}

}