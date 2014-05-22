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
	public class Entity
	{
		/**
		 * Constructor.
		 */
		public function Entity(view:Sprite = null) 
		{
			_view = view ? view : new Sprite();
			_transform = new TransformNode();
		}
		
		
		
		// API
		// =========================================================================================
		
		public function project(camera:Camera):void 
		{
			view.x = transform.x - camera.transform.x;
			view.y = transform.y - camera.transform.y;
			view.rotation = transform.rotation;
		}
		
		
		
		// ACCESSORS
		// =========================================================================================
		
		/**
		 * Entity view.
		 */
		public function set view(a:Sprite):void				{ _view = a; }
		public function get view():Sprite					{ return _view; }
		private var _view:Sprite; 
		
		/**
		 * Entity transform node.
		 */
		public function get transform():TransformNode		{ return _transform; }
		private var _transform:TransformNode;
	}

}