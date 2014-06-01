/**
 * Copyright 2014, Dylan Heyes
 */
package alchemical.debug.console 
{
	import alchemical.core.ApplicationFacade;
	import alchemical.core.notifications.WorldNotifications;
	import alchemical.debug.DebuggerOverlay;
	import alchemical.subsystems.world.model.vo.SkyVO;
	
	/**
	 * ConsoleCommandLoadSky
	 * @author Dylan Heyes
	 */
	public class ConsoleCommandLoadSky extends ConsoleCommand 
	{
		/**
		 * Constructor.
		 * @param	trigger
		 */
		public function ConsoleCommandLoadSky(trigger:String) 
		{
			super(trigger);
		}
		
		
		
		// API
		// =========================================================================================
		
		override public function execute(overlay:DebuggerOverlay, args:Array = null):void 
		{
			super.execute(overlay, args);
			
			if (args == null || args.length == 0)
			{
				overlay.addLine("Expected arguments. Use `" + trigger + " help` command for more.");
			}
			else
			{
				var layerIDs:Array = String(args[0]).split(",");
				var layers:Vector.<int> = new Vector.<int>(layerIDs.length);
				
				for (var i:int = 0; i < layerIDs.length; i++)
				{
					layers[i] = layerIDs[i];
				}
				
				var vo:SkyVO = new SkyVO(layers);
				
				ApplicationFacade.instance.sendNotification(WorldNotifications.LOAD_SKY, vo);
			}
		}
		
		override public function help(overlay:DebuggerOverlay):void 
		{
			overlay.addLine("Command: " + trigger);
			overlay.addLine("Description: Loads a sky with a passed amount of input textures");
			overlay.addLine("Example: load_sky 0,5,3");
		}
	}

}