/**
 * Copyright 2014, Dylan Heyes
 */
package alchemical.client.subsystems.ui.controller 
{
	import alchemical.client.core.enum.ComponentNames;
	import alchemical.client.subsystems.ui.controls.UIButton;
	import alchemical.client.subsystems.ui.mediator.UIMediator;
	import alchemical.client.subsystems.ui.model.UIProxy;
	import alchemical.client.subsystems.ui.screens.LoginScreen;
	import alchemical.client.subsystems.ui.UILayer;
	import flash.filesystem.File;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.AsyncCommand;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;
	import starling.utils.AssetManager;
	
	/**
	 * CDisplayScreenLogin
	 * @author Dylan Heyes
	 */
	public class CDisplayScreenLogin extends AsyncCommand 
	{
		override public function execute(notification:INotification):void 
		{
			// Get UI
			var uiProxy:UIProxy = facade.retrieveProxy(ComponentNames.UI) as UIProxy;
			var uiMediator:UIMediator = facade.retrieveMediator(ComponentNames.UI) as UIMediator;
			var uiLayer:UILayer = uiMediator.getViewComponent() as UILayer;
			
			// Get resources
			var resources:AssetManager = facade.retrieveMediator(ComponentNames.RESOURCES).getViewComponent() as AssetManager;
			
			// Enqueue login textures
			resources.enqueue(File.applicationDirectory.resolvePath("textures/login.atf"));
			resources.enqueue(File.applicationDirectory.resolvePath("textures/login.xml"));
			
			// Load
			resources.loadQueue(function (ratio:Number):void
			{
				if (ratio >= 1)
				{
					// Get login texture
					var atlas:TextureAtlas = resources.getTextureAtlas("login");
					var texture:Texture = atlas.getTexture("login_logo");
					
					// Create "play now" button
					var button:UIButton = new UIButton(uiProxy.atlasControls.getTexture("button_128-64_out"), "PLAY NOW", uiProxy.atlasControls.getTexture("button_128-64_down"));
					
					// Add to UI layer
					uiLayer.loginScreen = new LoginScreen(texture, button);
					uiLayer.addChild(uiLayer.loginScreen);
				}
			});
		}
	}
}