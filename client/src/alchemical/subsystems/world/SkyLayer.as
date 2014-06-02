/**
 * Copyright 2014, Dylan Heyes
 */
package alchemical.subsystems.world 
{
	import alchemical.core.display.ScrollableImage;
	import alchemical.debug.Debugger;
	import org.osflash.signals.Signal;
	import starling.textures.Texture;
	
	/**
	 * SkyLayer
	 * @author Dylan Heyes
	 */
	public class SkyLayer extends ScrollableImage 
	{
		public var sigOnDispose:Signal = new Signal(SkyLayer);
		public var id:int;
		
		public function SkyLayer(id:int, texture:Texture) 
		{
			this.id = id;
			super(texture);
			if (CONFIG::debug) Debugger.data(this, "Created.");
		}
		
		override public function dispose():void 
		{
			sigOnDispose.dispatch(this);
			if (CONFIG::debug) Debugger.data(this, "Disposed.");
			super.dispose();
		}
		
	}

}