/**
 * Copyright 2014, Dylan Heyes
 */
package alchemical.subsystems.resources.model 
{
	import alchemical.core.enum.ComponentNames;
	import alchemical.debug.Debugger;
	import alchemical.subsystems.resources.model.vo.ResourceVO;
	import alchemical.subsystems.resources.model.vo.TextureAtlasVO;
	import alchemical.subsystems.resources.model.vo.TextureVO;
	import alchemical.subsystems.resources.Resources;
	import alchemical.subsystems.world.SkyLayer;
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
		private var _atlasDependencies:Vector.<int>;
		
		/**
		 * Constructor.
		 */
		public function ResourcesProxy(resources:Resources) 
		{
			_resources = resources;
			
			super(ComponentNames.RESOURCES);
			
			_paths = new Dictionary();
			_textures = new Dictionary();
		}
		
		
		
		// INITIALIZE
		// =========================================================================================
		
		public function initialize():void
		{
			_atlasDependencies = new Vector.<int>(_atlases.length);
		}
		
		
		
		// LOADING API
		// =========================================================================================
		
		/**
		 * Declares a texture for usage.
		 * @param	name
		 */
		public function declareTexture(name:String):void
		{
			var vo:TextureVO = TextureVO(_textures[name]);
			var atlas:TextureAtlasVO = _atlases[vo.atlas];
			
			if (_atlasDependencies[int(vo.atlas)] == 0)
			{
				_atlasDependencies[int(vo.atlas)] = 1;
				atlas.loaded = true;
				enqueue(_paths["ships"], atlas.texture, true);
			}
			else
			{
				_atlasDependencies[int(vo.atlas)]++;
				if (CONFIG::debug) Debugger.data(this, "Texture already loaded: " + name + " -> " + vo.subtexture + " -> " + vo.atlas + " (" + _atlasDependencies[int(vo.atlas)] + " dependencies)");
			}
		}
		
		public function undeclareTexture(name:String):void
		{
			var vo:TextureVO = TextureVO(_textures[name]);
			var atlas:TextureAtlasVO = _atlases[vo.atlas];
			
			_atlasDependencies[int(vo.atlas)]--;
			
			if (_atlasDependencies[int(vo.atlas)] == 0)
			{
				_resources.removeTextureAtlas(atlas.texture);
				if (CONFIG::debug) Debugger.data(this, "Texture unloaded: " + name + " -> " + vo.subtexture + " -> " + vo.atlas + " (" + _atlasDependencies[int(vo.atlas)] + " dependencies)");
			}
			else
			{
				if (CONFIG::debug) Debugger.data(this, "Texture undeclared: " + name + " -> " + vo.subtexture + " -> " + vo.atlas + " (" + _atlasDependencies[int(vo.atlas)] + " dependencies)");
			}
			
		}
		
		/**
		 * Loads any enqueud textures.
		 * @param	onProgress
		 */
		public function load(onProgress:Function):void 
		{
			_resources.loadQueue(onProgress);
		}
		
		/**
		 * Enqueues a texture for loading.
		 * @param	path
		 * @param	texture
		 * @param	isAtlas
		 */
		private function enqueue(path:String, texture:String, isAtlas:Boolean = false):void
		{
			_resources.enqueue(File.applicationDirectory.resolvePath(path + texture + ".png"));
			
			if (isAtlas)
			{
				_resources.enqueue(File.applicationDirectory.resolvePath(path + texture + ".xml"));
			}
		}
		
		/**
		 * Retrieves a texture by name.
		 * @param	name
		 * @return
		 */
		public function getTexture(name:String):Texture
		{
			var texture:Texture = _resources.getTexture(TextureVO(_textures[name]).subtexture);
			
			if (texture == null)
			{
				if (CONFIG::debug) Debugger.log(this, "Attempted to retrieve null texture: " + name);
			}
			
			return texture;
		}
		
		/**
		 * Retrieves a set of textures by name.
		 * @param	name
		 * @return
		 */
		public function getTextures(name:String):Vector.<Texture>
		{
			return _resources.getTextures(TextureVO(_textures[name]).subtexture);
		}
		
		
		
		// SKY API
		// =========================================================================================
		
		/**
		 * Declares a sky texture.
		 * @param	id
		 */
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
		
		/**
		 * Undeclares a sky texture.
		 * @param	skyLayer
		 */
		public function undeclareSkyTexture(skyLayer:SkyLayer):void 
		{
			if (CONFIG::debug) Debugger.data(this, "Disposing sky layer: "+skyLayer.id + " -> " + _skies[skyLayer.id].texture);
			_skies[skyLayer.id].exists = false;
			skyLayer.texture.dispose();
		}
		
		/**
		 * Retrieves a sky texture.
		 * @param	id
		 * @return
		 */
		public function getSkyTexture(id:int):Texture
		{
			if (id < _skies.length)
			{
				var texture:Texture = _resources.getTexture(_skies[id].texture);
			
				if (texture == null)
				{
					if (CONFIG::debug) Debugger.log(this, "Attempted to retrieve null texture: " + id);
				}
				
				return texture;
			}
			else
			{
				if (CONFIG::debug) Debugger.log(this, "Failed to load sky texture: "+id);
				return null;
			}
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
		 * Initializes texture atlas lookup storage.
		 * @param	length
		 */
		public function initializeAtlases(length:int):void
		{
			_atlases = new Vector.<TextureAtlasVO>(length);
			if (CONFIG::debug) Debugger.log(this, "Initializing texture atlases: "+length);
		}
		
		/**
		 * Registers a texture atlas.
		 * @param	name
		 * @param	texture
		 */
		public function registerAtlas(vo:TextureAtlasVO):void 
		{
			_atlases[vo.id] = vo;
			if (CONFIG::debug) Debugger.data(this, "Atlas registered: " + vo.id + " -> " + vo.texture);
		}
		
		/**
		 * Registers a texture.
		 * @param	resourceVO
		 */
		public function registerTexture(vo:TextureVO):void 
		{
			_textures[vo.name] = vo;
			if (CONFIG::debug) Debugger.data(this, "Texture registered: " + vo.id + " -> " + vo.name + " -> " + vo.subtexture + " -> " + vo.atlas);
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
		public function get atlases():Vector.<TextureAtlasVO>	{ return _atlases; }
		private var _atlases:Vector.<TextureAtlasVO>;
		
		/**
		 * Textures.
		 */
		public function get textures():Dictionary				{ return _textures; }
		private var _textures:Dictionary;
		
		/**
		 * Sky textures.
		 */
		public function get skies():Vector.<ResourceVO>			{ return _skies; }
		private var _skies:Vector.<ResourceVO>;
		
	}

}