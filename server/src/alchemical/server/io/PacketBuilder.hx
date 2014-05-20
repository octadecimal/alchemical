package alchemical.server.io;
import alchemical.server.Server.World;
import alchemical.server.io.OutPacket;

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
		packet.writeCommand(2);					// LOGIN
		packet.writeBool(1);					// success
	}
	
	
	public function loginFailure(packet:OutPacket):Void
	{
		packet.writeCommand(2);					// LOGIN
		packet.writeInt16(0);					// failure
	}
	
	
	public function defineWorld(packet:OutPacket, world:World):Void
	{
		packet.writeCommand(4);					// DEFINE_WORLD
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
}