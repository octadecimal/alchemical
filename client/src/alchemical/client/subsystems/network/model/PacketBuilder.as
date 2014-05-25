/**
 * Copyright 2014, Dylan Heyes
 */
package alchemical.client.subsystems.network.model 
{
	import alchemical.client.subsystems.network.enum.ENetcode;
	import alchemical.client.subsystems.network.model.packets.Packet;
	
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
		
	}

}