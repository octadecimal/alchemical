/**
 * Copyright 2014, Dylan Heyes
 */
package alchemical.debug.console 
{
	import alchemical.debug.DebuggerOverlay;
	/**
	 * ConsoleCommand
	 * @author Dylan Heyes
	 */
	public class ConsoleCommand 
	{
		/**
		 * Constructor.
		 */
		public function ConsoleCommand(trigger:String) 
		{
			_trigger = trigger;
		}
		
		
		
		// API
		// =========================================================================================
		
		public function execute(overlay:DebuggerOverlay, args:Array = null):void
		{
			if (args && args[0] == "help")
			{
				help(overlay);
			}
		}
		
		public function help(overlay:DebuggerOverlay):void 
		{
			
		}
		
		
		
		// ACCESSORS
		// =========================================================================================
		
		/**
		 * Command trigger.
		 */
		public function get trigger():String		{ return _trigger; }
		private var _trigger:String;
	}

}