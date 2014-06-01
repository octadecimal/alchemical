/**
 * Copyright 2014, Dylan Heyes
 */
package alchemical.subsystems.world.ships 
{
	import alchemical.subsystems.world.Entity;
	import alchemical.subsystems.world.model.nodes.DynamicsNode;
	import alchemical.subsystems.world.model.nodes.TransformNode;
	import starling.display.DisplayObject;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.textures.Texture;
	
	/**
	 * Ship
	 * @author Dylan Heyes
	 */
	public class Ship extends Entity 
	{
		private var _hull:Image;
		
		/**
		 * Constructor.
		 * @param	view
		 * @param	transform
		 * @param	dynamics
		 */
		public function Ship(view:DisplayObject=null, transform:TransformNode=null, dynamics:DynamicsNode=null) 
		{
			super(view, transform, dynamics);
		}
		
		
		
		// API
		// =========================================================================================
		
		public function setHullTexture(texture:Texture):void
		{
			_hull = new Image(texture);
			
			Sprite(view).addChild(_hull);
		}
		
	}

}