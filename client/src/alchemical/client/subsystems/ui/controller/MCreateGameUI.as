/**
 * Copyright 2014, Dylan Heyes
 */
package alchemical.client.subsystems.ui.controller 
{
	import org.puremvc.as3.patterns.command.MacroCommand;
	
	/**
	 * CCreateGameUI
	 * @author Dylan Heyes
	 */
	public class MCreateGameUI extends MacroCommand 
	{
		override protected function initializeMacroCommand():void 
		{
			// Create UI components
			addSubCommand(CCreateChatbox);
			
			// Build ui display list
			addSubCommand(CBuildUIDisplayList);
		}
	}

}