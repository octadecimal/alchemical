/**
 * Copyright 2014, Dylan Heyes
 */
package alchemical.client.subsystems.world.mediator 
{
	import alchemical.client.core.architecture.SubsystemMediator;
	import alchemical.client.core.enum.ComponentNames;
	import alchemical.client.core.notes.NetworkNotes;
	import alchemical.client.core.notes.WorldNotes;
	import alchemical.client.debugger.Debugger;
	import alchemical.client.subsystems.world.World;
	import org.puremvc.as3.interfaces.INotification;
	import starling.events.Event;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	
	/**
	 * WorldMediator
	 * @author Dylan Heyes
	 */
	public class WorldMediator extends SubsystemMediator 
	{
		// World view
		private var _view:World;
		
		/**
		 * Constructor.
		 * @param	viewComponent
		 */
		public function WorldMediator(viewComponent:World) 
		{
			_view = World(viewComponent);
			super(ComponentNames.WORLD, viewComponent);
			Debugger.log(this, "Created.");
		}
		
		
		
		// INTERNAL OVERRIDES
		// =========================================================================================
		
		override public function onRegister():void
		{
			_view.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		override public function listNotificationInterests():Array 
		{
			var interests:Array = super.listNotificationInterests();
			interests.push(NetworkNotes.WORLD_DEFINED);
			interests.push(NetworkNotes.PLAYER_DEFINED);
			return interests;
		}
		
		override public function handleNotification(notification:INotification):void
		{
			switch(notification.getName())
			{
				case NetworkNotes.WORLD_DEFINED:
					handleNetworkDefinedWorld(notification);
					break;
				
				case NetworkNotes.PLAYER_DEFINED:
					handleNetworkDefinedPlayer(notification);
					break;
			}
		}
		
		
		
		// EVENTS
		// =========================================================================================
		
		private function onAddedToStage(e:Event):void 
		{
			_view.removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			_view.stage.addEventListener(TouchEvent.TOUCH, onTouch);
		}
		
		private function onTouch(e:TouchEvent):void 
		{
			var touchEnded:Touch = e.getTouch(_view.stage, TouchPhase.ENDED);
			
			if (touchEnded)
			{
				onViewClicked(e, touchEnded);
			}
		}
		
		private function onViewClicked(e:TouchEvent, touch:Touch):void 
		{
			sendNotification(WorldNotes.WORLD_CLICKED, touch.getLocation(_view.stage));
		}
		
		
		
		// NOTIFICATIONS
		// =========================================================================================
		
		private function handleNetworkDefinedWorld(notification:INotification):void 
		{
			
		}
		
		private function handleNetworkDefinedPlayer(notification:INotification):void 
		{
			
		}
	}

}