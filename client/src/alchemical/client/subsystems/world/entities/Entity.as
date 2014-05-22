/**
 * Copyright 2014, Dylan Heyes
 */
package alchemical.client.subsystems.world.entities 
{
	import alchemical.client.subsystems.world.model.TransformNode;
	import starling.display.Sprite;
	
	/**
	 * Entity
	 * @author Dylan Heyes
	 */
	public class Entity extends Sprite
	{
		/**
		 * Constructor.
		 */
		public function Entity() 
		{
			_transform = new TransformNode();
		}
		
		
		
		// API
		// =========================================================================================
		
		public function project(camera:Camera):void 
		{
			trace(camera.x, camera.y);
			this.x = transform.x - camera.x;
			this.y = transform.y - camera.y;
			this.rotation = transform.rotation;
		}
		
		
		
		// ACCESSORS
		// =========================================================================================
		
		/**
		 * Entity transform node.
		 */
		public function get transform():TransformNode		{ return _transform; }
		private var _transform:TransformNode;
	}

}