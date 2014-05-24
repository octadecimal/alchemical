/**
 * Copyright 2014, Dylan Heyes
 */
package alchemical.client.subsystems.ui.controller 
{
	import alchemical.client.core.enum.ComponentNames;
	import alchemical.client.core.notes.NetworkNotes;
	import alchemical.client.core.notes.UINotes;
	import alchemical.client.subsystems.ui.Chatbox;
	import alchemical.client.subsystems.ui.model.ChatMessage;
	import alchemical.client.subsystems.ui.UILayer;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;
	
	/**
	 * CBuildUIDisplayList
	 * @author Dylan Heyes
	 */
	public class CBuildUIDisplayList extends SimpleCommand 
	{
		override public function execute(notification:INotification):void 
		{
			var ui:UILayer = facade.retrieveMediator(ComponentNames.UI).getViewComponent() as UILayer;
			
			// Chatbox
			var chatbox:Chatbox = ui.chatbox;
			ui.addChild(chatbox);
			chatbox.y = ui.stage.stageHeight - chatbox.size.height;
			
			// Test
			sendNotification(UINotes.ADD_TO_CHAT, new ChatMessage(0, "WELCOME TO ALCHEMICAL DEBUG TEST SERVER.\n"));
			
		}
	}

}