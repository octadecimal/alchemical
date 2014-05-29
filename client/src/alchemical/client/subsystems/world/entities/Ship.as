/**
 * Copyright 2014, Dylan Heyes
 */
package alchemical.client.subsystems.world.entities 
{
	import starling.core.Starling;
	import starling.display.Image;
	import starling.display.MovieClip;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.textures.Texture;
	
	/**
	 * Ship
	 * @author Dylan Heyes
	 */
	public class Ship extends Entity
	{
		private var _hull:Image;
		private var _thrust:MovieClip;
		
		/**
		 * Constructor.
		 */
		public function Ship(id:int, view:Sprite = null) 
		{
			super(id, view);
			
			this.view.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		private function onAddedToStage(e:Event):void 
		{
			view.removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			
			view.pivotX = view.width / 2;
			view.pivotY = view.height / 2;
		}
		
		
		
		// API
		// =========================================================================================
		
		public function setThrust(value:Number):void
		{
			//_thrust.alpha = Math.min(1, value);
			
			_thrust.scaleY = Math.max(0.25, value);
		}
		
		
		
		// TEXTURES
		// =========================================================================================
		
		public function setHullTexture(texture:Texture):void
		{
			if (_hull == null)
			{
				_hull = new Image(texture);
				Sprite(view).addChild(_hull);
			}
			else
			{
				_hull.texture = texture;
			}
		}
		
		public function setThrustTexture(thrust:MovieClip):void 
		{
			_thrust = thrust;
			
			Sprite(view).addChildAt(thrust, 0);
			thrust.loop = true;
			thrust.play();
			
			thrust.rotation = Math.PI;
			
			thrust.pivotX = view.width / 2;
			
			thrust.x = 0.5;
			thrust.y = 15;
			
			// Temp
			Starling.juggler.add(thrust);
		}
	}

}