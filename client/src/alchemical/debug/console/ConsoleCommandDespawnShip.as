/**
 * Copyright 2014, Dylan Heyes
 */
package alchemical.debug.console 
{
	import alchemical.core.ApplicationFacade;
	import alchemical.core.notifications.WorldNotifications;
	import alchemical.debug.DebuggerOverlay;
	import alchemical.subsystems.world.model.vo.spawn.DespawnShipVO;
	/**
	 * ConsoleCommandDespawnShip
	 * @author Dylan Heyes
	 */
	public class ConsoleCommandDespawnShip extends ConsoleCommand 
	{
		/**
		 * Constructor.
		 * @param	trigger
		 */
		public function ConsoleCommandDespawnShip(trigger:String) 
		{
			super(trigger);
		}
		
		
		
		// API
		// =========================================================================================
		
		override public function execute(overlay:DebuggerOverlay, args:Array = null):void 
		{
			super.execute(overlay, args);
			
			var id:int = args[0];
			
			ApplicationFacade.instance.sendNotification(WorldNotifications.DESPAWN_SHIP, new DespawnShipVO(id));
		}
	}

}