/**
 * Copyright 2014, Dylan Heyes
 */
package alchemical.subsystems.resources.controller 
{
	import alchemical.core.enum.ComponentNames;
	import alchemical.debug.Debugger;
	import alchemical.subsystems.resources.model.ResourcesProxy;
	import alchemical.subsystems.resources.model.vo.ResourceVO;
	import alchemical.subsystems.resources.model.vo.TextureAtlasVO;
	import alchemical.subsystems.resources.model.vo.TextureVO;
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
			resourcesProxy.initializeAtlases(manifest.atlases.children().length());
			for each(var atlas:XML in manifest.atlases.children())
			{
				resourcesProxy.registerAtlas(new TextureAtlasVO(atlas.@id, atlas.@texture));
			}
			
			// Parse skies
			resourcesProxy.initializeSkies(manifest.skies.children().length());
			for each(var sky:XML in manifest.skies.children())
			{
				resourcesProxy.registerSky(new ResourceVO(int(sky.@id), sky.@texture));
			}
			
			// Parse textures
			for each(var texture:XML in manifest.textures.children())
			{
				resourcesProxy.registerTexture(new TextureVO(texture.@name, texture.@subtexture, texture.@atlas));
			}
			
			// Initialize resources proxy
			resourcesProxy.initialize();
			
			// Complete
			if (CONFIG::debug) Debugger.log(this, "Parsed manifest.");
			commandComplete();
		}
	}

}