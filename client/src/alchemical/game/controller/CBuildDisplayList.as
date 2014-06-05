/**
 * Copyright 2014, Dylan Heyes
 */
package alchemical.game.controller 
{
	import alchemical.core.enum.ComponentNames;
	import alchemical.debug.Debugger;
	import alchemical.game.Game;
	import alchemical.subsystems.ui.UILayer;
	import alchemical.subsystems.world.World;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;
	
	/**
	 * CBuildDisplayList
	 * @author Dylan Heyes
	 */
	public class CBuildDisplayList extends SimpleCommand 
	{
		override public function execute(notification:INotification):void 
		{
			if (CONFIG::debug) Debugger.log(this, "Building display list...");
			
			var game:Game = facade.retrieveMediator(ComponentNames.GAME).getViewComponent() as Game;
			var world:World = facade.retrieveMediator(ComponentNames.WORLD).getViewComponent() as World;
			var ui:UILayer = facade.retrieveMediator(ComponentNames.UI).getViewComponent() as UILayer;
			
			game.addChild(world);
			game.addChild(ui);
			
			world.addChild(world.sky);
			
			if (CONFIG::debug) Debugger.log(this, "Built display list.");
		}
	}

}