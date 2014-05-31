/**
 * Copyright 2014, Dylan Heyes
 */
package alchemical.core.controller.startup 
{
	import alchemical.core.enum.ComponentNames;
	import alchemical.debug.Debugger;
	import alchemical.subsystems.world.mediator.WorldMediator;
	import alchemical.subsystems.world.proxy.WorldProxy;
	import alchemical.subsystems.world.World;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.AsyncCommand;
	
	/**
	 * CCreateSubsystemWorld
	 * @author Dylan Heyes
	 */
	public class CCreateSubsystemWorld extends AsyncCommand 
	{
		override public function execute(notification:INotification):void 
		{
			if (CONFIG::debug) Debugger.info(this, "Creating subsystem: " + ComponentNames.WORLD);
			
			var world:World = new World();
			
			facade.registerProxy(new WorldProxy());
			facade.registerMediator(new WorldMediator(world));
			
			if (CONFIG::debug) Debugger.info(this, "Subsystem created: " + ComponentNames.WORLD);
			commandComplete();
		}
	}

}