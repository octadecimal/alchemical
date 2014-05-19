package alchemical.server;

import neko.Lib;

/**
 * ...
 * @author Dylan Heyes
 */

class Main 
{
	
	static function main() 
	{
		_server = new Server();
		_server.run("localhost", 1337);
	}
	
	
	private static var _server:Server;
}