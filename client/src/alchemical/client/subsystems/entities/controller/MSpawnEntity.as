/**
 * Copyright 2014, Dylan Heyes
 */
package alchemical.client.subsystems.entities.controller 
{
	import org.puremvc.as3.patterns.command.AsyncMacroCommand;
	
	/**
	 * MSpawnEntity
	 * @author Dylan Heyes
	 */
	public class MSpawnEntity extends AsyncMacroCommand 
	{
		override protected function initializeAsyncMacroCommand():void 
		{
			// Load vessel
			addSubCommand(CCreateVessel);
			
			// Create entity
			
			// Notify created
		}
	}

}