/**
 * Copyright 2014, Dylan Heyes
 */
package alchemical.subsystems.world 
{
	import alchemical.debug.Debugger;
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
			_entities = new Vector.<Entity>();
			super();
			if (CONFIG::debug) Debugger.data(this, "Created.");
		}
		
		
		
		// API
		// =========================================================================================
		
		public function addEntity(entity:Entity):void
		{
			_entities.push(entity);
			addChild(entity.view);
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
		 * World entities.
		 */
		public function get entities():Vector.<Entity>		{ return _entities; }
		private var _entities:Vector.<Entity>;
	}

}