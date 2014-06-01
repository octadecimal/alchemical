/**
 * Copyright 2014, Dylan Heyes
 */
package alchemical.subsystems.world.controller.build 
{
	import alchemical.core.enum.ComponentNames;
	import alchemical.debug.Debugger;
	import alchemical.subsystems.resources.Resources;
	import alchemical.subsystems.world.model.WorldProxy;
	import flash.filesystem.File;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.AsyncCommand;
	
	/**
	 * CLoadShipDefinitions
	 * @author Dylan Heyes
	 */
	public class CLoadShipDefinitions extends AsyncCommand 
	{
		override public function execute(notification:INotification):void 
		{
			if (CONFIG::debug) Debugger.log(this, "Loading ship definitions...");
			
			var worldProxy:WorldProxy = facade.retrieveProxy(ComponentNames.WORLD) as WorldProxy;
			var resources:Resources = facade.retrieveMediator(ComponentNames.RESOURCES).getViewComponent() as Resources;
			
			resources.enqueue(File.applicationDirectory.resolvePath("data/ships.xml"));
			
			resources.loadQueue(function onProgress(ratio:Number):void
			{
				if (CONFIG::debug) Debugger.progress(ratio);
				
				if (ratio >= 1)
				{
					worldProxy.shipDefinitionsData = resources.getXml("ships");
					
					if (CONFIG::debug) Debugger.log(this, "Loaded ship definitions.");
					commandComplete();
				}
			});
		}
	}

}