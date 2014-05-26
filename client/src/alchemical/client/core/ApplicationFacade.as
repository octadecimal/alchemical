/**
 * Copyright 2014, Dylan Heyes
 */
package alchemical.client.core 
{
	import alchemical.client.core.controller.MStartup;
	import alchemical.client.core.controller.MUpdateTick;
	import alchemical.client.core.model.vo.StartupVO;
	import alchemical.client.core.notes.ApplicationNotes;
	import alchemical.client.core.notes.GameNotes;
	import alchemical.client.core.notes.NetworkNotes;
	import alchemical.client.core.notes.UINotes;
	import alchemical.client.core.notes.WorldNotes;
	import alchemical.client.debugger.Debugger;
	import alchemical.client.game.controller.MLaunchGame;
	import alchemical.client.subsystems.ui.controller.CDisplayScreenLogin;
	import alchemical.client.subsystems.world.controller.CDefineNPCs;
	import alchemical.client.subsystems.world.controller.CDefinePlayer;
	import alchemical.client.subsystems.world.controller.CDefineWorld;
	import alchemical.client.subsystems.world.controller.CHandleWorldClicked;
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
			sendNotification(ApplicationNotes.STARTUP, vo);
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
			registerCommand(ApplicationNotes.UPDATE_TICK, MUpdateTick);
			
			// Game
			registerCommand(GameNotes.LAUNCH_GAME, MLaunchGame);
			
			// UI
			registerCommand(UINotes.DISPLAY_LOGIN_SCREEN, CDisplayScreenLogin);
			
			// Network
			registerCommand(NetworkNotes.WORLD_DEFINED, CDefineWorld);
			registerCommand(NetworkNotes.PLAYER_DEFINED, CDefinePlayer);
			registerCommand(NetworkNotes.NPCS_DEFINED, CDefineNPCs);
			
			// World
			registerCommand(WorldNotes.WORLD_CLICKED, CHandleWorldClicked);
		}
		
		/**
		 * Send notification.
		 * @param	notificationName
		 * @param	body
		 * @param	type
		 */
		override public function sendNotification(notificationName:String, body:Object = null, type:String = null):void 
		{
			if (notificationName != ApplicationNotes.UPDATE_TICK && notificationName != NetworkNotes.TRANSFORM_NODE_RECEIVED)
			{
				Debugger.note(notificationName, body, type);
			}
			
			super.sendNotification(notificationName, body, type);
		}
	}

}