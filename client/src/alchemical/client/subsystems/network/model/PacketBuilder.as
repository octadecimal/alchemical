/**
 * Copyright 2014, Dylan Heyes
 */
package alchemical.client.subsystems.network.model 
{
	import alchemical.client.subsystems.network.enum.ENetcode;
	import alchemical.client.subsystems.network.model.packets.Packet;
	import alchemical.client.subsystems.ui.model.ChatMessage;
	
	/**
	 * PacketBuilder
	 * @author Dylan Heyes
	 */
	public class PacketBuilder 
	{
		/**
		 * Writes a login request.
		 * @param	packet	Packet to be written to.
		 * @param	user	User login credentials.
		 * @param	pass	User password credentials.
		 */
		public function login(packet:Packet, user:String, pass:String):void 
		{
			packet.writeCommand(ENetcode.LOGIN);
			packet.writeString(user);
			packet.writeString(pass);
			
		}
		
		/**
		 * Writes a chat message.
		 * @param	packet			Packet to be written to.
		 * @param	chatMessage		Chat message datatype.
		 */
		public function chatMessage(packet:Packet, chatMessage:ChatMessage):void 
		{
			packet.writeCommand(ENetcode.CHAT_MESSAGE);
			packet.writeInt16(chatMessage.type);
			packet.writeString(chatMessage.msg);
		}
		
	}

}