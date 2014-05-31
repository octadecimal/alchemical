/**
 * Copyright 2014, Dylan Heyes
 */
package alchemical.platforms 
{
	import alchemical.core.ApplicationFacade;
	import alchemical.core.model.vo.StartupVO;
	import flash.display.Sprite;
	import flash.events.Event;
	
	/**
	 * DesktopPlatform
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
			
			// Register fonts
			//Fonts.registerFont(Fonts.Consolas12_Font, Fonts.Consolas12_Texture);
			
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
			_facade.startup(new StartupVO(stage/*, new InternetGateway("localhost", 1337)*/));
		}
	
	}

}