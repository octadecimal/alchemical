/**
 * Copyright 2014, Dylan Heyes
 */
package alchemical.client.subsystems.input.mediator 
{
	import alchemical.client.core.enum.ComponentNames;
	import alchemical.client.debugger.Debugger;
	import alchemical.client.core.notes.InputNotes;
	import alchemical.client.subsystems.input.model.InputProxy;
	import org.puremvc.as3.patterns.mediator.Mediator;
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
			
			_view.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
			_view.addEventListener(KeyboardEvent.KEY_UP, onKeyUp);
			_view.addEventListener(TouchEvent.TOUCH, onTouch);
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
				sendNotification(InputNotes.KEY_DOWN, _proxy.getActionCodeByAscii(e.keyCode));
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
				sendNotification(InputNotes.KEY_UP, _proxy.getActionCodeByAscii(e.keyCode));
			}
		}
		
		private function onTouch(e:TouchEvent):void 
		{
			
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