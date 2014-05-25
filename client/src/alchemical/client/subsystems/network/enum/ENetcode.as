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
		
		// End flag, would like to get rid of this (possible I believe)
		static public const END:uint = 1;
		
		// Login
		static public const LOGIN:uint = 2;
		//static public const LOGIN_OK:uint = 3;	// NOT USED
		
		// World definitions
		static public const DEFINE_WORLD:uint = 4;
		static public const DEFINE_PLAYER:uint = 5;
		static public const DEFINE_PLAYER_SHIP:uint = 6;
		static public const DEFINE_NPCS:uint = 7;
		
		// Movement
		static public const MOVE_NPC:uint = 8;
	}
}