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
		
		public function UIEvent(type:String, data:Object = null) 
		{ 
			super(type, true, data);
		} 
	}
}