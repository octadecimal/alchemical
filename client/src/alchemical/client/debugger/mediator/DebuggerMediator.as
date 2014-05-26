/**
 * Copyright 2014, Dylan Heyes
 */
package alchemical.client.debugger.mediator 
{
	import alchemical.client.core.enum.ComponentNames;
	import alchemical.client.core.notes.NetworkNotes;
	import alchemical.client.debugger.Debugger;
	import alchemical.client.subsystems.network.model.vo.TransformNodeVO;
	import alchemical.client.subsystems.world.model.TransformNode;
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
			return [NetworkNotes.TRANSFORM_NODE_RECEIVED];
		}
		
		override public function handleNotification(notification:INotification):void 
		{
			switch(notification.getName())
			{
				case NetworkNotes.TRANSFORM_NODE_RECEIVED:
					handleTransformNodeReceived(TransformNodeVO(notification.getBody()));
					break;
			}
		}
		
		
		
		// NOTIFICATION HANDLERS
		// =========================================================================================
		
		private function handleTransformNodeReceived(vo:TransformNodeVO):void 
		{
			_view.networkEntityOverlay.updateEntity(vo.id, vo.transform);
		}
		
	}

}