/**
 * Copyright 2014, Dylan Heyes
 */
package alchemical.core.controller.startup 
{
	import alchemical.core.enum.ComponentNames;
	import alchemical.debug.Debugger;
	import alchemical.game.Game;
	import alchemical.game.mediator.GameMediator;
	import alchemical.game.model.GameProxy;
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
			if (CONFIG::debug) Debugger.info(this, "Creating: " + ComponentNames.GAME);
			
			// Get reference to game from starling
			var starling:Starling = facade.retrieveMediator(ComponentNames.GRAPHICS).getViewComponent() as Starling;
			
			// Get reference to game view
			var game:Game = starling.root as Game;
			
			// Register
			facade.registerProxy(new GameProxy());
			facade.registerMediator(new GameMediator(game));
			
			// Complete
			if (CONFIG::debug) Debugger.info(this, "Created: " + ComponentNames.GAME);
			commandComplete();
		}
	}

}