/**
 * Copyright 2014, Dylan Heyes
 */
package alchemical.client.core.controller 
{
	import alchemical.client.subsystems.input.controller.MInitializeInput;
	import alchemical.client.subsystems.ui.controller.MInitializeUI;
	import org.puremvc.as3.patterns.command.AsyncMacroCommand;
	
	/**
	 * MInitializeSubsystems
	 * @author Dylan Heyes
	 */
	public class MInitializeSubsystems extends AsyncMacroCommand 
	{
		override protected function initializeAsyncMacroCommand():void 
		{
			addSubCommand(MInitializeInput);
			addSubCommand(MInitializeUI);
		}
	}

}