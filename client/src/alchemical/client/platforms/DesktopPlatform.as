package alchemical.client.platforms
{
	import alchemical.client.core.ApplicationFacade;
	import flash.display.Sprite;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Dylan Heyes
	 */
	public class DesktopPlatform extends Sprite
	{
		// Application facade
		private var _facade:ApplicationFacade;
		
		/**
		 * Constructor.
		 */
		public function DesktopPlatform():void
		{
			super();
			
			// Events
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			
			// Create application facade
			_facade = new ApplicationFacade();
		}
		
		
		
		// EVENTS
		// =========================================================================================
		
		/**
		 * event: Added to stage.
		 */
		private function onAddedToStage(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			
			_facade.startup(stage);
		}
	
	}

}