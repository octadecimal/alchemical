/**
 * Copyright 2014, Dylan Heyes
 */
package alchemical.client.core.controller 
{
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
			addSubCommand(CCreateSubsystemAudio);
			addSubCommand(CCreateSubsystemNetwork);
			addSubCommand(CCreateSubsystemUI);
			addSubCommand(CCreateSubsystemWorld);
		}
	}

}