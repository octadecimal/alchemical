/**
 * Copyright 2014, Dylan Heyes
 */
package alchemical.subsystems.world.controller.spawn 
{
	import org.puremvc.as3.patterns.command.AsyncMacroCommand;
	
	/**
	 * MSpawnShip
	 * @author Dylan Heyes
	 */
	public class MSpawnShip extends AsyncMacroCommand 
	{
		override protected function initializeAsyncMacroCommand():void 
		{
			addSubCommand(CLoadShipTextures);
		}
	}

}