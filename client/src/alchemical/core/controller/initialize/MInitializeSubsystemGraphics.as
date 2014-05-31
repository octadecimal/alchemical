/**
 * Copyright 2014, Dylan Heyes
 */
package alchemical.core.controller.initialize 
{
	import alchemical.subsystems.graphics.controller.CLoadFonts;
	import org.puremvc.as3.patterns.command.AsyncMacroCommand;
	
	/**
	 * CInitializeSubsystemGraphics
	 * @author Dylan Heyes
	 */
	public class MInitializeSubsystemGraphics extends AsyncMacroCommand 
	{
		override protected function initializeAsyncMacroCommand():void 
		{
			addSubCommand(CLoadFonts);
		}
	}

}