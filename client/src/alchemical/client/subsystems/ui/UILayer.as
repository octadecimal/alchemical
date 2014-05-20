/**
 * Copyright 2014, Dylan Heyes
 */
package alchemical.client.subsystems.ui 
{
	import alchemical.client.subsystems.ui.controls.UIButton;
	import alchemical.client.subsystems.ui.events.UIEvent;
	import alchemical.client.subsystems.ui.screens.LoginScreen;
	import starling.display.Sprite;
	import starling.events.TouchEvent;
	
	/**
	 * UILayer
	 * @author Dylan Heyes
	 */
	public class UILayer extends Sprite 
	{
		/**
		 * Constructor.
		 */
		public function UILayer() 
		{
			super();
		}
		
		
		
		// API
		// =========================================================================================
		
		
		
		
		// ACCESSORS
		// =========================================================================================
		
		/**
		 * Login screen.
		 */
		public function set loginScreen(a:LoginScreen):void	{ _loginScreen = a; }
		public function get loginScreen():LoginScreen		{ return _loginScreen; }
		private var _loginScreen:LoginScreen;
	}

}