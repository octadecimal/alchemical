/**
 * Copyright 2014, Dylan Heyes
 */
package alchemical.subsystems.world.ships 
{
	import alchemical.subsystems.world.Entity;
	import alchemical.subsystems.world.model.nodes.DynamicsNode;
	import alchemical.subsystems.world.model.nodes.TransformNode;
	import starling.core.Starling;
	import starling.display.DisplayObject;
	import starling.display.Image;
	import starling.display.MovieClip;
	import starling.display.Sprite;
	import starling.textures.Texture;
	
	/**
	 * Ship
	 * @author Dylan Heyes
	 */
	public class Ship extends Entity 
	{
		private var _hull:Image;
		private var _engines:Vector.<MovieClip>;
		
		/**
		 * Constructor.
		 * @param	view
		 * @param	transform
		 * @param	dynamics
		 */
		public function Ship(view:DisplayObject=null, transform:TransformNode=null, dynamics:DynamicsNode=null, numEnginebays:int = 0) 
		{
			super(view, transform, dynamics);
			
			_engines = new Vector.<MovieClip>(numEnginebays);
		}
		
		
		
		// API
		// =========================================================================================
		
		public function setHullTexture(texture:Texture):void
		{
			_hull = new Image(texture);
			
			_hull.pivotX = _hull.width / 2;
			
			Sprite(view).addChild(_hull);
		}
		
		public function setEngineTextureAt(index:int, textures:Vector.<Texture>, x:int, y:int):void
		{
			var mc:MovieClip = new MovieClip(textures, 12);
			_engines[index] = mc;
			
			mc.pivotX = mc.width / 2;
			mc.x = x;
			mc.y = y;
			
			Sprite(view).addChildAt(mc, 0);
			
			mc.play();
			Starling.juggler.add(mc);
		}
		
	}

}