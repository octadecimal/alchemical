/**
 * Copyright 2014, Dylan Heyes
 */
package alchemical.client.subsystems.input.mediator 
{
	import alchemical.client.core.enum.ComponentNames;
	import alchemical.client.debugger.Debugger;
	import alchemical.client.core.notes.InputNotes;
	import alchemical.client.subsystems.input.model.InputProxy;
	import alchemical.client.subsystems.input.model.vo.MouseVO;
	import flash.events.MouseEvent;
	import org.puremvc.as3.patterns.mediator.Mediator;
	import starling.core.Starling;
	import starling.display.Stage;
	import starling.events.KeyboardEvent;
	import starling.events.TouchEvent;
	
	/**
	 * InputMediator
	 * @author Dylan Heyes
	 */
	public class InputMediator extends Mediator 
	{
		/**
		 * Constructor.
		 * @param	viewComponent 		Starling game stage.
		 */
		public function InputMediator(viewComponent:Stage) 
		{
			_view = viewComponent as Stage;
			super(ComponentNames.INPUT, viewComponent);
			Debugger.log(this, "Created.");
		}
		
		
		
		// INTERNAL OVERRIDES
		// =========================================================================================
		
		override public function onRegister():void 
		{
			super.onRegister();
			
			_proxy = facade.retrieveProxy(ComponentNames.INPUT) as InputProxy;
			
			// Native events
			_view.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
			_view.addEventListener(KeyboardEvent.KEY_UP, onKeyUp);
			_view.addEventListener(TouchEvent.TOUCH, onTouch);
			
			// Handle events not supported by starling
			var starling:Starling = facade.retrieveMediator(ComponentNames.GRAPHICS).getViewComponent() as Starling;
			starling.nativeStage.addEventListener(MouseEvent.RIGHT_CLICK, onMouseRightClick);
			starling.nativeStage.addEventListener(MouseEvent.MOUSE_WHEEL, onMouseWheel);
		}
		
		
		
		// EVENT HANDLERS
		
		// =========================================================================================
		
		private function onKeyDown(e:KeyboardEvent):void 
		{
			// Key is not already down
			if (!_proxy.isKeyDown(e.keyCode))
			{
				// Flag as down
				_proxy.setKeyAsDown(e.keyCode);
				
				// Send action
				sendNotification(InputNotes.KEY_DOWN, _proxy.getActionCodeByAscii(e.keyCode), _proxy.focus);
			}
		}
		
		private function onKeyUp(e:KeyboardEvent):void 
		{
			// Key is already down
			if (_proxy.isKeyDown(e.keyCode))
			{
				// Flag as up
				_proxy.setKeyAsUp(e.keyCode);
				
				// Send action
				sendNotification(InputNotes.KEY_UP, _proxy.getActionCodeByAscii(e.keyCode), _proxy.focus);
			}
		}
		
		private function onTouch(e:TouchEvent):void 
		{
			
		}
		
		private function onMouseRightClick(e:MouseEvent):void 
		{
			sendNotification(InputNotes.RIGHT_CLICK, new MouseVO(e.stageX, e.stageY));
		}
		
		private function onMouseWheel(e:MouseEvent):void 
		{
			trace("DELTA: " + e.delta);
			sendNotification(InputNotes.MOUSE_WHEEL, new MouseVO(e.stageX, e.stageY, e.delta));
		}
		
		
		
		// ACCESSORS
		// =========================================================================================
		
		/**
		 * Starling game stage.
		 */
		public function get view():Stage		{ return _view; }
		private var _view:Stage;
		
		
		
		// PRIVATE
		// =========================================================================================
		
		// For performance reasons, allowing mediator access to proxy, rather than mapping to commands,
		// since key events can get quite spammy, and commands would require us to retrieve our input proxy
		// on every single keystroke.
		private var _proxy:InputProxy;
	}
}