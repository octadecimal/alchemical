package alchemical.server;
import haxe.io.Bytes;
import haxe.io.BytesOutput;

/**
 * ...
 * @author Dylan Heyes
 */
class OutputPacket
{
	private var _bytes:BytesOutput;
	
	
	/**
	 * Constructor.
	 */
	public function new() 
	{
		_bytes = new BytesOutput();
	}
	
	
	
	// API
	// =========================================================================================
	
	public function getBytes():Bytes
	{
		return _bytes.getBytes();
	}
	
	public function writeCommand(value:Int):Void
	{
		writeInt16(value);
	}
	
	public function writeInt16(value:Int):Void
	{
		_bytes.writeInt16(value);
	}
	
	public function writeString(value:String):Void
	{
		writeInt16(value.length);
		_bytes.writeString(value);
	}
	
	public function writeBool(value:Int):Void
	{
		_bytes.writeByte(value);
	}
	
}