/**
 * Copyright 2014, Dylan Heyes
 */
package alchemical.client.subsystems.ui.controller 
{
	import alchemical.client.core.enum.ComponentNames;
	import alchemical.client.subsystems.ui.Chatbox;
	import alchemical.client.subsystems.ui.mediator.ChatboxMediator;
	import alchemical.client.subsystems.ui.UILayer;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;
	
	/**
	 * CCreateChatbox
	 * @author Dylan Heyes
	 */
	public class CCreateChatbox extends SimpleCommand 
	{
		override public function execute(notification:INotification):void 
		{
			var ui:UILayer = facade.retrieveMediator(ComponentNames.UI).getViewComponent() as UILayer;
			
			var chatbox:Chatbox = new Chatbox();
			facade.registerMediator(new ChatboxMediator(chatbox));
			
			ui.chatbox = chatbox;
		}
	}

}