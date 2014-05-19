/**
 * Copyright 2014, Dylan Heyes
 */
package alchemical.client.subsystems.network.model.packets 
{
	import flash.utils.ByteArray;
	/**
	 * Packet
	 * @author Dylan Heyes
	 */
	public class Packet 
	{
		/**
		 * Constructor.
		 */
		public function Packet(bytes:ByteArray = null) 
		{
			_bytes = bytes ? bytes : new ByteArray();
		}
		
		
		
		// WRITE
		// =========================================================================================
		
		public function writeCommand(value:int):void
		{
			writeInt16(value);
		}
		
		public function writeInt16(value:int):void
		{
			_bytes.writeShort(value);
		}
		
		public function writeString(value:String):void
		{
			writeInt16(value.length);
			_bytes.writeUTFBytes(value);
		}
		
		
		
		// PRIVATE
		// =========================================================================================
		
		/**
		 * Raw packet bytes.
		 */
		public function set bytes(a:ByteArray):void			{ _bytes = a; }
		public function get bytes():ByteArray				{ return _bytes; }
		private var _bytes:ByteArray;
	}

}