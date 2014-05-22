/**
 * Copyright 2014, Dylan Heyes
 */
package alchemical.client.subsystems.world.controller 
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
			addSubCommand(CUpdateAnimationControllers);
		}
	}

}