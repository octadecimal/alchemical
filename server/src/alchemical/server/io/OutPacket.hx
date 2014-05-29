package alchemical.server.io;
import alchemical.server.Server.DynamicsNode;
import alchemical.server.Server.TransformNode;
import alchemical.server.util.Debugger;
import haxe.io.Bytes;
import haxe.io.BytesOutput;

/**
 * ...
 * @author Dylan Heyes
 */
class OutPacket
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
		Debugger.raw("");
		Debugger.raw("-- GETBYTES --");
		Debugger.raw("");
		return _bytes.getBytes();
	}
	
	public function writeCommand(value:Int):Void
	{
		Debugger.rawCommand(value);
		_bytes.writeInt16(value);
	}
	
	public function writeInt16(value:Int):Void
	{
		Debugger.raw("[I16] " + value);
		_bytes.writeInt16(value);
	}
	
	public function writeString(value:String):Void
	{
		Debugger.raw("[STR] " + value);
		writeInt16(value.length);
		_bytes.writeString(value);
	}
	
	public function writeBool(value:Int):Void
	{
		Debugger.raw("[BOL] " + value);
		_bytes.writeByte(value);
	}
	
	public function writeFloat(value:Float) 
	{
		Debugger.raw("[FLT] " + value);
		_bytes.writeFloat(value);
	}
	
	public function writeTransform(transform:TransformNode) 
	{
		Debugger.raw("[TFM] " + transform.x+","+transform.y+","+transform.r);
		_bytes.writeFloat(transform.x);
		_bytes.writeFloat(transform.y);
		_bytes.writeFloat(transform.r);
	}
	
	public function writeDynamics(dynamics:DynamicsNode)
	{
		Debugger.raw("[DYN] " + dynamics.vx + "," + dynamics.vy + "," + dynamics.angularAcceleration);
		
		_bytes.writeFloat(dynamics.mass);
		_bytes.writeFloat(dynamics.thrust);
		_bytes.writeFloat(dynamics.torque);
		_bytes.writeFloat(dynamics.acceleration);
		_bytes.writeFloat(dynamics.angularAcceleration);
		_bytes.writeFloat(dynamics.vx);
		_bytes.writeFloat(dynamics.vy);
		writeTransform(dynamics.target);
	}
	
}