/**
 * Copyright 2014, Dylan Heyes
 */
package alchemical.client.game.controller 
{
	import alchemical.client.core.enum.ComponentNames;
	import alchemical.client.debugger.Debugger;
	import alchemical.client.game.Game;
	import alchemical.client.subsystems.ui.UILayer;
	import alchemical.client.subsystems.world.World;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.AsyncCommand;
	
	/**
	 * CBuildDisplayList
	 * @author Dylan Heyes
	 */
	public class CBuildDisplayList extends AsyncCommand 
	{
		override public function execute(notification:INotification):void 
		{
			// Get game
			var game:Game = facade.retrieveMediator(ComponentNames.GAME).getViewComponent() as Game;
			
			// Get children
			var world:World = facade.retrieveMediator(ComponentNames.WORLD).getViewComponent() as World;
			var uiLayer:UILayer = facade.retrieveMediator(ComponentNames.UI).getViewComponent() as UILayer;
			var debugger:Debugger = facade.retrieveMediator(ComponentNames.DEBUGGER).getViewComponent() as Debugger;
			
			// Add to game
			game.addChild(world);
			game.addChild(uiLayer);
			
			// Add to world
			world.addChild(world.sky.view);
			
			// Debugger
			world.addChild(debugger.worldStats);
			//world.addChild(debugger.networkEntityOverlay);
			
			commandComplete();
		}
	}

}