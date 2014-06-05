/**
 * Copyright 2014, Dylan Heyes
 */
package alchemical.subsystems.ui.screens.options 
{
	import alchemical.debug.Debugger;
	import feathers.controls.Button;
	import starling.display.Sprite;
	
	/**
	 * OptionsScreen
	 * @author Dylan Heyes
	 */
	public class OptionsScreen extends Sprite 
	{
		
		public function OptionsScreen() 
		{
			super();
			if (CONFIG::debug) Debugger.data(this, "Created.");
			
			var button:Button = new Button();
			button.label = "OK";
			addChild(button);
		}
		
	}

}