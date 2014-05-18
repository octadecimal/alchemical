/**
 * Copyright 2014, Dylan Heyes
 */
package alchemical.client.subsystems.ui.screens 
{
	import alchemical.client.subsystems.ui.controls.UIButton;
	import alchemical.client.subsystems.ui.events.UIEvent;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.textures.Texture;
	
	/**
	 * LoginScreen
	 * @author Dylan Heyes
	 */
	public class LoginScreen extends Sprite 
	{
		/**
		 * Constructor.
		 */
		public function LoginScreen(texture:Texture, button:UIButton) 
		{
			_button = button;
			
			super();
			
			addChild(new Image(texture));
			addChild(button);
			
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			
			_button.addEventListener(TouchEvent.TOUCH, onButtonTouch);
		}
		
		/**
		 * Disposer.
		 */
		override public function dispose():void 
		{
			super.dispose();
			
			_button.dispose();
			_button = null;
			
			removeChildren();
			removeFromParent();
		}
		
		
		
		// API
		// =========================================================================================
		
		public function hide():void 
		{
			dispose();
		}
		
		
		
		// EVENTS
		// =========================================================================================
		
		private function onAddedToStage(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			
			_button.pivotX = _button.width / 2;
			
			_button.x = stage.stageWidth / 2;
			_button.y = stage.stageHeight - _button.height - 100;
		}
		
		private function onButtonTouch(e:TouchEvent):void 
		{
			if (e.getTouch(_button, TouchPhase.ENDED))
			{
				dispatchEvent(new UIEvent(UIEvent.PLAY_NOW_CLICKED, {user: "test", pass: "test"}));
				//dispose();
				_button.enabled = false;
			}
		}
		
		
		
		// PRIVATE
		// =========================================================================================
		
		private var _button:UIButton;
	}

}