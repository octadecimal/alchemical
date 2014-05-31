/**
 * Copyright 2014, Dylan Heyes
 */
package alchemical.subsystems.input.model 
{
	import alchemical.core.enum.ComponentNames;
	import alchemical.debug.Debugger;
	import flash.utils.Dictionary;
	import org.puremvc.as3.patterns.proxy.Proxy;
	
	/**
	 * InputProxy
	 * @author Dylan Heyes
	 */
	public class InputProxy extends Proxy 
	{
		/**
		 * Constructor.
		 * @param	data
		 */
		public function InputProxy(data:Object=null) 
		{
			super(ComponentNames.INPUT, data);			
			
			_asciiTable = new Dictionary();
			_actionsTable = new Dictionary();
			_controlsTable = new Vector.<uint>(1024);
			_keyDownStates = new Vector.<Boolean>(1024);
			
			if (CONFIG::debug) Debugger.data(this, "Created.");
		}
		
		
		
		// DATA
		// =========================================================================================
		
		public function setControlsData(xml:XML):void
		{
			_controlsData = xml;
		}
		
		public function getControlsData():XML
		{
			return _controlsData;
		}
		
		
		
		// REGISTRATION
		// =========================================================================================
		
		/**
		 * Registers a control, binding a primary and secondary key to an abstract game action.
		 * @param	actionName	Name of action to be bound.
		 * @param	primary		Name of primary key to bind to action.
		 * @param	secondary	Name of secondary key to bind to action.
		 */
		public function registerControlBinding(actionName:String, primary:String, secondary:String):void 
		{
			var actionCode:uint = getActionCodeByName(actionName);
			
			_controlsTable[getAsciiCode(primary)] = actionCode;
			_controlsTable[getAsciiCode(secondary)] = actionCode;
			
			if (CONFIG::debug) Debugger.data(this, "Control registered: " + actionName + " (" + actionCode+") -> " + primary + " (" + getAsciiCode(primary) + ") " + secondary + " (" + getAsciiCode(secondary) + ")");
		}
		
		/**
		 * Registers an action.
		 * @param	name	Action name (ex "move_left")
		 * @param	code	Action code, as defined in EActions enumerations.
		 */
		public function registerAction(name:String, code:uint):void
		{
			if (CONFIG::debug) Debugger.data(this, "Action registered: " + name+" -> " + code);
			
			_actionsTable[name] = code;
		}
		
		/**
		 * Registers an ascii code with a name, allowing the player to use human-friendly
		 * key names rather than ascii key codes.
		 * @param	ascii	Ascii key code
		 * @param	key		Human-readable key name (ex "spacebar")
		 */
		public function registerAsciiCode(ascii:uint, key:String):void 
		{
			if (CONFIG::debug) Debugger.data(this, "Ascii code registered: " + key + " -> " + ascii);
			
			_asciiTable[key] = ascii;
		}
		
		
		
		// GETTERS
		// =========================================================================================
		
		/**
		 * Retrieves an action code by action name.
		 * @param	action	Action name (ex "move_left")
		 * @return	Action code for input action id.
		 */
		public function getActionCodeByName(actionName:String):uint 
		{
			return _actionsTable[actionName];
		}
		
		/**
		 * Retrieves the action code for the specified input ascii code.
		 * @param	ascii	Input ascii code.
		 * @return
		 */
		public function getActionCodeByAscii(ascii:uint):uint
		{
			return _controlsTable[ascii];
		}
		
		/**
		 * Retrieves  an ascii code for a key that was registered via `registerAsciiCode`.
		 * @param	key		Human readable key name (ex "spacebar" "w")
		 * @return
		 */
		public function getAsciiCode(key:String):uint
		{
			return _asciiTable[key];
		}
		
		
		
		// KEY STATES
		// =========================================================================================
		
		/**
		 * Sets a key as down by ascii code.
		 * @param	ascii
		 */
		public function setKeyAsDown(ascii:uint):void
		{
			_keyDownStates[ascii] = true;
		}
		
		/**
		 * Sets a key as up by ascii code.
		 * @param	ascii
		 */
		public function setKeyAsUp(ascii:uint):void
		{
			_keyDownStates[ascii] = false;
		}
		
		/**
		 * Returns the down state of a key by ascii code.
		 * @param	ascii
		 * @return	True if key is down, false if up.
		 */
		public function isKeyDown(ascii:uint):Boolean
		{
			return _keyDownStates[ascii];
		}
		
		
		
		// ACCESSORS
		// =========================================================================================
		
		/**
		 * The input received, as per ComponentNames enum.
		 */
		public function set focus(a:String):void	{ _focus = a; }
		public function get focus():String			{ return _focus; }
		private var _focus:String;
		
		
		
		// PRIVATE
		// =========================================================================================
		
		// Control bindings xml
		private var _controlsData:XML;
		
		// Holds a table of ascii codes, where the key is the name (ex "UP") and the value is the ascii code.
		private var _asciiTable:Dictionary;
		
		// Holds a table of mapped controls, where the key is the ascii code, and the value is the action.
		// This object is key for allowing for very fast key->action lookups.
		private var _controlsTable:Vector.<uint>;
		
		// Holds a table of action codes, where the key is the action name (ex "move_left") and the value is
		// the numeric action code.
		private var _actionsTable:Dictionary;
		
		// Holds a table of key down states, where the key is the numeric action code and the value is
		// the boolean key down state. Right now storing by ascii code rather than action code, as I'm not
		// sure which would be better right now.
		private var _keyDownStates:Vector.<Boolean>;
	}
}