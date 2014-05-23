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
		public function SkyLayer(texture:Texture) 
		{
			super(texture);
		}
		
	}

}