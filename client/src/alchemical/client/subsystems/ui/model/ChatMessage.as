/**
 * Copyright 2014, Dylan Heyes
 */
package alchemical.client.subsystems.ui.model 
{
	/**
	 * ChatMessage
	 * @author Dylan Heyes
	 */
	public class ChatMessage 
	{
		/**
		 * Constructor.
		 * @param	type
		 * @param	msg
		 */
		public function ChatMessage(type:uint, msg:String, sender:String = null) 
		{
			_type = type;
			_msg = msg;
			_sender = sender;
		}
		
		
		
		// ACCESSORS
		// =========================================================================================
		
		/**
		 * Message type.
		 */
		public function get type():uint			{ return _type; }
		private var _type:uint;
		
		/**
		 * Message contents.
		 */
		public function get msg():String		{ return _msg; }
		private var _msg:String;
		
		/**
		 * Message sender.
		 */
		public function get sender():String		{ return _sender; }
		private var _sender:String; 
	}

}