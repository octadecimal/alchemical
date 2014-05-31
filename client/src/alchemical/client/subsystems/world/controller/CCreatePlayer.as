/**
 * Copyright 2014, Dylan Heyes
 */
package alchemical.client.subsystems.world.controller 
{
	import alchemical.client.core.enum.ComponentNames;
	import alchemical.client.debugger.Debugger;
	import alchemical.client.subsystems.resources.Resources;
	import alchemical.client.subsystems.world.controller.animation.FollowAnimationController;
	import alchemical.client.subsystems.world.entities.Player;
	import alchemical.client.subsystems.world.entities.Ship;
	import alchemical.client.subsystems.world.factories.WorldFactory;
	import alchemical.client.subsystems.world.mediator.PlayerMediator;
	import alchemical.client.subsystems.world.model.WorldProxy;
	import alchemical.client.subsystems.world.World;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;
	import starling.display.MovieClip;
	import starling.display.Sprite;
	import starling.utils.AssetManager;
	
	/**
	 * CBuildPlayer
	 * @author Dylan Heyes
	 */
	public class CCreatePlayer extends SimpleCommand 
	{
		override public function execute(notification:INotification):void 
		{
			Debugger.log(this, "Creating player...");
			
			var worldProxy:WorldProxy = facade.retrieveProxy(ComponentNames.WORLD) as WorldProxy;
			var resources:Resources = facade.retrieveMediator(ComponentNames.RESOURCES).getViewComponent() as Resources;
			
			var ship:Ship = WorldFactory.createShip(worldProxy.playerDefinition.ship, resources);
			
			var player:Player = new Player(worldProxy.playerDefinition.id);
			facade.registerMediator(new PlayerMediator(player));
			
			player.view = ship.view;
			
			player.animationController = new FollowAnimationController(player);
			worldProxy.animationControllers.push(player.animationController);
			
			var assets:AssetManager = facade.retrieveMediator(ComponentNames.RESOURCES).getViewComponent() as AssetManager;
			ship.setHullTexture(assets.getTextureAtlas("ships_01").getTexture("ship_0001"));
				
			var thrust:MovieClip = new MovieClip(assets.getTextureAtlas("ships_01").getTextures("thrust_01"), 15);
			ship.setThrustTexture(thrust);
			
			var world:World = facade.retrieveMediator(ComponentNames.WORLD).getViewComponent() as World;
			world.addChild(player.view);
			//world.sky.addChildAt(ship, 2);	// TEMP TESTING!
			
			//ship.x = worldProxy.playerDefinition.x;
			//ship.y = worldProxy.playerDefinition.y;
			
			
			Debugger.log(this, "Created player.");
		}
	}

}