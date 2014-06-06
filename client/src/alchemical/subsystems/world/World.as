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
		private var _availableWorldIDs:Vector.<int>;
		
		/**
		 * Constructor.
		 */
		public function World() 
		{
			_entities = new Vector.<Entity>();
			_availableWorldIDs = new Vector.<int>();
			super();
			if (CONFIG::debug) Debugger.data(this, "Created.");
		}
		
		
		
		// API
		// =========================================================================================
		
		public function addEntity(entity:Entity):void
		{
			entity.worldID = getNextAvailableWorldID();
			_entities[entity.worldID] = entity;
			addChild(entity.view);
			if (CONFIG::debug) Debugger.log(this, "Entity added: " + entity.worldID + " (" + entity.id+ ")");
		}
		
		public function removeEntity(worldID:int):void
		{
			var entity:Entity = _entities[worldID];
			_entities[worldID] = null;
			removeChild(entity.view);
			_availableWorldIDs.push(worldID);
			if (CONFIG::debug) Debugger.log(this, "Entity removed: " + entity.worldID + " (" + entity.id+ ")");
		}
		
		public function getEntity(worldID:int):Entity
		{
			return _entities[worldID];
		}
		
		
		
		// INTERNAL
		// =========================================================================================
		
		private function getNextAvailableWorldID():int
		{
			if (_availableWorldIDs.length == 0)
			{
				return _entities.length;
			}
			else
			{
				return _availableWorldIDs.pop();
			}
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