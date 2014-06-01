/**
 * Copyright 2014, Dylan Heyes
 */
package alchemical.game.mediator 
{
	import alchemical.core.enum.ComponentNames;
	import alchemical.debug.Debugger;
	import alchemical.game.Game;
	import org.puremvc.as3.patterns.mediator.Mediator;
	
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
			if (CONFIG::debug) Debugger.data(this, "Created.");
		}
		
		
		
		// INTERNAL OVERRIDES
		// =========================================================================================
		
		/*override public function listNotificationInterests():Array 
		{
			var interests:Array = super.listNotificationInterests();
			
			interests.push(NetworkNotes.LOGIN_SUCCESSFUL);
			interests.push(WorldNotes.WORLD_READY);
			
			return interests;
		}*/
		
		/*override public function handleNotification(notification:INotification):void 
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
		}*/
		
		
		
		// EVENTS
		// =========================================================================================
		
		/*private function onGameUpdate(e:EnterFrameEvent):void 
		{
			sendNotification(ApplicationNotes.UPDATE_TICK, e.passedTime);
		}*/
		
		
		
		// NOTIFICATIONS
		// =========================================================================================
		
		/*private function handleNetworkLoginSuccessful(notification:INotification):void 
		{
			// Login success, launch game
			sendNotification(GameNotes.LAUNCH_GAME, notification.getBody());
		}*/
		
		/*private function handleWorldReady(notification:INotification):void 
		{
			// Start update ticks
			_view.addEventListener(EnterFrameEvent.ENTER_FRAME, onGameUpdate);
		}*/
	}

}