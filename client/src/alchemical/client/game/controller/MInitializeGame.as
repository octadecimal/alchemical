/**
 * Copyright 2014, Dylan Heyes
 */
package alchemical.client.game.controller 
{
	import org.puremvc.as3.patterns.command.AsyncMacroCommand;
	
	/**
	 * MInitializeGame
	 * @author Dylan Heyes
	 */
	public class MInitializeGame extends AsyncMacroCommand 
	{
		override protected function initializeAsyncMacroCommand():void 
		{
			addSubCommand(CBuildDisplayList);
		}
	}

}