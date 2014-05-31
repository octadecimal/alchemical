/**
 * Copyright 2014, Dylan Heyes
 */
package alchemical.subsystems.resources.controller 
{
	import alchemical.core.enum.ComponentNames;
	import alchemical.debug.Debugger;
	import alchemical.subsystems.resources.model.ResourcesProxy;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.AsyncCommand;
	
	/**
	 * CParseManifest
	 * @author Dylan Heyes
	 */
	public class CParseManifest extends AsyncCommand 
	{
		override public function execute(notification:INotification):void 
		{
			if (CONFIG::debug) Debugger.log(this, "Parsing manifest...");
			
			var resourcesProxy:ResourcesProxy = facade.retrieveProxy(ComponentNames.RESOURCES) as ResourcesProxy;
			var manifest:XML = resourcesProxy.manifestData;
			
			// Parse paths
			for each(var path:XML in manifest.paths.children())
			{
				resourcesProxy.registerPath(path.@name, path.@path);
			}
			
			// Parse atlases
			for each(var atlas:XML in manifest.atlases.children())
			{
				resourcesProxy.registerAtlas(atlas.@name, atlas.@texture);
			}
			
			// Complete
			if (CONFIG::debug) Debugger.log(this, "Parsed manifest.");
			commandComplete();
		}
	}

}