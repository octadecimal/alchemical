package alchemical.client.platforms
{
	import alchemical.client.core.ApplicationFacade;
	import alchemical.client.core.model.vo.StartupVO;
	import alchemical.client.subsystems.network.gateways.InternetGateway;
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
			
			stage.nativeWindow.x = stage.fullScreenWidth / 2 - stage.nativeWindow.width / 2;
			stage.nativeWindow.y = stage.fullScreenHeight / 2 - stage.nativeWindow.height / 2;
			
			//_facade.startup(new StartupVO(stage, new SimulatedGateway()));
			_facade.startup(new StartupVO(stage, new InternetGateway("localhost", 1337)));
		}
	
	}

}