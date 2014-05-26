/**
 * Copyright 2014, Dylan Heyes
 */
package alchemical.client.debugger 
{
	import alchemical.client.subsystems.network.model.NetworkProxy;
	import starling.display.Sprite;
	
	/**
	 * Debugger
	 * @author Dylan Heyes
	 */
	public class Debugger extends Sprite
	{
		/**
		 * Constructor.
		 */
		public function Debugger() 
		{
			
		}
		
		
		
		// ACCESSORS
		// =========================================================================================
		
		/**
		 * World stats overlay.
		 */
		public function set worldStats(a:WorldStats):void	{ _worldStats = a; }
		public function get worldStats():WorldStats			{ return _worldStats; }
		private var _worldStats:WorldStats; 
		
		/**
		 * Network entity transform overlay.
		 */
		public function set networkEntityOverlay(a:NetworkEntityOverlay):void	{ _networkEntityOverlay = a; }
		public function get networkEntityOverlay():NetworkEntityOverlay		{ return _networkEntityOverlay; }
		private var _networkEntityOverlay:NetworkEntityOverlay;
		
		
		
		
		// STATIC
		// =========================================================================================
		
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