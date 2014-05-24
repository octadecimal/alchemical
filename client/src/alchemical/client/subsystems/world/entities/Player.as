/**
 * Copyright 2014, Dylan Heyes
 */
package alchemical.client.subsystems.world.entities 
{
	import alchemical.client.subsystems.world.controller.animation.ForwardAnimationController;
	import alchemical.client.subsystems.world.model.TransformNode;
	import flash.geom.Point;
	import flash.utils.setTimeout;
	import starling.display.Sprite;
	import starling.events.EnterFrameEvent;
	import starling.events.Event;
	
	/**
	 * Player
	 * @author Dylan Heyes
	 */
	public class Player extends MovableEntity 
	{
		public function Player() 
		{
			super();
			
			view.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		private function onAddedToStage(e:Event):void 
		{
			view.removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			
			transform.x = 256;
			transform.y = 256;
		}
		
		
		
		// API
		// =========================================================================================
		
		public function moveTo(position:Point):void 
		{
			targetPosition = new TransformNode(position.x, position.y);
			ship.targetPosition = targetPosition;
			
			view.addEventListener(EnterFrameEvent.ENTER_FRAME, onFollowUpdate);
		}
		
		private function onFollowUpdate(e:EnterFrameEvent):void 
		{
			// TEMPORARY
			if (Math.abs(targetPosition.x - transform.x) <= 100)
			{
				if (Math.abs(targetPosition.y - transform.y) <= 100)
				{
					targetPosition = null;
					
					view.removeEventListener(EnterFrameEvent.ENTER_FRAME, onFollowUpdate);
				}
			}
		}
		
		
		
		// ACCESSORS
		// =========================================================================================
		
		/**
		 * Ship.
		 */
		public function set ship(a:Ship):void	{ _ship = a; }
		public function get ship():Ship			{ return _ship; }
		private var _ship:Ship;
	}

}