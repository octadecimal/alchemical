/**
 * Copyright 2014, Dylan Heyes
 */
package alchemical.client.subsystems.world.entities 
{
	import alchemical.client.subsystems.world.model.DynamicsNode;
	import alchemical.client.subsystems.world.model.TransformNode;
	import starling.display.DisplayObject;
	import starling.display.Sprite;
	
	/**
	 * Entity
	 * @author Dylan Heyes
	 */
	public class Entity
	{
		private static const HALF_PI:Number = Math.PI / 2;
		
		/**
		 * Constructor.
		 */
		public function Entity(id:int, view:DisplayObject = null, transform:TransformNode = null, dynamics:DynamicsNode = null) 
		{
			_id = id;
			_view = view;
			_transform = transform ? transform : new TransformNode();
			_dynamics = dynamics;
		}
		
		
		
		// API
		// =========================================================================================
		
		public function project(camera:Camera):void 
		{
			view.x = transform.x - camera.transform.x;
			view.y = transform.y - camera.transform.y;
			view.rotation = transform.rotation + HALF_PI;
		}
		
		
		
		// ACCESSORS
		// =========================================================================================
		
		/**
		 * Unique entity id as also defined on the server.
		 */
		public function get id():int							{ return _id; }
		private var _id:int;
		
		/**
		 * Entity view.
		 */
		public function set view(a:DisplayObject):void			{ _view = a; }
		public function get view():DisplayObject				{ return _view; }
		protected var _view:DisplayObject; 
		
		/**
		 * Entity transform node.
		 */
		 public function set transform(a:TransformNode):void	{ _transform = a; }
		 public function get transform():TransformNode			{ return _transform; }
		 private var _transform:TransformNode;
		 
		 /**
		  * Entity dynamics node.
		  */
		 public function set dynamics(a:DynamicsNode):void		{ _dynamics = a; }
		 public function get dynamics():DynamicsNode			{ return _dynamics; }
		 private var _dynamics:DynamicsNode;
	}

}