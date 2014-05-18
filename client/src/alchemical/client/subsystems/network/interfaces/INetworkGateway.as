package alchemical.client.subsystems.network.interfaces 
{
	import flash.utils.ByteArray;
	
	/**
	 * ...
	 * @author Dylan Heyes
	 */
	public interface INetworkGateway
	{
		function addEventListener(type:String, listener:Function):void
		
		function send(bytes:ByteArray):void;
	}
	
}