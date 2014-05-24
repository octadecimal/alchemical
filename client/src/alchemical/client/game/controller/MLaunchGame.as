/**
 * Copyright 2014, Dylan Heyes
 */
package alchemical.client.game.controller 
{
	import alchemical.client.subsystems.graphics.controller.CApplyDisplaySettings;
	import alchemical.client.subsystems.ui.controller.MCreateGameUI;
	import alchemical.client.subsystems.world.controller.CLoadShipTextures;
	import alchemical.client.subsystems.world.controller.MBuildWorld;
	import org.puremvc.as3.patterns.command.AsyncMacroCommand;
	
	/**
	 * MLaunchGame
	 * @author Dylan Heyes
	 */
	public class MLaunchGame extends AsyncMacroCommand 
	{
		override protected function initializeAsyncMacroCommand():void 
		{
			// Graphics
			addSubCommand(CApplyDisplaySettings);
			
			// World
			addSubCommand(CLoadShipTextures);
			addSubCommand(MBuildWorld);
			
			// UI
			addSubCommand(MCreateGameUI);
		}
	}
}