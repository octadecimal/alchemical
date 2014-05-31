/**
 * Copyright 2014, Dylan Heyes
 */
package alchemical.core.controller.startup 
{
	import alchemical.core.controller.initialize.MInitializeSubsystems;
	import alchemical.core.controller.notify.CNotifySystemReady;
	import alchemical.debug.Debugger;
	import alchemical.debug.tests.MExecuteTestCases;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.AsyncMacroCommand;
	
	/**
	 * MStartup
	 * @author Dylan Heyes
	 */
	public class MStartup extends AsyncMacroCommand 
	{
		override protected function initializeAsyncMacroCommand():void 
		{
			if (CONFIG::debug) addSubCommand(CCreateDebugger);
			
			// Create subsystems
			addSubCommand(MCreateSubsystems);
			
			// Create game
			addSubCommand(CCreateGame);
			
			// Initialize subsystems
			addSubCommand(MInitializeSubsystems);
			
			// Debug test cases
			if (CONFIG::debug) addSubCommand(MExecuteTestCases);
			
			// System ready
			addSubCommand(CNotifySystemReady);
		}
	}

}