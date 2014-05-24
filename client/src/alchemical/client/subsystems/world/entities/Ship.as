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
		public function Ship(/*vo:ShipVO, */view:Sprite = null) 
		{
			super(view);
			
			this.view.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		private function onAddedToStage(e:Event):void 
		{
			view.removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			
			view.pivotX = view.width / 2;
			view.pivotY = view.height / 2;
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