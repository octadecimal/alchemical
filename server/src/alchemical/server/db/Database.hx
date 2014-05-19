package alchemical.server.db;
import alchemical.server.const.Passwords;
import alchemical.server.Server.World;
import alchemical.server.util.Debugger;
import neko.Lib;
import sys.db.Connection;
import sys.db.Mysql;
import sys.db.ResultSet;

/**
 * ...
 * @author Dylan Heyes
 */
class Database
{
	// MySQL connection
	private var _connection:Connection;
	
	/**
	 * Constructor.
	 */
	public function new() 
	{
		connect();
	}
	
	
	
	// CORE
	// =========================================================================================
	
	public function connect():Void
	{
		_connection = Mysql.connect(
		{
			host: "localhost",
			port: 3306,
			user: "alchemical",
			pass: Passwords.DATABASE,
			socket: null,
			database: "alchemical"
		});
		
		if (_connection != null)
		{
			Debugger.database("Connected.");
		}
	}
	
	public function disconnect():Void
	{
		_connection.close();
	}
	
	private function query(string:String):ResultSet
	{
		Debugger.database("QUERY: " + string);
		
		return _connection.request(string);
	}
	
	
	
	// QUERIES
	// =========================================================================================
	
	public function getWorlds():Array<World>
	{
		var output:Array<World> = [];
		
		var result:ResultSet = query(new Query().select("*").from("worlds").getQuery());
		
		for (row in result)
		{
			var world:World = { 
				id: row.id,
				name: row.name,
				width: row.width,
				height: row.height,
				numSkyLayers: row.numskylayers,
				skyLayers: parseSkyLayers(row.skylayers)
			};
			
			Debugger.database(world.id + " -> " + world.name);
			output.push(world);
		}
		
		return output;
	}
	
	function parseSkyLayers(input:String):Array<Int> 
	{
		var output:Array<Int> = [];
		var ids:Array<String> = input.split(",");
		for (id in ids)
		{
			output.push(Std.parseInt(id));
		}
		return output;
	}
	
	public function isValidUser(user:String, pass:String):Bool
	{
		var q:String = new Query().select("*").from("users").where("name", user).and("pass", pass).getQuery();
		var result:ResultSet = query(q);
		
		if (result.length == 0)
			return false;
		
		for (row in result)
		{
			if (row.name == user && row.pass == pass)
				return true;
		}
		
		return false;
	}
}