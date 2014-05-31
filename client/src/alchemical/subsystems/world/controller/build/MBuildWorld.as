/**
 * Copyright 2014, Dylan Heyes
 */
package alchemical.subsystems.world.controller.build 
{
	import org.puremvc.as3.patterns.command.AsyncMacroCommand;
	
	/**
	 * CBuildWorld
	 * @author Dylan Heyes
	 */
	public class MBuildWorld extends AsyncMacroCommand 
	{
		override protected function initializeAsyncMacroCommand():void 
		{
			addSubCommand(CBuildSky);
		}
	}

}