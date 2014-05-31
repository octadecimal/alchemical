/**
 * Copyright 2014, Dylan Heyes
 */
package alchemical.subsystems.world 
{
	import alchemical.core.display.ScrollableImage;
	import alchemical.debug.Debugger;
	import starling.textures.Texture;
	
	/**
	 * SkyLayer
	 * @author Dylan Heyes
	 */
	public class SkyLayer extends ScrollableImage 
	{
		
		public function SkyLayer(texture:Texture) 
		{
			super(texture);
			if (CONFIG::debug) Debugger.data(this, "Created.");
		}
		
		override public function dispose():void 
		{
			if (CONFIG::debug) Debugger.data(this, "Disposed.");
			super.dispose();
		}
		
	}

}