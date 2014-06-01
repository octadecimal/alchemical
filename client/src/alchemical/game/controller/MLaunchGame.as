/**
 * Copyright 2014, Dylan Heyes
 */
package alchemical.game.controller 
{
	import alchemical.subsystems.world.controller.build.MBuildWorld;
	import org.puremvc.as3.patterns.command.AsyncMacroCommand;
	
	/**
	 * MLaunchGame
	 * @author Dylan Heyes
	 */
	public class MLaunchGame extends AsyncMacroCommand 
	{
		override protected function initializeAsyncMacroCommand():void 
		{
			addSubCommand(MBuildWorld);
			addSubCommand(CBuildDisplayList);
		}
	}

}