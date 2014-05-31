/**
 * Copyright 2014, Dylan Heyes
 */
package alchemical.subsystems.resources.model 
{
	import alchemical.core.enum.ComponentNames;
	import alchemical.debug.Debugger;
	import alchemical.subsystems.resources.model.vo.ResourceVO;
	import alchemical.subsystems.resources.Resources;
	import flash.filesystem.File;
	import flash.utils.Dictionary;
	import org.puremvc.as3.patterns.proxy.Proxy;
	import starling.textures.Texture;
	
	/**
	 * ResourcesProxy
	 * @author Dylan Heyes
	 */
	public class ResourcesProxy extends Proxy 
	{
		private var _resources:Resources;
		
		/**
		 * Constructor.
		 */
		public function ResourcesProxy(resources:Resources) 
		{
			_resources = resources;
			
			super(ComponentNames.RESOURCES);
			
			_paths = new Dictionary();
			_atlases = new Dictionary();
		}
		
		
		
		// LOADING API
		// =========================================================================================
		
		public function load(onProgress:Function):void 
		{
			_resources.loadQueue(onProgress);
		}
		
		public function declareSkyTexture(id:int):void 
		{
			if (id >= _skies.length)
			{
				if (CONFIG::debug) Debugger.error(this, "Sky texture not found in manifest: " + id);
				return;
			}
			
			var texture:String = _skies[id].texture;
			
			if (!_skies[id].exists)
			{
				if (CONFIG::debug) Debugger.data(this, "Sky texture not loaded, enqueuing: " + id + " -> " + _skies[id].texture);
				
				_skies[id].exists = true;
				enqueue(_paths["skies"], texture);
			}
			else
			{
				if (CONFIG::debug) Debugger.data(this, "Sky texture already loaded: " + id + " -> " + _skies[id].texture);
			}
		}
		
		private function enqueue(path:String, texture:String):void
		{
			if (CONFIG::debug) Debugger.enqueue(this, "Enqueuing: " + path + texture);
			_resources.enqueue(File.applicationDirectory.resolvePath(path + texture + ".png"));
		}
		
		public function getSkyTexture(id:int):Texture
		{
			if (id < _skies.length)
			{
				return getTexture(_skies[id].texture);
			}
			else
			{
				if (CONFIG::debug) Debugger.log(this, "Failed to load sky texture: "+id);
				return null;
			}
		}
		
		public function getTexture(name:String):Texture
		{
			var texture:Texture = _resources.getTexture(name);
			
			if (texture == null)
			{
				if (CONFIG::debug) Debugger.log(this, "Attempted to retrieve null texture: " + name);
			}
			
			return texture;
		}
		
		
		
		// REGISTRATION API
		// =========================================================================================
		
		/**
		 * Registers a texture path.
		 * @param	name
		 * @param	path
		 */
		public function registerPath(name:String, path:String):void
		{
			_paths[name] = path;
			if (CONFIG::debug) Debugger.data(this, "Path registered: " + name + " -> " + path);
		}
		
		/**
		 * Registers a texture atlas.
		 * @param	name
		 * @param	texture
		 */
		public function registerAtlas(name:String, texture:String):void 
		{
			_atlases[name] = texture;
			if (CONFIG::debug) Debugger.data(this, "Atlas registered: " + name + " -> " + texture);
		}
		
		/**
		 * Initializes sky lookup storage.
		 * @param	length
		 */
		public function initializeSkies(length:int):void 
		{
			_skies = new Vector.<ResourceVO>(length);
			if (CONFIG::debug) Debugger.log(this, "Initializing skies: "+length);
		}
		
		/**
		 * Registers a sky texture lookup.
		 * @param	vo
		 */
		public function registerSky(vo:ResourceVO):void
		{
			_skies[vo.id] = vo;
			if (CONFIG::debug) Debugger.data(this, "Sky registered: " + vo.id + " -> " + vo.texture);
		}
		
		/**
		 * Initializes hull lookup storage.
		 * @param	length
		 */
		public function initializeHulls(length:int):void 
		{
			_hulls = new Vector.<ResourceVO>(length);
			if (CONFIG::debug) Debugger.log(this, "Initializing hulls: "+length);
		}
		
		/**
		 * Registers a hull texture lookup.
		 * @param	vo
		 */
		public function registerHull(vo:ResourceVO):void
		{
			_hulls[vo.id] = vo;
			if (CONFIG::debug) Debugger.data(this, "Hull registered: " + vo.id + " -> " + vo.texture + " -> " + vo.atlas);
		}
		
		/**
		 * Initializes enginebay lookup storage.
		 * @param	length
		 */
		public function initializeEnginebays(length:int):void 
		{
			_enginebays = new Vector.<ResourceVO>(length);
			if (CONFIG::debug) Debugger.log(this, "Initializing enginebays: "+length);
		}
		
		/**
		 * Registers a enginebay texture lookup.
		 * @param	vo
		 */
		public function registerEnginebay(vo:ResourceVO):void
		{
			_enginebays[vo.id] = vo;
			if (CONFIG::debug) Debugger.data(this, "Enginebay registered: " + vo.id + " -> " + vo.texture + " -> " + vo.atlas);
		}
		
		
		
		// ACCESSORS
		// =========================================================================================
		
		/**
		 * Manifest xml.
		 */
		public function set manifestData(a:XML):void			{ _manifestData = a; }
		public function get manifestData():XML					{ return _manifestData; }
		private var _manifestData:XML;
		
		/**
		 * Resource paths.
		 */
		public function get paths():Dictionary					{ return _paths; }
		private var _paths:Dictionary;
		
		/**
		 * Texture atlases.
		 */
		public function get atlases():Dictionary				{ return _atlases; }
		private var _atlases:Dictionary;
		
		/**
		 * Sky textures.
		 */
		public function get skies():Vector.<ResourceVO>			{ return _skies; }
		private var _skies:Vector.<ResourceVO>;
		
		/**
		 * Hull textures.
		 */
		public function get hulls():Vector.<ResourceVO>			{ return _hulls; }
		private var _hulls:Vector.<ResourceVO>;
		
		/**
		 * Enginebay textures.
		 */
		public function get enginebays():Vector.<ResourceVO>	{ return _enginebays; }
		private var _enginebays:Vector.<ResourceVO>;
	}

}