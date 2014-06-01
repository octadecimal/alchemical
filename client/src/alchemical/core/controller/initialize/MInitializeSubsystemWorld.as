/**
 * Copyright 2014, Dylan Heyes
 */
package alchemical.core.controller.initialize 
{
	import alchemical.subsystems.world.controller.build.CLoadShipDefinitions;
	import alchemical.subsystems.world.controller.build.CParseShipDefinitions;
	import org.puremvc.as3.patterns.command.AsyncMacroCommand;
	
	/**
	 * MInitializeSubsystemWorld
	 * @author Dylan Heyes
	 */
	public class MInitializeSubsystemWorld extends AsyncMacroCommand 
	{
		override protected function initializeAsyncMacroCommand():void 
		{
			addSubCommand(CLoadShipDefinitions);
			addSubCommand(CParseShipDefinitions);
		}
	}

}