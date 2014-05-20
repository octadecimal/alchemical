package alchemical.server.util;
import neko.Lib;

/**
 * ...
 * @author Dylan Heyes
 */
class Debugger
{
	static public function server(msg:Dynamic):Void
	{
		Lib.println("    SRV: "+msg);
	}
	
	static public function database(msg:Dynamic):Void
	{
		Lib.println("    SQL: "+msg);
	}
	
	static public function data(msg:Dynamic):Void
	{
		Lib.println("       : "+msg);
	}
	
	static public function info(msg:Dynamic) 
	{
		Lib.println("");
		Lib.println("--> SRV: "+msg);
		Lib.println("");
	}
}