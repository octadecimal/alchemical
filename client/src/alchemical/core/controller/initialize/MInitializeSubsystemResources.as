/**
 * Copyright 2014, Dylan Heyes
 */
package alchemical.core.controller.initialize 
{
	import alchemical.subsystems.resources.controller.CLoadManifest;
	import alchemical.subsystems.resources.controller.CParseManifest;
	import org.puremvc.as3.patterns.command.AsyncMacroCommand;
	
	/**
	 * MInitializeSubsystemResources
	 * @author Dylan Heyes
	 */
	public class MInitializeSubsystemResources extends AsyncMacroCommand 
	{
		override protected function initializeAsyncMacroCommand():void 
		{
			addSubCommand(CLoadManifest);
			addSubCommand(CParseManifest);
		}
	}

}