/**
 * Copyright 2014, Dylan Heyes
 */
package alchemical.subsystems.world 
{
	import alchemical.debug.Debugger;
	import org.osflash.signals.Signal;
	import starling.display.Sprite;
	
	/**
	 * World
	 * @author Dylan Heyes
	 */
	public class World extends Sprite 
	{
		public var sigSkyLayerDisposed:Signal = new Signal(SkyLayer);
		
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
			entity.worldID = _entities.length;
			_entities.push(entity);
			addChild(entity.view);
			if (CONFIG::debug) Debugger.log(this, "Entity added: " + entity.worldID + " (" + entity.id+ ")");
		}
		
		public function removeEntity(worldID:int):void
		{
			var entity:Entity = _entities[worldID];
			_entities.splice(worldID, 1);
			removeChild(entity.view);
			if (CONFIG::debug) Debugger.log(this, "Entity removed: " + entity.worldID + " (" + entity.id+ ")");
		}
		
		
		
		// SIGNALS
		// =========================================================================================
		
		private function onSkyLayerDisposed(skyLayer:SkyLayer):void 
		{
			sigSkyLayerDisposed.dispatch(skyLayer);
		}
		
		
		
		// ACCESSORS
		// =========================================================================================
		
		/**
		 * World sky.
		 */
		public function set sky(a:Sky):void		{ _sky = a; sky.sigLayerDisposed.add(onSkyLayerDisposed); }
		public function get sky():Sky			{ return _sky; }
		private var _sky:Sky;
		
		/**
		 * World entities.
		 */
		public function get entities():Vector.<Entity>		{ return _entities; }
		private var _entities:Vector.<Entity>;
	}

}