/**
 * Copyright 2014, Dylan Heyes
 */
package alchemical.debug 
{
	/**
	 * Debugger
	 * @author Dylan Heyes
	 */
	public class Debugger
	{
		/**
		 * Constructor.
		 */
		public function Debugger() 
		{
			_overlay = new DebuggerOverlay();
		}
		
		
		
		// API
		// =========================================================================================
		
		public function show():void
		{
			
		}
		
		
		
		// INTERNAL
		// =========================================================================================
		
		private function build():void
		{
			
		}
		
		
		
		// ACCESSORS
		// =========================================================================================
		
		/**
		 * Debugger overlay.
		 */
		public function get overlay():DebuggerOverlay		{ return _overlay; }
		private static var _overlay:DebuggerOverlay;
		
		/**
		 * World stats overlay.
		 */
		/*public function set worldStats(a:WorldStats):void	{ _worldStats = a; }
		public function get worldStats():WorldStats			{ return _worldStats; }
		private var _worldStats:WorldStats; */
		
		/**
		 * Network entity transform overlay.
		 */
		/*public function set networkEntityOverlay(a:NetworkEntityOverlay):void	{ _networkEntityOverlay = a; }
		public function get networkEntityOverlay():NetworkEntityOverlay		{ return _networkEntityOverlay; }
		private var _networkEntityOverlay:NetworkEntityOverlay;*/
		
		
		
		
		// STATIC
		// =========================================================================================
		
		/**
		 * Outputs a debug message.
		 * @param	string
		 */
		private static function output(string:String, color:String):void
		{
			if (!CONFIG::debug) throw new Error("Attempted debug operation on release settings.");
			_overlay.addLine(string, color);
			trace(string);
		}
		
		/**
		 * Adds a debug log.
		 * @param	caller
		 * @param	message
		 * @param	args
		 */
		public static function info(caller:*, message:*, args:*=null):void
		{
			output(prefixWithWhitespace(caller.toString(), 50) + " --> "+ message, "#00CC00");
		}
		
		/**
		 * Adds a debug log.
		 * @param	caller
		 * @param	message
		 * @param	args
		 */
		public static function log(caller:*, message:*, args:*=null):void
		{
			output(prefixWithWhitespace(caller.toString(), 50) + "   > "+ message, "#CCCCCC");
		}
		
		/**
		 * Adds a debug log.
		 * @param	caller
		 * @param	message
		 * @param	args
		 */
		public static function data(caller:*, message:*, args:*=null):void
		{
			output(prefixWithWhitespace(caller.toString(), 50) + "     "+ message, "#888888");
		}
		
		/**
		 * Adds a notification.
		 * @param	notification
		 * @param	body
		 */
		public static function note(notification:String, body:Object = null, type:String = null):void
		{
			if (body)
			{
				output(prefixWithWhitespace("~ ", 46) + notification + " (" + body + ")", "#444444");
			}
			else
			{
				output(prefixWithWhitespace("~ ", 46) + notification, "#444444");
			}
		}
		
		/**
		 * Error output.
		 * @param	caller
		 * @param	message
		 * @param	args
		 */
		static public function error(caller:*, message:*, args:*=null):void 
		{
			output(prefixWithWhitespace(caller.toString(), 50) + " !!  ERROR: " + message, "#FF0000");
		}
		
		/**
		 * Warning output.
		 * @param	caller
		 * @param	message
		 * @param	args
		 */
		static public function warn(caller:*, message:*, args:*=null):void 
		{
			output(prefixWithWhitespace(caller.toString(), 50) + "  !  WARNING: " + message, "#FFFF00");
		}
		
		/**
		 * Utility function that pads a string with whitespace.
		 * @param	str
		 * @param	width
		 * @return
		 */
		static private function prefixWithWhitespace(str:String, width:int):String
		{
			var whitespaceLength:int = width -str.length; 
			
			var prefix:String = "";
			
			for (var i:int = 0; i < whitespaceLength; i++)
			{
				prefix += " ";
			}
			
			return prefix + str;
		}
	}

}