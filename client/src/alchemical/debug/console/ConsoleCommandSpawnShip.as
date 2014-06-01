/**
 * Copyright 2014, Dylan Heyes
 */
package alchemical.debug.console 
{
	import alchemical.core.ApplicationFacade;
	import alchemical.core.notifications.WorldNotifications;
	import alchemical.debug.DebuggerOverlay;
	import alchemical.subsystems.world.model.vo.spawn.SpawnShipVO;
	
	/**
	 * ConsoleCommandSpawnShip
	 * @author Dylan Heyes
	 */
	public class ConsoleCommandSpawnShip extends ConsoleCommand 
	{
		/**
		 * Constructor.
		 * @param	trigger
		 */
		public function ConsoleCommandSpawnShip(trigger:String) 
		{
			super(trigger);
		}
		
		
		
		// API
		// =========================================================================================
		
		override public function execute(overlay:DebuggerOverlay, args:Array = null):void 
		{
			super.execute(overlay, args);
			
			var id:int = args[0];
			
			var vo:SpawnShipVO = new SpawnShipVO(id);
			
			ApplicationFacade.instance.sendNotification(WorldNotifications.SPAWN_SHIP, vo);
		}
		
		override public function help(overlay:DebuggerOverlay):void 
		{
			super.help(overlay);
		}
	}

}