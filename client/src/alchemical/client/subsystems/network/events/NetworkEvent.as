/**
 * Copyright 2014, Dylan Heyes
 */
package alchemical.client.subsystems.network.events 
{
	import flash.utils.IDataInput;
	import starling.events.Event;
	
	/**
	 * NetworkEvent
	 * @author Dylan Heyes
	 */
	public class NetworkEvent extends Event 
	{
		static public const DATA_RECEIVED:String = "dataReceived";
		
		public var bytes:IDataInput;
		
		public function NetworkEvent(type:String, bytes:IDataInput) 
		{
			this.bytes = bytes;
			super(type, false, bytes);
		}
		
	}

}