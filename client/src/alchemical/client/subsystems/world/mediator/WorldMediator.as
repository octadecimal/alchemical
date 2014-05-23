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
			_view.addEventListener(TouchEvent.TOUCH, onTouch);
		}
		
		override public function listNotificationInterests():Array 
		{
			var interests:Array = super.listNotificationInterests();
			interests.push(WorldNotes.WORLD_READY);
			return interests;
		}
		
		override public function handleNotification(notification:INotification):void
		{
			
			super.handleNotification(notification);
		}
		
		
		
		// EVENTS
		// =========================================================================================
		
		private function onTouch(e:TouchEvent):void 
		{
			var touchEnded:Touch = e.getTouch(_view, TouchPhase.ENDED);
			
			if (touchEnded)
			{
				onViewClicked(e, touchEnded);
			}
		}
		
		private function onViewClicked(e:TouchEvent, touch:Touch):void 
		{
			sendNotification(WorldNotes.WORLD_CLICKED, touch.getLocation(_view));
		}
	}

}