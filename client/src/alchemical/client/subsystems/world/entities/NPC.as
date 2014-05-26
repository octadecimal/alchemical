/**
 * Copyright 2014, Dylan Heyes
 */
package alchemical.client.subsystems.world.entities 
{
	import alchemical.client.subsystems.world.model.TransformNode;
	import flash.geom.Point;
	import starling.display.Sprite;
	import starling.events.EnterFrameEvent;
	import starling.events.Event;
	
	/**
	 * NPC
	 * @author Dylan Heyes
	 */
	public class NPC extends MovableEntity 
	{
		/**
		 * Constructor.
		 * @param	view
		 */
		public function NPC(id:int, view:Sprite=null) 
		{
			_id = id;
			super(view);
			
			// Temp
			this.view.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		private function onAddedToStage(e:Event):void 
		{
			view.removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			view.addEventListener(EnterFrameEvent.ENTER_FRAME, onUpdate);
		}
		
		private function onUpdate(e:EnterFrameEvent):void 
		{
			ship.setThrust(dynamics.acceleration);
		}
		
		
		
		// API
		// =========================================================================================
		
		public function moveTo(position:Point):void 
		{
			targetPosition = new TransformNode(position.x, position.y);
			ship.targetPosition = targetPosition;
			
			ship.setThrust(1);
			
			view.addEventListener(EnterFrameEvent.ENTER_FRAME, onFollowUpdate);
		}
		
		private function onFollowUpdate(e:EnterFrameEvent):void 
		{
			if (Math.abs(targetPosition.x - transform.x) <= 100)
			{
				if (Math.abs(targetPosition.y - transform.y) <= 100)
				{
					targetPosition = null;
					
					view.removeEventListener(EnterFrameEvent.ENTER_FRAME, onFollowUpdate);
					
					ship.setThrust(0);
				}
			}
		}
		
		
		
		// ACCESSORS
		// =========================================================================================
		
		/**
		 * Unique id.
		 */
		public function get id():int		{ return _id; }
		private var _id:int;
		
		/**
		 * Ship.
		 */
		public function set ship(a:Ship):void	{ _ship = a; }
		public function get ship():Ship			{ return _ship; }
		private var _ship:Ship;
	}

}