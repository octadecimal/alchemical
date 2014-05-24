/**
 * Copyright 2014, Dylan Heyes
 */
package alchemical.client.subsystems.world.controller 
{
	import org.puremvc.as3.patterns.command.AsyncMacroCommand;
	
	/**
	 * MBuildWorld
	 * @author Dylan Heyes
	 */
	public class MBuildWorld extends AsyncMacroCommand 
	{
		override protected function initializeAsyncMacroCommand():void 
		{
			addSubCommand(CBuildSky);
			addSubCommand(CCreatePlayer);
			addSubCommand(CCreateNPCs);
			addSubCommand(CNotifyWorldReady);
		}
	}

}