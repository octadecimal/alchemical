/**
 * Copyright 2014, Dylan Heyes
 */
package alchemical.client.subsystems.world.mediator 
{
	import alchemical.client.core.architecture.SubsystemMediator;
	import alchemical.client.core.enum.ComponentNames;
	import alchemical.client.core.notes.NetworkNotes;
	import alchemical.client.debugger.Debugger;
	import alchemical.client.subsystems.world.World;
	import org.puremvc.as3.interfaces.INotification;
	
	/**
	 * WorldMediator
	 * @author Dylan Heyes
	 */
	public class WorldMediator extends SubsystemMediator 
	{
		/**
		 * Constructor.
		 * @param	viewComponent
		 */
		public function WorldMediator(viewComponent:World) 
		{
			super(ComponentNames.WORLD, viewComponent);
			Debugger.log(this, "Created.");
		}
		
		
		
		// INTERNAL OVERRIDES
		// =========================================================================================
		
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