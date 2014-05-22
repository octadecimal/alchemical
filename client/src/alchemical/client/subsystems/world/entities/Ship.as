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
		public function Ship(vo:ShipVO) 
		{
			super();
			
			// Temp
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			//addEventListener(EnterFrameEvent.ENTER_FRAME, onUpdate);
		}
		
		private function onAddedToStage(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			
			pivotX = width / 2;
			pivotY = width / 2;
			
			x = stage.stageWidth / 2;
			y = stage.stageHeight / 2;
			
			rotation = Math.random() * Math.PI * 2;
		}
		
		private var _r:Number = Math.random() * 0.01 - 0.005;
		private var _rx:Number = Math.random() * .25 - 0.125;
		private var _ry:Number = Math.random() * .25 - 0.125;
		
		private function onUpdate(e:EnterFrameEvent):void 
		{
			rotation += _r;
			x + _rx;
			y += _ry;
		}
		
		
		
		// TEXTURES
		// =========================================================================================
		
		public function setHullTexture(texture:Texture):void
		{
			if (_hull == null)
			{
				_hull = new Image(texture);
				addChild(_hull);
			}
			else
			{
				_hull.texture = texture;
			}
		}
	}

}