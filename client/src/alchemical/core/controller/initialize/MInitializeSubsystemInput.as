/**
 * Copyright 2014, Dylan Heyes
 */
package alchemical.core.controller.initialize 
{
	import alchemical.subsystems.input.controller.CLoadControls;
	import alchemical.subsystems.input.controller.CParseControls;
	import alchemical.subsystems.input.controller.CRegisterActions;
	import alchemical.subsystems.input.controller.CRegisterAsciiCodes;
	import org.puremvc.as3.patterns.command.AsyncMacroCommand;
	
	/**
	 * MInitializeInput
	 * @author Dylan Heyes
	 */
	public class MInitializeSubsystemInput extends AsyncMacroCommand 
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