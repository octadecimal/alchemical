/**
 * Copyright 2014, Dylan Heyes
 */
package alchemical.client.subsystems.world 
{
	import alchemical.client.core.display.ScrollableImage;
	import starling.events.EnterFrameEvent;
	import starling.textures.Texture;
	
	/**
	 * SkyLayer
	 * @author Dylan Heyes
	 */
	public class SkyLayer extends ScrollableImage
	{
		private var TEMP:Number = Math.random() * 1 + 0.35;
		
		public function SkyLayer(texture:Texture) 
		{
			super(texture);
			
			addEventListener(EnterFrameEvent.ENTER_FRAME, onUpdate);
		}
		
		private function onUpdate(e:EnterFrameEvent):void 
		{
			//scrollX += TEMP;
			//scrollY += TEMP;
		}
		
	}

}