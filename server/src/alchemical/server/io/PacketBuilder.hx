package alchemical.server.io;
import alchemical.server.const.Commands;
import alchemical.server.Server.NPC;
import alchemical.server.Server.Player;
import alchemical.server.Server.Ship;
import alchemical.server.Server.TransformNode;
import alchemical.server.Server.World;
import alchemical.server.io.OutPacket;
import alchemical.server.util.Debugger;

/**
 * ...
 * @author Dylan Heyes
 */
class PacketBuilder
{
	public function new()
	{
		
	}
	
	
	public function loginSuccess(packet:OutPacket):Void
	{
		packet.writeCommand(Commands.LOGIN);
		packet.writeBool(1);					// success
	}
	
	
	public function loginFailure(packet:OutPacket):Void
	{
		packet.writeCommand(Commands.LOGIN);// LOGIN
		packet.writeInt16(0);					// failure
	}
	
	
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
	
	
	public function definePlayer(packet:OutPacket, player:Player) 
	{
		packet.writeCommand(Commands.DEFINE_PLAYER);
		packet.writeInt16(player.id);
		packet.writeString(player.name);
		packet.writeInt16(player.ship);
		packet.writeInt16(Std.int(player.position.x));
		packet.writeInt16(Std.int(player.position.y));
	}
	
	public function definePlayerShip(packet:OutPacket, player:Player, ship:Ship) 
	{
		packet.writeCommand(Commands.DEFINE_PLAYER_SHIP);
		packet.writeInt16(ship.id);
		packet.writeInt16(ship.type);
		packet.writeInt16(ship.hull);
	}
	
	public function defineNPCs(packet:OutPacket, npcs:Array<NPC>) 
	{
		var npc:NPC;
		
		packet.writeCommand(Commands.DEFINE_NPCS);
		packet.writeInt16(npcs.length);				// num total npcs
		
		for (i in 0...npcs.length)
		{
			npc = npcs[i];
			packet.writeInt16(npc.id);
			packet.writeInt16(npc.world);
			packet.writeInt16(npc.ship);
			packet.writeInt16(Std.int(npc.position.x));
			packet.writeInt16(Std.int(npc.position.y));
			packet.writeInt16(npc.faction);
		}
	}
	
	public function moveWorldNPCTo(world:World, npc:NPC, target:TransformNode) 
	{
		if (world.outPacket == null)
		{
			world.outPacket = new OutPacket();
		}
		
		var packet:OutPacket = world.outPacket;
		
		packet.writeCommand(Commands.MOVE_NPC);
		packet.writeInt16(npc.id);
		packet.writeInt16(Std.int(target.x));
		packet.writeInt16(Std.int(target.y));
	}
	
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
}