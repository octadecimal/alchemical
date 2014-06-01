/**
 * Copyright 2014, Dylan Heyes
 */
package alchemical.debug.mediator 
{
	import alchemical.core.enum.ComponentNames;
	import alchemical.debug.Debugger;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.mediator.Mediator;
	
	/**
	 * DebuggerMediator
	 * @author Dylan Heyes
	 */
	public class DebuggerMediator extends Mediator 
	{
		private var _view:Debugger;
		
		/**
		 * Constructor.
		 * @param	viewComponent
		 */
		public function DebuggerMediator(viewComponent:Debugger) 
		{
			_view = viewComponent;
			super(ComponentNames.DEBUGGER, viewComponent);
		}
		
		
		
		// INTERNAL OVERRIDES
		// =========================================================================================
		
		override public function listNotificationInterests():Array 
		{
			return [/*NetworkNotes.TRANSFORM_NODE_RECEIVED*/];
		}
		
		override public function handleNotification(notification:INotification):void 
		{
			/*switch(notification.getName())
			{
				case NetworkNotes.TRANSFORM_NODE_RECEIVED:
					handleTransformNodeReceived(TransformNodeVO(notification.getBody()));
					break;
			}*/
		}
		
		
		
		// NOTIFICATION HANDLERS
		// =========================================================================================
		
		/*private function handleTransformNodeReceived(vo:TransformNodeVO):void 
		{
			_view.networkEntityOverlay.updateEntity(vo.id, vo.transform);
		}*/
		
	}

}