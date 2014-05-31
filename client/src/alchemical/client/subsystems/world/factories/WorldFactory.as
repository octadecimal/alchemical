/**
 * Copyright 2014, Dylan Heyes
 */
package alchemical.client.subsystems.world.factories 
{
	import alchemical.client.core.util.StringUtils;
	import alchemical.client.subsystems.resources.Resources;
	import alchemical.client.subsystems.world.entities.Ship;
	import alchemical.client.subsystems.world.model.vo.ShipVO;
	import starling.display.MovieClip;
	import starling.display.Sprite;
	import starling.textures.Texture;
	
	/**
	 * WorldFactory
	 * @author Dylan Heyes
	 */
	public class WorldFactory 
	{
		static private const HULL_PREFIX:String = "ship_";
		static private const ENGINE_PREFIX:String = "thrust_";
		
		static public function createShip(vo:ShipVO, resources:Resources):Ship
		{
			var ship:Ship = new Ship(vo.id, new Sprite());
			
			//resources.enqueue(vo.hull.id);
			var hullTextureName:String = HULL_PREFIX + StringUtils.toFixedPrefix(vo.hull.view, "0", 4);
			var hullTexture:Texture = resources.getTexture(hullTextureName);
			ship.setHullTexture(hullTexture);
			
			for (var i:int = 0; i < vo.engines.length; i++)
			{
				//resources.enqueue(vo.engines[i].id);
				var engineTextureName:String = ENGINE_PREFIX + StringUtils.toFixedPrefix(vo.engines[i].view, "0", 2);
				var engineTexture:MovieClip = new MovieClip(resources.getTextures(engineTextureName), 12);
				ship.setThrustTexture(engineTexture);
			}
			
			return ship;
		}
	}

}