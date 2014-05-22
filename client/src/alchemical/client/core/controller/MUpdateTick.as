/**
 * Copyright 2014, Dylan Heyes
 */
package alchemical.client.core.controller 
{
	import alchemical.client.subsystems.world.controller.MUpdateWorld;
	import org.puremvc.as3.patterns.command.MacroCommand;
	
	/**
	 * MUpdateTick
	 * @author Dylan Heyes
	 */
	public class MUpdateTick extends MacroCommand 
	{
		override protected function initializeMacroCommand():void 
		{
			addSubCommand(MUpdateWorld);
		}
	}

}