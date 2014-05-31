/**
 * Copyright 2014, Dylan Heyes
 */
package alchemical.core 
{
	import alchemical.core.controller.startup.MStartup;
	import alchemical.core.model.vo.StartupVO;
	import alchemical.core.notifications.ApplicationNotifications;
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
			sendNotification(ApplicationNotifications.STARTUP, vo);
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
			registerCommand(ApplicationNotifications.STARTUP, MStartup);
		}
	}

}