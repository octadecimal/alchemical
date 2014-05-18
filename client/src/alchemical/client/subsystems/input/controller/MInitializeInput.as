/**
 * Copyright 2014, Dylan Heyes
 */
package alchemical.client.subsystems.input.controller 
{
	import org.puremvc.as3.patterns.command.AsyncMacroCommand;
	
	/**
	 * MInitializeInput
	 * @author Dylan Heyes
	 */
	public class MInitializeInput extends AsyncMacroCommand 
	{
		override protected function initializeAsyncMacroCommand():void 
		{
			// Register ascii codes
			addSubCommand(CRegisterAsciiCodes);
			
			// Regiser actions
			addSubCommand(CRegisterActions);
			
			// Load controls xml data
			addSubCommand(CLoadControls);
			
			// Parse controls
			addSubCommand(CParseControls);
		}
	}

}