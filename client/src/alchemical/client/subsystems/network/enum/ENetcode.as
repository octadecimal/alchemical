/**
 * Copyright 2014, Dylan Heyes
 */
package alchemical.client.subsystems.network.enum 
{
	/**
	 * ENetworkCommands
	 * @author Dylan Heyes
	 */
	public class ENetcode 
	{
		// Total number of commands to be mapped.
		static public const TOTAL_COMMANDS:uint = 16;
		
		// END FLAG
		static public const END:uint = 1;
		
		// Command codes
		static public const LOGIN:uint = 2;
		//static public const LOGIN_OK:uint = 3;	// NOT USED
		static public const DEFINE_WORLD:uint = 4;
		static public const DEFINE_PLAYER:uint = 5;
		static public const DEFINE_PLAYER_SHIP:uint = 6;
	}
}