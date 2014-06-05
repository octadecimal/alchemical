/**
 * Copyright 2014, Dylan Heyes
 */
package alchemical.subsystems.world 
{
	import alchemical.core.display.ScrollableImage;
	import alchemical.core.interfaces.IDisposable;
	import alchemical.debug.Debugger;
	import starling.events.EnterFrameEvent;
	import starling.textures.Texture;
	
	/**
	 * SkyLayer
	 * @author Dylan Heyes
	 */
	public class SkyLayer extends ScrollableImage
	{
		public var id:int;
		
		/**
		 * Constructor.
		 * @param	id
		 * @param	texture
		 */
		public function SkyLayer(id:int, texture:Texture) 
		{
			this.id = id;
			super(texture);
			if (CONFIG::debug) Debugger.data(this, "Created.");
			
			addEventListener(EnterFrameEvent.ENTER_FRAME, onUpdate);
		}
		
		private function onUpdate(e:EnterFrameEvent):void 
		{
			this.scrollX += e.passedTime * 1 * (id+1);
			this.scrollY += e.passedTime * 2 * (id+1);
		}
		
		/**
		 * Disposer.
		 */
		override public function dispose():void 
		{
			if (CONFIG::debug) Debugger.data(this, "Disposed.");
			super.dispose();
		}
		
	}

}