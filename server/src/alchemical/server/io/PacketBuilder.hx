package alchemical.server.io;
import alchemical.server.const.Commands;
import alchemical.server.io.OutPacket;
import alchemical.server.Server.DynamicEntity;
import alchemical.server.Server.Entity;
import alchemical.server.Server.Pilot;
import alchemical.server.Server.Player;
import alchemical.server.Server.Ship;
import alchemical.server.Server.TransformNode;
import alchemical.server.Server.World;

/**
 * ...
 * @author Dylan Heyes
 */
class PacketBuilder
{
	/**
	 * Constructor.
	 */
	public function new()
	{
		
	}
	
	/**
	 * Writes a login success responseto the input packet.
	 * @param	packet
	 */
	public function loginSuccess(packet:OutPacket):Void
	{
		packet.writeCommand(Commands.LOGIN);
		packet.writeBool(1);					// success
	}
	
	/**
	 * Writes a login failure response to the input packet.
	 * @param	packet
	 */
	public function loginFailure(packet:OutPacket):Void
	{
		packet.writeCommand(Commands.LOGIN);// LOGIN
		packet.writeInt16(0);					// failure
	}
	
	/**
	 * Writes a world definition in the input packet.
	 * @param	packet
	 * @param	world
	 */
	public function defineWorld(packet:OutPacket, world:World):Void
	{
		packet.writeCommand(Commands.DEFINE_WORLD);
		packet.writeInt16(world.id);			// world id
		packet.writeString(world.name);			// world name
		packet.writeInt16(world.width);			// world width
		packet.writeInt16(world.height);		// world height
		packet.writeInt16(world.numSkyLayers);	// number of sky layers
		
		for (i in 0...world.numSkyLayers) 
		{
			packet.writeInt16(world.skyLayers[i]);
		}
	}
	
	/**
	 * Writes a player definition to the input packet.
	 * @param	packet
	 * @param	player
	 */
	public function definePlayer(packet:OutPacket, player:Player, ship:Ship) 
	{
		packet.writeCommand(Commands.DEFINE_PLAYER);
		packet.writeInt16(player.id);
		packet.writeString(player.name);
		packet.writeInt16(Std.int(player.transform.x));
		packet.writeInt16(Std.int(player.transform.y));
		packet.writeFloat(player.transform.r);
		packet.writeShip(ship);
	}
	
	/**
	 * Writes a ship definition to the input packet.
	 * @param	packet
	 * @param	player
	 * @param	ship
	 */
	public function defineShip(packet:OutPacket, ship:Ship) 
	{
		packet.writeCommand(Commands.DEFINE_SHIP);
		packet.writeShip(ship);
	}
	
	/**
	 * Writes npc definitions to the input packet.
	 * @param	packet
	 * @param	npcs
	 */
	public function definePilots(packet:OutPacket, pilots:Array<Pilot>) 
	{
		packet.writeCommand(Commands.DEFINE_PILOTS);
		packet.writeInt16(pilots.length);				// num total npcs
		
		for (i in 0...pilots.length)
		{
			definePilot(packet, pilots[i]);
		}
	}
	
	/**
	 * Writes a pilot definition to the inputted packet.
	 * @param	packet
	 * @param	pilot
	 */
	public function definePilot(packet:OutPacket, pilot:Pilot)
	{
		packet.writeInt16(pilot.id);
		packet.writeInt16(pilot.state);
		packet.writeInt16(pilot.faction);
		packet.writeTransform(pilot.transform);
		packet.writeDynamics(pilot.dynamics);
		packet.writeShip(pilot.ship);
	}
	
	/**
	 * Writes a move npc command to the input world 's out packet.
	 * @param	world
	 * @param	npc
	 * @param	target
	 */
	public function moveEntityTo(world:World, entity:DynamicEntity, target:TransformNode) 
	{
		if (world.outPacket == null)
		{
			world.outPacket = new OutPacket();
		}
		
		var packet:OutPacket = world.outPacket;
		
		packet.writeCommand(Commands.MOVE_NPC);
		packet.writeInt16(entity.id);
		packet.writeInt16(Std.int(target.x));
		packet.writeInt16(Std.int(target.y));
	}
	
	/**
	 * Writes a chat message to the input world's out packet.
	 * @param	world
	 * @param	type
	 * @param	msg
	 * @param	name
	 */
	public function chatMessage(world:World, type:Int, msg:String, name:String) 
	{
		if (world.outPacket == null)
		{
			world.outPacket = new OutPacket();
		}
		
		world.outPacket.writeCommand(Commands.CHAT_MSG);
		world.outPacket.writeInt16(type);
		world.outPacket.writeString(msg);
		world.outPacket.writeString(name);
	}
	
	/**
	 * Writes a entity transformation to the input world's out packet.
	 * @param	world
	 * @param	entity
	 */
	public function entityTransform(world:World, entity:Entity) 
	{
		if (world.outPacket == null)
		{
			world.outPacket = new OutPacket();
		}
		
		world.outPacket.writeCommand(Commands.ENTITY_TRANSFORM);
		world.outPacket.writeInt16(entity.id);
		world.outPacket.writeTransform(entity.transform);
	}
}