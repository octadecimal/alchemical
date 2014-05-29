package alchemical.server.db;
import alchemical.server.const.EntityStates;
import alchemical.server.const.Passwords;
import alchemical.server.Server.DynamicsNode;
import alchemical.server.Server.Pilot;
import alchemical.server.Server.Player;
import alchemical.server.Server.Ship;
import alchemical.server.Server.ShipEngine;
import alchemical.server.Server.ShipHull;
import alchemical.server.Server.TransformNode;
import alchemical.server.Server.World;
import alchemical.server.util.Debugger;
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
	
	/**
	 * Connects to the MySQL database.
	 */
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
	
	/**
	 * Disconnects the MySQL database.
	 */
	public function disconnect():Void
	{
		_connection.close();
	}
	
	/**
	 * Executes a raw query on the MySQL database and returns
	 * the results as a ResultSet.
	 * @param	string
	 * @return
	 */
	private function query(string:String):ResultSet
	{
		Debugger.database("QUERY: " + string);
		return _connection.request(string);
	}
	
	
	
	// QUERIES
	// =========================================================================================
	
	/**
	 * Returns all world definitions.
	 * @return
	 */
	public function getWorlds():Array<World>
	{
		var output:Array<World> = [];
		
		var result:ResultSet = query(new Query().select("*").from("worlds").getQuery());
		
		for (row in result)
		{
			var skyLayers:Array<Int> = [];
			var skyLayerIDs:Array<String> = row.skylayers.split(",");
			for (id in skyLayerIDs)
			{
				skyLayers.push(Std.parseInt(id));
			}
			
			var world:World = { 
				id: row.id,
				name: row.name,
				width: row.width,
				height: row.height,
				numSkyLayers: row.numskylayers,
				skyLayers: skyLayers,
				players: [],
				pilots: [],
				entities: [],
				outPacket: null
			};
			
			Debugger.database(world.id + " -> " + world.name + " "+world.width+","+world.height+","+world.numSkyLayers);
			output.push(world);
		}
		
		return output;
	}
	
	/**
	 * Gets a user id by input user and password credentials.
	 * @param	user
	 * @param	pass
	 * @return	Returns 0 if user with inputted credentials does not exist.
	 */
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
	
	/**
	 * Gets a player definition by inputted ID.
	 * @param	id
	 * @return
	 */
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
				vy: 0,
				target: null
			}
			
			player = { 
				id: row.id, 
				user: row.user, 
				name: row.name, 
				world: row.world, 
				ship: row.ship, 
				transform: transform,
				dynamics: dynamics,
				state: EntityStates.IDLE
			};
		}
		
		Debugger.database("PLAYER: " + player.id + " -> " + player.name + " (" + player.transform.x + "," + player.transform.y+")");
		return player;
	}
	
	/**
	 * Gets all NPCs by inputted world id.
	 * @param	worldID
	 * @return
	 */
	public function getPilotsByWorld(worldID:Int):Array<Pilot> 
	{
		var pilot:Pilot, transform:TransformNode, dynamics:DynamicsNode;
		var output:Array<Pilot> = new Array<Pilot>();
		
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
				vy: 0,
				target: null
			}
			
			pilot = {
				id: row.id,
				world: row.world,
				ship: row.ship,
				faction: row.faction,
				transform: transform,
				dynamics: dynamics,
				state: EntityStates.IDLE
			}
			
			output.push(pilot);
		}
		
		Debugger.database("Pilots: " + worldID + " -> " + output.length);
		return output;
	}
	
	/**
	 * Gets a ship definition by ship id.
	 * @param	id
	 * @return
	 */
	public function getShip(id:Int):Ship
	{
		var ship:Ship, shipHull:ShipHull;
		var shipEngines:Array<ShipEngine> = [];
		
		var result:ResultSet = query(new Query().select("*").from("ship_definitions").where("id", id).getQuery());
		
		for (row in result)
		{
			shipHull = getHull(row.hull);
			
			var numEngines:Int = row.num_engines;
			if (numEngines > 0)
			{
				for (i in 0...numEngines)
				{
					shipEngines.push(getEngine(row.engine_0));
				}
			}
			
			ship = {
				id: row.id,
				type: 0, // TODO: Implement
				hull: shipHull,
				engines: shipEngines
			}
		}
		
		Debugger.database("SHIP: id=" + ship.id + " type=" + ship.type + " hull=" + ship.hull + " engines=" + ship.engines);
		return ship;
	}
	
	/**
	 * Gets a ship hull definition by hull id.
	 * @param	id
	 * @return
	 */
	public function getHull(id:Int):ShipHull
	{
		var hull:ShipHull;
		
		var result:ResultSet = query(new Query().select("*").from("ship_hulls").where("id", id).getQuery());
		
		for (row in result)
		{
			hull = {
				id: row.id,
				mass: row.mass
			}
		}
		
		Debugger.database("HULL: id=" + hull.id + " mass=" + hull.mass);
		return hull;
	}
	
	/**
	 * Gets a ship engine definition by engine id.
	 * @param	id
	 * @return
	 */
	public function getEngine(id:Int):ShipEngine 
	{
		var engine:ShipEngine;
		
		var result:ResultSet = query(new Query().select("*").from("ship_engines").where("id", id).getQuery());
		
		for (row in result)
		{
			engine = {
				id: row.id,
				thrust: row.thrust,
				torque: row.torque
			}
		}
		
		Debugger.database("ENGINE: id=" + engine.id + " thrust=" + engine.thrust + " torque=" + engine.torque);
		return engine;
	}
}