/**
 * Copyright 2014, Dylan Heyes
 */
package alchemical.client.subsystems.ui.mediator 
{
	import alchemical.client.core.architecture.SubsystemMediator;
	import alchemical.client.core.enum.ApplicationNotes;
	import alchemical.client.core.enum.ComponentNames;
	import alchemical.client.debugger.Debugger;
	import alchemical.client.game.enum.GameNotes;
	import alchemical.client.subsystems.network.enum.NetworkNotes;
	import alchemical.client.subsystems.ui.enum.UINotes;
	import alchemical.client.subsystems.ui.events.UIEvent;
	import alchemical.client.subsystems.ui.UILayer;
	import org.puremvc.as3.interfaces.INotification;
	
	/**
	 * UIMediator
	 * @author Dylan Heyes
	 */
	public class UIMediator extends SubsystemMediator 
	{
		/**
		 * Constructor.
		 * @param	viewComponent
		 */
		public function UIMediator(viewComponent:UILayer) 
		{
			_view = viewComponent as UILayer;
			super(ComponentNames.UI, viewComponent);
			Debugger.log(this, "Created.");
			
			_view.addEventListener(UIEvent.PLAY_NOW_CLICKED, onPlayNowClicked);
		}
		
		
		
		// INTERNAL OVERRIDES
		// =========================================================================================
		
		override public function listNotificationInterests():Array 
		{
			var interests:Array = super.listNotificationInterests();
			interests.push(ApplicationNotes.SYSTEM_READY);
			interests.push(GameNotes.LAUNCH_GAME);
			return interests;
		}
		
		override public function handleNotification(notification:INotification):void 
		{
			switch(notification.getName())
			{
				case ApplicationNotes.SYSTEM_READY:
					handleSystemReady(notification);
					break;
				
				case GameNotes.LAUNCH_GAME:
					handleLaunchGame(notification);
					break;
			}
			
			super.handleNotification(notification);
		}
		
		
		
		// NOTIFICATION HANDLERS
		// =========================================================================================
		
		private function handleSystemReady(notification:INotification):void 
		{
			// Display login screen
			sendNotification(UINotes.DISPLAY_LOGIN_SCREEN);
		}
		
		private function handleLaunchGame(notification:INotification):void 
		{
			// Destroy login screen
			_view.loginScreen.hide();
		}
		
		
		
		// EVENT HANDLERS
		// =========================================================================================
		
		private function onPlayNowClicked(e:UIEvent):void 
		{
			//sendNotification(GameNotes.LAUNCH_GAME);
			sendNotification(NetworkNotes.LOGIN, e.data);
		}
		
		
		
		// PRIVATE
		// =========================================================================================
		
		private var _view:UILayer;
	}

}