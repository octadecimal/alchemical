/**
 * Copyright 2014, Dylan Heyes
 */
package alchemical.subsystems.resources.model 
{
	import alchemical.core.enum.ComponentNames;
	import alchemical.debug.Debugger;
	import flash.utils.Dictionary;
	import org.puremvc.as3.patterns.proxy.Proxy;
	
	/**
	 * ResourcesProxy
	 * @author Dylan Heyes
	 */
	public class ResourcesProxy extends Proxy 
	{
		/**
		 * Constructor.
		 */
		public function ResourcesProxy() 
		{
			super(ComponentNames.RESOURCES);
			
			_paths = new Dictionary();
			_atlases = new Dictionary();
		}
		
		
		
		// API
		// =========================================================================================
		
		public function registerPath(name:String, path:String):void
		{
			_paths[name] = path;
			
			if (CONFIG::debug) Debugger.data(this, "Path registered: " + name + " -> " + path);
		}
		
		public function registerAtlas(name:String, texture:String):void 
		{
			_atlases[name] = texture;
			
			if (CONFIG::debug) Debugger.data(this, "Atlas registered: " + name + " -> " + texture);
		}
		
		
		
		// ACCESSORS
		// =========================================================================================
		
		/**
		 * Manifest xml.
		 */
		public function set manifestData(a:XML):void	{ _manifestData = a; }
		public function get manifestData():XML			{ return _manifestData; }
		private var _manifestData:XML;
		
		/**
		 * Resource paths.
		 */
		public function get paths():Dictionary			{ return _paths; }
		private var _paths:Dictionary;
		
		/**
		 * Texture atlases.
		 */
		public function get atlases():Dictionary		{ return _atlases; }
		private var _atlases:Dictionary;
	}

}