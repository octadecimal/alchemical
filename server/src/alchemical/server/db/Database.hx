package alchemical.server.db;
import alchemical.server.const.EntityStates;
import alchemical.server.const.Passwords;
import alchemical.server.Server.DynamicsNode;
import alchemical.server.Server.NPC;
import alchemical.server.Server.Player;
import alchemical.server.Server.Ship;
import alchemical.server.Server.TransformNode;
import alchemical.server.Server.World;
import alchemical.server.util.Debugger;
import haxe.ds.Vector;
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
				skyLayers: parseSkyLayers(row.skylayers),
				players: [],
				npcs: [],
				entities: [],
				outPacket: null
			};
			
			Debugger.database(world.id + " -> " + world.name + " "+world.width+","+world.height+","+world.numSkyLayers);
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
	
	public function getUserIDByCredentials(user:String, pass:String):UInt
	{
		var result:ResultSet = query(new Query().select("*").from("users").where("name", user).and("pass", pass).getQuery());
		
		if (result.length == 0)
			return 0;
		
		for (row in result)
		{
			if (row.name == user && row.pass == pass)
				return row.id;
		}
		
		return 0;
	}
	
	public function getPlayer(id:UInt):Player
	{
		var player:Player, transform:TransformNode, dynamics:DynamicsNode;
		
		var result:ResultSet = query(new Query().select("*").from("players").where("user", id).getQuery());
		
		for (row in result)
		{
			transform = {
				x: row.x,
				y: row.y,
				r: 0
			};
			
			dynamics = {
				mass: 1,
				thrust: 2,
				torque: 0.3,
				acceleration: 0,
				angularAcceleration: 0,
				vx: 0,
				vy: 0
			}
			
			player = { 
				id: row.id, 
				user: row.user, 
				name: row.name, 
				world: row.world, 
				ship: row.ship, 
				transform: transform,
				dynamics: dynamics,
				state: EntityStates.IDLE,
				destination: null
			};
		}
		
		Debugger.database("PLAYER: " + player.id + " -> " + player.name + " (" + player.transform.x + "," + player.transform.y+")");
		return player;
	}
	
	public function getPlayerShip(id:UInt):Ship
	{
		var ship:Ship;
		var result:ResultSet = query(new Query().select("*").from("ships").where("id", id).getQuery());
		
		for (row in result)
		{
			ship = {
				id: row.id,
				type: row.id,
				hull: row.hull
			};
		}
		
		Debugger.database("SHIP: " + id + " -> " + ship.id);
		return ship;
	}
	
	public function getNPCsByWorld(worldID:Int):Array<NPC> 
	{
		var npc:NPC, transform:TransformNode, dynamics:DynamicsNode;
		var output:Array<NPC> = new Array<NPC>();
		
		var result:ResultSet = query(new Query().select("*").from("npcs").where("world", worldID).getQuery());
		
		for (row in result)
		{
			transform = {
				x: row.x,
				y: row.y,
				r: 0
			}
			
			dynamics = {
				mass: 1,
				thrust: 2,
				torque: 0.3,
				acceleration: 0,
				angularAcceleration: 0,
				vx: 0,
				vy: 0
			}
			
			npc = {
				id: row.id,
				world: row.world,
				ship: row.ship,
				faction: row.faction,
				transform: transform,
				dynamics: dynamics,
				state: EntityStates.IDLE,
				destination: null
			}
			
			output.push(npc);
		}
		
		Debugger.database("NPCS: " + worldID + " -> " + output.length);
		return output;
	}
	
	/*public function defineShip(id:Int):Ship
	{
		var ship:Ship, var hullID:Int;
		
		// Get ship definition
		var result:ResultSet = query(new Query().select("*").from("ship_definitions").where("id", id).getQuery());
		
		// Handle ship definition
		for (row in result)
		{
			// Hull
			hullID = row.hull;
			
			
			ship = {
				
			}
		}
	}*/
}