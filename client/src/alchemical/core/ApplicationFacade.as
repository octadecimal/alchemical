/**
 * Copyright 2014, Dylan Heyes
 */
package alchemical.core 
{
	import alchemical.core.controller.startup.MStartup;
	import alchemical.core.model.vo.StartupVO;
	import alchemical.core.notifications.ApplicationNotifications;
	import alchemical.core.notifications.InputNotifications;
	import alchemical.core.notifications.WorldNotifications;
	import alchemical.debug.Debugger;
	import alchemical.subsystems.world.controller.load.CLoadSky;
	import alchemical.subsystems.world.controller.spawn.MSpawnShip;
	import alchemical.subsystems.world.controller.update.MUpdateWorld;
	import org.puremvc.as3.patterns.facade.Facade;
	
	/**
	 * ApplicationFacade
	 * @author Dylan Heyes
	 */
	public class ApplicationFacade extends Facade 
	{
		// Singleton reference. Only allowed in debug mode.
		(CONFIG::debug) 
		static public var instance:ApplicationFacade;
		
		/**
		 * Constructor.
		 */
		public function ApplicationFacade() 
		{
			super();
			
			if (CONFIG::debug) instance = this;
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
			
			// World
			registerCommand(WorldNotifications.UDPATE_WORLD, MUpdateWorld);
			
			// Debug console
			if (CONFIG::debug)
			{
				registerCommand(WorldNotifications.LOAD_SKY, CLoadSky);
				registerCommand(WorldNotifications.SPAWN_SHIP, MSpawnShip);
			}
		}
		
		/**
		 * Send notification.
		 * @param	notificationName
		 * @param	body
		 * @param	type
		 */
		override public function sendNotification(notificationName:String, body:Object = null, type:String = null):void 
		{
			if (notificationName != InputNotifications.MOUSE_WHEEL && notificationName != InputNotifications.KEY_DOWN && notificationName != InputNotifications.KEY_UP
				&& notificationName != WorldNotifications.UDPATE_WORLD)
			{
				if(CONFIG::debug) Debugger.note(notificationName, body, type);
			}
			
			super.sendNotification(notificationName, body, type);
		}
	}

}