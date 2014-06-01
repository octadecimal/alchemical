/**
 * Copyright 2014, Dylan Heyes
 */
package alchemical.subsystems.world.controller.build 
{
	import alchemical.core.enum.ComponentNames;
	import alchemical.debug.Debugger;
	import alchemical.subsystems.world.Sky;
	import alchemical.subsystems.world.World;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;
	
	/**
	 * CBuildSky
	 * @author Dylan Heyes
	 */
	public class CBuildSky extends SimpleCommand 
	{
		override public function execute(notification:INotification):void 
		{
			if (CONFIG::debug) Debugger.log(this, "Building sky...");
			
			var world:World = facade.retrieveMediator(ComponentNames.WORLD).getViewComponent() as World;
			
			world.sky = new Sky();
			
			if (CONFIG::debug) Debugger.log(this, "Built sky.");
		}
	}

}