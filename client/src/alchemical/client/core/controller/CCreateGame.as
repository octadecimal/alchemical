/**
 * Copyright 2014, Dylan Heyes
 */
package alchemical.client.core.controller 
{
	import alchemical.client.core.enum.ComponentNames;
	import alchemical.client.debugger.Debugger;
	import alchemical.client.game.Game;
	import alchemical.client.game.mediator.GameMediator;
	import alchemical.client.game.model.GameProxy;
	import flash.display.Stage;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.AsyncCommand;
	import starling.core.Starling;
	
	/**
	 * CCreateGame
	 * @author Dylan Heyes
	 */
	public class CCreateGame extends AsyncCommand 
	{
		override public function execute(notification:INotification):void 
		{
			Debugger.log(this, "Creating: " + ComponentNames.GAME);
			
			// Get reference to game from starling
			var starling:Starling = facade.retrieveMediator(ComponentNames.GRAPHICS).getViewComponent() as Starling;
			
			// Get reference to game view
			var game:Game = starling.root as Game;
			
			// Register
			facade.registerProxy(new GameProxy());
			facade.registerMediator(new GameMediator(game));
			
			// Set flash stage reference
			game.flashStage = notification.getBody() as Stage;
			
			// Complete
			Debugger.log(this, "Created: " + ComponentNames.GAME);
			commandComplete();
		}
	}

}