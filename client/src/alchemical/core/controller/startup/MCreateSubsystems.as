/**
 * Copyright 2014, Dylan Heyes
 */
package alchemical.core.controller.startup 
{
	import alchemical.core.controller.notify.CNotifySubsystemsCreated;
	import org.puremvc.as3.patterns.command.AsyncMacroCommand;
	
	/**
	 * MCreateSubsystems
	 * @author Dylan Heyes
	 */
	public class MCreateSubsystems extends AsyncMacroCommand 
	{
		override protected function initializeAsyncMacroCommand():void 
		{
			addSubCommand(CCreateSubsystemGraphics);
			addSubCommand(CCreateSubsystemResources);
			addSubCommand(CCreateSubsystemInput);
			addSubCommand(CCreateSubsystemUI);
			addSubCommand(CCreateSubsystemWorld);
			addSubCommand(CNotifySubsystemsCreated);
		}
	}

}