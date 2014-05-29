/**
 * Copyright 2014, Dylan Heyes
 */
package alchemical.client.subsystems.world.controller 
{
	import alchemical.client.core.enum.ComponentNames;
	import alchemical.client.subsystems.world.controller.animation.FollowAnimationController;
	import alchemical.client.subsystems.world.entities.NPC;
	import alchemical.client.subsystems.world.entities.Ship;
	import alchemical.client.subsystems.world.factories.WorldFactory;
	import alchemical.client.subsystems.world.model.vo.NPCVo;
	import alchemical.client.subsystems.world.model.WorldProxy;
	import alchemical.client.subsystems.world.World;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.AsyncCommand;
	import starling.display.MovieClip;
	import starling.display.Sprite;
	import starling.textures.TextureAtlas;
	import starling.utils.AssetManager;
	
	/**
	 * CCreateNPCs
	 * @author Dylan Heyes
	 */
	public class CCreateNPCs extends AsyncCommand 
	{
		override public function execute(notification:INotification):void 
		{
			var npc:NPC, vo:NPCVo, ship:Ship;
			var world:World = facade.retrieveMediator(ComponentNames.WORLD).getViewComponent() as World;
			var worldProxy:WorldProxy = facade.retrieveProxy(ComponentNames.WORLD) as WorldProxy;
			var npcVOs:Vector.<NPCVo> = worldProxy.npcDefinitions;
			var npcs:Vector.<NPC> = new Vector.<NPC>();
			
			for (var i:int = 0; i < worldProxy.npcDefinitions.length; i++)
			{
				vo = npcVOs[i];
				
				npc = new NPC(vo.id);
				
				ship = WorldFactory.createShip(vo.id);
				npc.ship = ship;
				Sprite(npc.view).addChild(ship.view);
				
				npc.animationController = new FollowAnimationController(npc);
				worldProxy.animationControllers.push(npc.animationController);
				
				var assets:AssetManager = facade.retrieveMediator(ComponentNames.RESOURCES).getViewComponent() as AssetManager;
				ship.setHullTexture(assets.getTextureAtlas("ships_01").getTexture("ship_0001"));
				
				var thrust:MovieClip = new MovieClip(assets.getTextureAtlas("ships_01").getTextures("thrust_01"), 15);
				ship.setThrustTexture(thrust);
				
				npc.transform.x = vo.x;
				npc.transform.y = vo.y;
				
				world.addChild(npc.view);
				
				npcs.push(npc);
			}
			
			world.npcs = npcs;
			
			commandComplete();
		}
	}

}