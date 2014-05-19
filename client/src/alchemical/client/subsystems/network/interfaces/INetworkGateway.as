package alchemical.client.subsystems.network.interfaces 
{
	import alchemical.client.subsystems.network.model.packets.Packet;
	import flash.utils.ByteArray;
	
	/**
	 * ...
	 * @author Dylan Heyes
	 */
	public interface INetworkGateway
	{
		function addEventListener(type:String, listener:Function):void
		
		function send(packet:Packet):void;
	}
	
}