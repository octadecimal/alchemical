/**
 * Copyright 2014, Dylan Heyes
 */
package alchemical.debug.console 
{
	import alchemical.debug.DebuggerOverlay;
	/**
	 * ConsoleCommandHelp
	 * @author Dylan Heyes
	 */
	public class ConsoleCommandHelp extends ConsoleCommand 
	{
		/**
		 * Constructor.
		 */
		public function ConsoleCommandHelp(trigger:String) 
		{
			super(trigger);
		}
		
		
		override public function execute(overlay:DebuggerOverlay, args:Array = null):void 
		{
			super.execute(overlay);
			
			overlay.addLine("Help: Get a life lol, "+args[0]);
		}
	}

}