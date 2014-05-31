/**
 * Copyright 2014, Dylan Heyes
 */
package alchemical.subsystems.resources.controller 
{
	import alchemical.core.enum.ComponentNames;
	import alchemical.debug.Debugger;
	import alchemical.subsystems.resources.model.ResourcesProxy;
	import alchemical.subsystems.resources.Resources;
	import flash.filesystem.File;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.AsyncCommand;
	
	/**
	 * CLoadManifest
	 * @author Dylan Heyes
	 */
	public class CLoadManifest extends AsyncCommand 
	{
		override public function execute(notification:INotification):void 
		{
			if (CONFIG::debug) Debugger.log(this, "Loading manifest...");
			
			var resources:Resources = facade.retrieveMediator(ComponentNames.RESOURCES).getViewComponent() as Resources;
			var resourcesProxy:ResourcesProxy = facade.retrieveProxy(ComponentNames.RESOURCES) as ResourcesProxy;
			
			resources.enqueue(File.applicationDirectory.resolvePath("data/manifest.xml"));
			
			resources.loadQueue(function onProgress(ratio:Number):void
			{
				if (ratio >= 1)
				{
					resourcesProxy.manifestData = resources.getXml("manifest");
					
					if (CONFIG::debug) Debugger.log(this, "Loaded manifest.");
					commandComplete();
				}
			});
		}
	}

}