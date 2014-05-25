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
			// Create subsystems
			addSubCommand(MCreateSubsystems);
			
			// Create game
			addSubCommand(CCreateGame);
			
			// Register fonts
			addSubCommand(CRegisterFonts);
			
			// Create debugger
			addSubCommand(CCreateDebugger);
			
			// Initialize subsystems
			addSubCommand(MInitializeSubsystems);
			
			// Initialize game
			addSubCommand(MInitializeGame);
			
			// Notify of completion
			addSubCommand(CNotifySystemReady);
		}
	}

}