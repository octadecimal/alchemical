/**
 * Copyright 2014, Dylan Heyes
 */
package alchemical.client.subsystems.ui.controls 
{
	import starling.display.Button;
	import starling.filters.BlurFilter;
	import starling.textures.Texture;
	
	/**
	 * Button
	 * @author Dylan Heyes
	 */
	public class UIButton extends Button
	{
		
		public function UIButton(upState:Texture, text:String="", downState:Texture=null) 
		{
			super(upState, text, downState);
			
			fontName = "Century Gothic";
			fontSize = 15;
			fontBold = true;
			
			filter = BlurFilter.createDropShadow(2, 0.785, 0x0, 1, 0, 0.5);
		}
		
	}

}