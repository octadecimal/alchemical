/**
 * Copyright 2014, Dylan Heyes
 */
package alchemical.client.subsystems.ui.controls 
{
	import starling.display.Button;
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
			
		}
		
	}

}