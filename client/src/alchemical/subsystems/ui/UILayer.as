/**
 * Copyright 2014, Dylan Heyes
 */
package alchemical.subsystems.ui 
{
	import alchemical.debug.Debugger;
	import starling.display.Sprite;
	
	/**
	 * UILayer
	 * @author Dylan Heyes
	 */
	public class UILayer extends Sprite 
	{
		
		public function UILayer() 
		{
			super();
			if (CONFIG::debug) Debugger.data(this, "Created.");
		}
		
	}

}