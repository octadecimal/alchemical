/**
 * Copyright 2014, Dylan Heyes
 */
package alchemical.client.subsystems.world.entities 
{
	import alchemical.client.subsystems.world.model.vo.ShipVO;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.EnterFrameEvent;
	import starling.events.Event;
	import starling.textures.Texture;
	
	/**
	 * Ship
	 * @author Dylan Heyes
	 */
	public class Ship extends MovableEntity 
	{
		private var _hull:Image;
		
		/**
		 * Constructor.
		 */
		public function Ship(vo:ShipVO, view:Sprite = null) 
		{
			super(view);
		}
		
		
		
		// TEXTURES
		// =========================================================================================
		
		public function setHullTexture(texture:Texture):void
		{
			if (_hull == null)
			{
				_hull = new Image(texture);
				view.addChild(_hull);
			}
			else
			{
				_hull.texture = texture;
			}
		}
	}

}