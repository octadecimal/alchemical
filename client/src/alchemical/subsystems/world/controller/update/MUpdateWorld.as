/**
 * Copyright 2014, Dylan Heyes
 */
package alchemical.subsystems.world.controller.update 
{
	import org.puremvc.as3.patterns.command.MacroCommand;
	
	/**
	 * MUpdateWorld
	 * @author Dylan Heyes
	 */
	public class MUpdateWorld extends MacroCommand 
	{
		override protected function initializeMacroCommand():void 
		{
			addSubCommand(CProjectEntities);
		}
	}

}