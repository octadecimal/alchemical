/**
 * Copyright 2014, Dylan Heyes
 */
package alchemical.client.subsystems.ui.model 
{
	import alchemical.client.core.enum.ComponentNames;
	import alchemical.client.debugger.Debugger;
	import org.puremvc.as3.patterns.proxy.Proxy;
	import starling.textures.TextureAtlas;
	
	/**
	 * UIProxy
	 * @author Dylan Heyes
	 */
	public class UIProxy extends Proxy 
	{
		/**
		 * Constructor.
		 * @param	data
		 */
		public function UIProxy(data:Object=null) 
		{
			super(ComponentNames.UI, data);
			Debugger.log(this, "Created.");
		}
		
		
		
		// ACCESSORS
		// =========================================================================================
		
		/**
		 * Texture atlas: Controls
		 */
		public function set atlasControls(a:TextureAtlas):void	{ _atlasControls = a; }
		public function get atlasControls():TextureAtlas		{ return _atlasControls; }
		private var _atlasControls:TextureAtlas;
	}

}