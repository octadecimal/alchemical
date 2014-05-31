/**
 * Copyright 2014, Dylan Heyes
 */
package alchemical.subsystems.resources.controller 
{
	import alchemical.core.enum.ComponentNames;
	import alchemical.debug.Debugger;
	import alchemical.subsystems.resources.model.ResourcesProxy;
	import alchemical.subsystems.resources.model.vo.ResourceVO;
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
			
			// Parse skies
			resourcesProxy.initializeSkies(manifest.skies.children().length());
			for each(var sky:XML in manifest.skies.children())
			{
				resourcesProxy.registerSky(new ResourceVO(int(sky.@id), sky.@texture));
			}
			
			// Parse hulls
			resourcesProxy.initializeHulls(manifest.hulls.children().length());
			for each(var hull:XML in manifest.hulls.children())
			{
				resourcesProxy.registerHull(new ResourceVO(int(hull.@id), hull.@texture, hull.@atlas));
			}
			
			// Parse enginebays
			resourcesProxy.initializeEnginebays(manifest.enginebays.children().length());
			for each(var enginebay:XML in manifest.enginebays.children())
			{
				resourcesProxy.registerEnginebay(new ResourceVO(int(enginebay.@id), enginebay.@texture, enginebay.@atlas));
			}
			
			// Complete
			if (CONFIG::debug) Debugger.log(this, "Parsed manifest.");
			commandComplete();
		}
	}

}