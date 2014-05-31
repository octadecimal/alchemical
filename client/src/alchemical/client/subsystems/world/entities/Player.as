/**
 * Copyright 2014, Dylan Heyes
 */
package alchemical.client.subsystems.world.entities 
{
	import alchemical.client.subsystems.world.model.TransformNode;
	import flash.geom.Point;
	import starling.events.EnterFrameEvent;
	import starling.events.Event;
	
	/**
	 * Player
	 * @author Dylan Heyes
	 */
	public class Player/* extends Entity */
	{
		public function Player(id:int) 
		{
			super(/*id*/);
			
			//view.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			
			// Temp
			//view.addEventListener(EnterFrameEvent.ENTER_FRAME, onUpdate);
		}
		
		private function onUpdate(e:EnterFrameEvent):void 
		{
			_ship.setThrust(dynamics.acceleration);
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
			dynamics.destination = new TransformNode(position.x, position.y);
			ship.dynamics.destination = dynamics.destination;
			
			view.addEventListener(EnterFrameEvent.ENTER_FRAME, onFollowUpdate);
		}
		
		private function onFollowUpdate(e:EnterFrameEvent):void 
		{
			if (Math.abs(dynamics.destination.x - transform.x) <= 100)
			{
				if (Math.abs(dynamics.destination.y - transform.y) <= 100)
				{
					dynamics.destination = null;
					
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