/**
 * Copyright 2014, Dylan Heyes
 */
package alchemical.client.debugger 
{
	import alchemical.client.subsystems.network.model.NetworkProxy;
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
			
		}
		
		/**
		 * Adds a debug log.
		 * @param	caller
		 * @param	message
		 * @param	args
		 */
		public static function log(caller:*, message:*, args:*=null):void
		{
			trace(prefixWithWhitespace(caller.toString(), 40), " --> ", message);
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
				trace(prefixWithWhitespace("~ ", 46), notification, " (", body, ")");
			}
			else
			{
				trace(prefixWithWhitespace("~ ", 46), notification);
			}
		}
		
		static public function error(caller:*, message:*, args:*=null):void 
		{
			
			trace(prefixWithWhitespace(caller.toString(), 40), " !!!  ERROR: ", message);
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