/**
 * Copyright 2014, Dylan Heyes
 */
package alchemical.client.core 
{
	import alchemical.client.core.controller.MStartup;
	import alchemical.client.core.enum.ApplicationNotes;
	import alchemical.client.core.model.vo.StartupVO;
	import alchemical.client.debugger.Debugger;
	import alchemical.client.game.controller.MLaunchGame;
	import alchemical.client.subsystems.graphics.controller.CApplyDisplaySettings;
	import alchemical.client.game.enum.GameNotes;
	import alchemical.client.subsystems.ui.controller.CDisplayScreenLogin;
	import alchemical.client.core.enum.UINotes;
	import flash.display.Stage;
	import org.puremvc.as3.patterns.facade.Facade;
	
	/**
	 * ApplicationFacade
	 * @author Dylan Heyes
	 */
	public class ApplicationFacade extends Facade 
	{
		/**
		 * Constructor.
		 */
		public function ApplicationFacade() 
		{
			super();
		}
		
		
		
		// API
		// =========================================================================================
		
		/**
		 * Starts the application.
		 */
		public function startup(vo:StartupVO):void
		{
			//Debugger.log(this, "Starting up...");
			sendNotification(ApplicationNotes.STARTUP, vo);
			//Debugger.log(this, "Started up.");
		}
		
		
		
		// INTERNAL
		// =========================================================================================
		
		/**
		 * Command registration.
		 */
		override protected function initializeController():void 
		{
			super.initializeController();
			
			// Core
			registerCommand(ApplicationNotes.STARTUP, MStartup);
			
			// Game
			registerCommand(GameNotes.LAUNCH_GAME, MLaunchGame);
			
			// UI
			registerCommand(UINotes.DISPLAY_LOGIN_SCREEN, CDisplayScreenLogin);
		}
		
		/**
		 * Send notification.
		 * @param	notificationName
		 * @param	body
		 * @param	type
		 */
		override public function sendNotification(notificationName:String, body:Object = null, type:String = null):void 
		{
			Debugger.note(notificationName, body, type);
			
			super.sendNotification(notificationName, body, type);
		}
	}

}