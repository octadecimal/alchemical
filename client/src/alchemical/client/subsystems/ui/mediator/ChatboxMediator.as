/**
 * Copyright 2014, Dylan Heyes
 */
package alchemical.client.subsystems.ui.mediator 
{
	import alchemical.client.core.enum.ComponentNames;
	import alchemical.client.core.notes.NetworkNotes;
	import alchemical.client.core.notes.UINotes;
	import alchemical.client.subsystems.ui.Chatbox;
	import alchemical.client.subsystems.ui.model.ChatMessage;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.mediator.Mediator;
	
	/**
	 * ChatboxMediator
	 * @author Dylan Heyes
	 */
	public class ChatboxMediator extends Mediator 
	{
		private var _view:Chatbox;
		
		/**
		 * Constructor.
		 * @param	viewComponent
		 */
		public function ChatboxMediator(viewComponent:Chatbox) 
		{
			_view = viewComponent;
			super(ComponentNames.CHATBOX, viewComponent);
		}
		
		
		
		// INTERNAL OVERRIDES
		// =========================================================================================
		
		override public function listNotificationInterests():Array 
		{
			return [
				NetworkNotes.CHAT_MESSAGE_RECEIVED,
				UINotes.ADD_TO_CHAT
			];
		}
		
		override public function handleNotification(notification:INotification):void 
		{
			switch(notification.getName())
			{
				case NetworkNotes.CHAT_MESSAGE_RECEIVED:
				case UINotes.ADD_TO_CHAT:
					handleChatMessageReceived(notification);
					break;
			}
		}
		
		
		
		// NOTIFICATION HANDLERS
		// =========================================================================================
		
		private function handleChatMessageReceived(notification:INotification):void 
		{
			_view.addMessage(notification.getBody() as ChatMessage);
		}
	}

}