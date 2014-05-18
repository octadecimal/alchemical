/**
 * Copyright 2014, Dylan Heyes
 */
package alchemical.client.subsystems.ui.controller 
{
	import org.puremvc.as3.patterns.command.AsyncMacroCommand;
	
	/**
	 * MInitializeUI
	 * @author Dylan Heyes
	 */
	public class MInitializeUI extends AsyncMacroCommand 
	{
		override protected function initializeAsyncMacroCommand():void 
		{
			addSubCommand(CLoadControlTextures);
		}
	}

}