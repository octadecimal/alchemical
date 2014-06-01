/**
 * Copyright 2014, Dylan Heyes
 */
package alchemical.subsystems.world 
{
	import alchemical.subsystems.world.model.nodes.DynamicsNode;
	import alchemical.subsystems.world.model.nodes.TransformNode;
	import starling.display.DisplayObject;
	
	/**
	 * Entity
	 * @author Dylan Heyes
	 */
	public class Entity 
	{
		private static var ENITY_UID:int = 0;
		
		/**
		 * Constructor.
		 * @param	view		Entity view.
		 * @param	transform	Entity transform node.
		 * @param	dynamics	Entity dynamics node.
		 */
		public function Entity(view:DisplayObject = null, transform:TransformNode = null, dynamics:DynamicsNode = null) 
		{
			_id = ENITY_UID++;
			_view = view;
			_transform = transform;
			_dynamics = dynamics;
		}
		
		
		
		// API
		// =========================================================================================
		
		public function setView(view:DisplayObject):void
		{
			_view = view;
		}
		
		public function setTransform(transform:TransformNode):void
		{
			_transform = transform;
		}
		
		public function setDynamics(dynamics:DynamicsNode):void
		{
			_dynamics = dynamics;
		}
		
		
		
		// ACCESSORS
		// =========================================================================================
		
		/**
		 * Entity id.
		 */
		public function get id():int					{ return _id; }
		private var _id:int;
		
		/**
		 * Entity view.
		 */
		public function get view():DisplayObject		{ return _view; }
		private var _view:DisplayObject;
		
		/**
		 * Entity transform node.
		 */
		public function get transform():TransformNode	{ return _transform; }
		private var _transform:TransformNode;
		
		/**
		 * Entity dynamics node.
		 */
		public function get dynamics():DynamicsNode		{ return _dynamics; }
		private var _dynamics:DynamicsNode;
	}

}