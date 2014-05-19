package alchemical.server;
import neko.Lib;

/**
 * ...
 * @author Dylan Heyes
 */
class Debugger
{
	static public function server( msg:Dynamic):Void
	{
		Lib.println("--> SRV: "+msg);
	}
	
	static public function database( msg:Dynamic):Void
	{
		Lib.println("    SQL: "+msg);
	}
}