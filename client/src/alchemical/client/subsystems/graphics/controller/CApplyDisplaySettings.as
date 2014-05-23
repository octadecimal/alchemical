/**
 * Copyright 2014, Dylan Heyes
 */
package alchemical.client.subsystems.graphics.controller 
{
	import alchemical.client.core.enum.ComponentNames;
	import alchemical.client.game.Game;
	import flash.display.Stage;
	import flash.display.StageDisplayState;
	import flash.geom.Rectangle;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.AsyncCommand;
	import starling.core.Starling;
	
	/**
	 * CLaunchGame
	 * @author Dylan Heyes
	 */
	public class CApplyDisplaySettings extends AsyncCommand 
	{
		override public function execute(notification:INotification):void 
		{
			// Get references
			var graphics:Starling = facade.retrieveMediator(ComponentNames.GRAPHICS).getViewComponent() as Starling;
			
			// Enter full screen
			//graphics.nativeStage.displayState = StageDisplayState.FULL_SCREEN_INTERACTIVE;
			
			// Resize game buffer
			graphics.viewPort = new Rectangle(0, 0, graphics.nativeStage.stageWidth, graphics.nativeStage.stageHeight);
			graphics.stage.stageWidth = graphics.nativeStage.stageWidth;
			graphics.stage.stageHeight = graphics.nativeStage.stageHeight;
			
			commandComplete();
		}
	}

}