/**
 * Copyright 2014, Dylan Heyes
 */
package alchemical.client.game.mediator 
{
	import alchemical.client.core.enum.ComponentNames;
	import alchemical.client.core.notes.ApplicationNotes;
	import alchemical.client.core.notes.WorldNotes;
	import alchemical.client.debugger.Debugger;
	import alchemical.client.core.notes.GameNotes;
	import alchemical.client.game.Game;
	import alchemical.client.core.notes.NetworkNotes;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.mediator.Mediator;
	import starling.events.EnterFrameEvent;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	
	/**
	 * GameMediator
	 * @author Dylan Heyes
	 */
	public class GameMediator extends Mediator 
	{
		private var _view:Game;
		
		/**
		 * Constructor.
		 * @param	viewComponent
		 */
		public function GameMediator(viewComponent:Game) 
		{
			_view = Game(viewComponent);
			
			super(ComponentNames.GAME, viewComponent);	
			Debugger.log(this, "Created.");
		}
		
		
		
		// INTERNAL OVERRIDES
		// =========================================================================================
		
		override public function listNotificationInterests():Array 
		{
			var interests:Array = super.listNotificationInterests();
			
			interests.push(NetworkNotes.LOGIN_SUCCESSFUL);
			interests.push(WorldNotes.WORLD_READY);
			
			return interests;
		}
		
		override public function handleNotification(notification:INotification):void 
		{
			switch(notification.getName())
			{
				case NetworkNotes.LOGIN_SUCCESSFUL:
					handleNetworkLoginSuccessful(notification);
					break;
				
				case WorldNotes.WORLD_READY:
					handleWorldReady(notification);
					break;
			}
			
			super.handleNotification(notification);
		}
		
		
		
		// EVENTS
		// =========================================================================================
		
		private function onGameUpdate(e:EnterFrameEvent):void 
		{
			sendNotification(ApplicationNotes.UPDATE_TICK, e.passedTime);
		}
		
		
		
		// NOTIFICATIONS
		// =========================================================================================
		
		private function handleNetworkLoginSuccessful(notification:INotification):void 
		{
			// Login success, launch game
			sendNotification(GameNotes.LAUNCH_GAME, notification.getBody());
		}
		
		private function handleWorldReady(notification:INotification):void 
		{
			// Start update ticks
			_view.addEventListener(EnterFrameEvent.ENTER_FRAME, onGameUpdate);
		}
	}

}