/**
 * Copyright 2014, Dylan Heyes
 */
package alchemical.client.subsystems.ui.mediator 
{
	import alchemical.client.core.enum.ComponentNames;
	import alchemical.client.core.notes.InputNotes;
	import alchemical.client.core.notes.NetworkNotes;
	import alchemical.client.core.notes.UINotes;
	import alchemical.client.subsystems.input.enum.EActions;
	import alchemical.client.subsystems.input.model.vo.MouseVO;
	import alchemical.client.subsystems.ui.Chatbox;
	import alchemical.client.subsystems.ui.events.UIEvent;
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
		
		override public function onRegister():void 
		{
			super.onRegister();
			
			_view.addEventListener(UIEvent.CHATBOX_FOCUSED, onChatboxFocused);
			_view.addEventListener(UIEvent.CHATBOX_UNFOCUSED, onChatboxUnfocused);
			_view.addEventListener(UIEvent.CHATBOX_MESSAGE_ENTERED, onChatboxMessageEntered);
		}
		
		override public function listNotificationInterests():Array 
		{
			return [
				NetworkNotes.CHAT_MESSAGE_RECEIVED,
				UINotes.ADD_TO_CHAT,
				InputNotes.KEY_UP,
				InputNotes.RIGHT_CLICK,
				InputNotes.MOUSE_WHEEL
			];
		}
		
		override public function handleNotification(notification:INotification):void 
		{
			switch(notification.getName())
			{
				case NetworkNotes.CHAT_MESSAGE_RECEIVED:
				case UINotes.ADD_TO_CHAT:
					handleChatMessageReceived(ChatMessage(notification.getBody()));
					break;
				
				case InputNotes.KEY_UP:
					handleKeyUp(int(notification.getBody()));
					break;
				
				case InputNotes.MOUSE_WHEEL:
					handleMouseWheel(MouseVO(notification.getBody()));
					break;
			}
		}
		
		
		
		// EVENT HANDLERS
		
		// =========================================================================================
		
		private function onChatboxFocused(e:UIEvent):void 
		{
			sendNotification(UINotes.CHATBOX_FOCUSED);
		}
		
		private function onChatboxUnfocused(e:UIEvent):void 
		{
			sendNotification(UINotes.CHATBOX_UNFOCUSED);
		}
		
		private function onChatboxMessageEntered(e:UIEvent):void 
		{
			sendNotification(UINotes.CHATBOX_MESSAGE_ENTERED, ChatMessage(e.data));
		}
		
		
		
		// NOTIFICATION HANDLERS
		// =========================================================================================
		
		private function handleChatMessageReceived(message:ChatMessage):void 
		{
			_view.addMessage(message);
		}
		
		private function handleKeyUp(action:int):void 
		{
			if (action == EActions.CHAT)
			{
				_view.toggleFocus();
			}
		}
		
		private function handleMouseWheel(mouseVO:MouseVO):void 
		{
			trace("SCROLL: " + mouseVO.delta);
			_view.scroll(mouseVO.delta);
		}
	}

}