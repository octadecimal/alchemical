package alchemical.server.io;
import haxe.io.Bytes;
import haxe.io.BytesInput;

/**
 * ...
 * @author Dylan Heyes
 */
class InPacket
{
	/**
	 * Constructor.
	 * @param	bytes
	 */
	public function new(bytes:Bytes) 
	{
		_bytes = new BytesInput(bytes);
		_bytes.bigEndian = true;
		_bytes.position = 0;
	}
	
	
	
	// API
	// =========================================================================================
	
	public function readCommand():Int
	{
		return readInt16();
	}
	
	public function readInt16():Int
	{
		return _bytes.readInt16();
	}
	
	public function readString():String
	{
		var len:Int = readInt16();
		return _bytes.readString(len);
	}
	
	
	
	//  PRIVATE
	// =========================================================================================
	
	private var _bytes:BytesInput;
}