/**
 * Copyright 2014, Dylan Heyes
 */
package alchemical.subsystems.input.enum 
{
	/**
	 * EActions
	 * @author Dylan Heyes
	 */
	public class EActions 
	{
		// NOTE: Start at 1 so that 0 can denote unset in InputProxy::_controlsTable
		
		static public const NUM_ACTIONS:uint = 9;
		
		static public const MOVE_UP:uint = 1;
		static public const MOVE_DOWN:uint = 2;
		static public const MOVE_LEFT:uint = 3;
		static public const MOVE_RIGHT:uint = 4;
		static public const ENTER_FULL_SCREEN:uint = 5;
		static public const EXIT_FULL_SCREEN:uint = 6;
		static public const CHAT:uint = 7;
		static public const CHAT_COMMAND:uint = 8;
	}

}