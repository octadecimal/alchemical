/**
 * Copyright 2014, Dylan Heyes
 */
package alchemical.core.controller.initialize 
{
	import alchemical.core.controller.notify.CNotifySubsystemsInitialized;
	import org.puremvc.as3.patterns.command.AsyncMacroCommand;
	
	/**
	 * MInitializeSubsystems
	 * @author Dylan Heyes
	 */
	public class MInitializeSubsystems extends AsyncMacroCommand 
	{
		override protected function initializeAsyncMacroCommand():void 
		{
			addSubCommand(MInitializeSubsystemGraphics);
			addSubCommand(MInitializeSubsystemInput);
			addSubCommand(MInitializeSubsystemResources);
			addSubCommand(MInitializeSubsystemWorld);
			addSubCommand(CNotifySubsystemsInitialized);
		}
	}

}