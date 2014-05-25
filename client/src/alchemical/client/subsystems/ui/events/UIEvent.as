package alchemical.client.subsystems.ui.events 
{
	import starling.events.Event;
	
	/**
	 * ...
	 * @author Dylan Heyes
	 */
	public class UIEvent extends Event 
	{
		static public const PLAY_NOW_CLICKED:String = "playNowClicked";
		
		static public const CHATBOX_FOCUSED:String = "chatboxFocused";
		static public const CHATBOX_UNFOCUSED:String = "chatboxUnfocused";
		static public const CHATBOX_MESSAGE_ENTERED:String = "chatMessageEntered";
		
		public function UIEvent(type:String, data:Object = null) 
		{ 
			super(type, true, data);
		} 
	}
}