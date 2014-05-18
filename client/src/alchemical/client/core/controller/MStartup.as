/**
 * Copyright 2014, Dylan Heyes
 */
package alchemical.client.core.controller 
{
	import alchemical.client.game.controller.MInitializeGame;
	import org.puremvc.as3.patterns.command.AsyncMacroCommand;
	
	/**
	 * MStartup
	 * @author Dylan Heyes
	 */
	public class MStartup extends AsyncMacroCommand 
	{
		override protected function initializeAsyncMacroCommand():void 
		{
			// Create debugger
			addSubCommand(CCreateDebugger);
			
			// Create subsystems
			addSubCommand(MCreateSubsystems);
			
			// Create game
			addSubCommand(CCreateGame);
			
			// Initialize subsystems
			addSubCommand(MInitializeSubsystems);
			
			// Initialize game
			addSubCommand(MInitializeGame);
			
			// Notify of completion
			addSubCommand(CNotifySystemReady);
		}
	}

}