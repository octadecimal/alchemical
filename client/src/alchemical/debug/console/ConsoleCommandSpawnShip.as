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
			
			if (args.length > 1)
			{
				var transforms:Array = String(args[1]).split(",");
				
				vo.x = transforms[0];
				vo.y = transforms[1];
				
				if (transforms.length > 2)
				{
					vo.r = transforms[2];
				}
			}
			
			ApplicationFacade.instance.sendNotification(WorldNotifications.SPAWN_SHIP, vo);
		}
		
		override public function help(overlay:DebuggerOverlay):void 
		{
			super.help(overlay);
		}
	}

}