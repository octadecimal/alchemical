/**
 * Copyright 2014, Dylan Heyes
 */
package alchemical.client.subsystems.network.model 
{
	import alchemical.client.debugger.Debugger;
	import flash.events.Event;
	import flash.net.Socket;
	import flash.utils.Endian;
	
	/**
	 * NetworkSocket
	 * @author Dylan Heyes
	 */
	public class NetworkSocket extends Socket 
	{
		
		public function NetworkSocket(host:String=null, port:int=0) 
		{
			timeout = 3500;
			
			super(host, port);
			
			endian = Endian.LITTLE_ENDIAN;
		}
		
		override public function close():void 
		{
			Debugger.log(this, "Closing...");
			super.close();
		}
	}

}