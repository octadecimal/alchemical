/**
 * Copyright 2014, Dylan Heyes
 */
package alchemical.client.subsystems.ui.mediator 
{
	import alchemical.client.core.architecture.SubsystemMediator;
	import alchemical.client.core.enum.ComponentNames;
	import alchemical.client.core.notes.ApplicationNotes;
	import alchemical.client.core.notes.GameNotes;
	import alchemical.client.core.notes.NetworkNotes;
	import alchemical.client.core.notes.UINotes;
	import alchemical.client.core.notes.WorldNotes;
	import alchemical.client.debugger.Debugger;
	import alchemical.client.subsystems.input.model.InputProxy;
	import alchemical.client.subsystems.ui.events.UIEvent;
	import alchemical.client.subsystems.ui.UILayer;
	import org.puremvc.as3.interfaces.INotification;
	import starling.animation.Tween;
	import starling.core.Starling;
	import starling.display.Quad;
	
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
			interests.push(NetworkNotes.CONNECTED);
			interests.push(NetworkNotes.DISCONNECTED);
			interests.push(ApplicationNotes.SYSTEM_READY);
			interests.push(GameNotes.LAUNCH_GAME);
			interests.push(WorldNotes.WORLD_READY);
			interests.push(UINotes.CHATBOX_FOCUSED);
			interests.push(UINotes.CHATBOX_UNFOCUSED);
			return interests;
		}
		
		override public function handleNotification(notification:INotification):void 
		{
			switch(notification.getName())
			{
				case NetworkNotes.CONNECTED:
					handleNetworkConnected(notification);
					break;
				
				case NetworkNotes.DISCONNECTED:
					handleNetworkDisconnected(notification);
					break;
				
				case ApplicationNotes.SYSTEM_READY:
					handleSystemReady(notification);
					break;
				
				case GameNotes.LAUNCH_GAME:
					handleLaunchGame(notification);
					break;
				
				case WorldNotes.WORLD_READY:
					handleWorldReady(notification);
					break;
				
				case UINotes.CHATBOX_FOCUSED:
					handleChatboxFocused(notification);
					break;
				
				case UINotes.CHATBOX_UNFOCUSED:
					handleChatboxUnfocused(notification);
					break;
			}
			
			super.handleNotification(notification);
		}
		
		
		
		// NOTIFICATION HANDLERS
		// =========================================================================================
		
		private function handleNetworkConnected(notification:INotification):void 
		{
			if (_view.loginScreen)
			{
				_view.loginScreen..showConnectedState();
			}
		}
		
		private function handleNetworkDisconnected(notification:INotification):void 
		{
			if (_view.loginScreen)
			{
				_view.loginScreen.showDisconnectedState();
			}
		}
		
		private function handleSystemReady(notification:INotification):void 
		{
			sendNotification(UINotes.DISPLAY_LOGIN_SCREEN);
		}
		
		private function handleLaunchGame(notification:INotification):void 
		{
			_view.loginScreen.hide();
			_view.loginScreen = null;
			
			_overlay = new Quad(1920, 1080, 0);
			_view.stage.addChild(_overlay);
		}
		
		private function handleWorldReady(notification:INotification):void 
		{
			var tween:Tween = new Tween(_overlay, 0.5);
			tween.fadeTo(0);
			tween.onComplete = function ():void
			{
				_overlay.removeFromParent();
			};
			
			Starling.juggler.add(tween);
		}
		
		private var _overlay:Quad;	// Test
		
		private function handleChatboxFocused(notification:INotification):void 
		{
			// Set UI as focus
			var inputProxy:InputProxy = facade.retrieveProxy(ComponentNames.INPUT) as InputProxy;
			inputProxy.focus = ComponentNames.UI;
		}
		
		private function handleChatboxUnfocused(notification:INotification):void 
		{
			// Set world as focus
			var inputProxy:InputProxy = facade.retrieveProxy(ComponentNames.INPUT) as InputProxy;
			inputProxy.focus = ComponentNames.WORLD;
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