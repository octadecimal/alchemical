/**
 * Copyright 2014, Dylan Heyes
 */
package alchemical.debug 
{
	import alchemical.debug.console.ConsoleCommand;
	import alchemical.debug.console.ConsoleCommandHelp;
	import flash.display.Sprite;
	import flash.events.FocusEvent;
	import flash.events.KeyboardEvent;
	import flash.text.TextField;
	import flash.text.TextFieldType;
	import flash.text.TextFormat;
	import flash.utils.Dictionary;
	
	/**
	 * DebugOverlay
	 * @author Dylan Heyes
	 */
	public class DebuggerOverlay extends Sprite 
	{
		static private const PADDING:Number = 5;
		static private const INPUT_HEIGHT:Number = 10;
		
		private var _buffer:TextField;
		private var _input:TextField;
		private var _showing:Boolean = false;
		private var _inputting:Boolean = false;
		private var _commands:Dictionary = new Dictionary();
		
		/**
		 * Constructor.
		 */
		public function DebuggerOverlay() 
		{
			super();
			build();
			
			_commands["help"] = new ConsoleCommandHelp("help");
		}
		
		
		
		// API
		// =========================================================================================
		
		public function show():void
		{
			_showing = true;
			visible = true;
			stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyUp);
			
			if (stage) stage.focus = _input;
		}
		
		public function hide():void
		{
			_showing = false;
			visible = false;
			
			if (stage) stage.focus = null;
		}
		
		public function resize(width:Number, height:Number):void
		{
			draw(width, height);
			
			_input.y = height - _input.height - PADDING;
			_input.width = width - PADDING * 2;
			
			_buffer.width = width - PADDING * 2;
			_buffer.height = height - PADDING * 2 - _input.height;
			
			if (stage) stage.focus = _input;
		}
		
		public function addLine(string:String, color:String = "#AAAAAA"):void 
		{
			//_buffer.appendText(string + "\n");
			_buffer.htmlText += "<font color='"+color+"'>" + string + "</font>";
			_buffer.scrollV = _buffer.maxScrollV;
		}
		
		
		
		// EVENTS
		// =========================================================================================
		
		private function onKeyUp(e:KeyboardEvent):void 
		{
			if (e.keyCode == 192)
			{
				_showing ? hide() : show();
			}
			
			if (e.keyCode == 13)
			{
				if (_inputting)
				{
					execute();
					disableInput();
				}
				else
				{
					enableInput();
				}
			}
		}
		
		
		
		// INTERNAL
		// =========================================================================================
		
		private function build():void
		{
			_buffer = new TextField();
			_buffer.defaultTextFormat = new TextFormat("Consolas", 11, 0xAAAAAA, true);
			_buffer.x = _buffer.y = PADDING;
			_buffer.multiline = true;
			addChild(_buffer);
			
			_input = new TextField();
			_input.defaultTextFormat = new TextFormat("Consolas", 11, 0xAAAAAA, true);
			//_input.autoSize = TextFieldAutoSize.LEFT;
			_input.height = 16;
			_input.backgroundColor = 0x222222;
			_input.type = TextFieldType.INPUT;
			_input.x = PADDING;
			addChild(_input);
			
			_input.addEventListener(FocusEvent.FOCUS_OUT, onInputUnfocused);
			
			resize(800, 200);
			
			disableInput();
		}
		
		private function onInputUnfocused(e:FocusEvent):void 
		{
			disableInput();
		}
		
		private function draw(width:Number, height:Number):void
		{
			graphics.clear();
			graphics.beginFill(0, 0.8);
			graphics.drawRect(0, 0, width, height);
			graphics.endFill();
		}
		
		private function enableInput():void
		{
			_inputting = true;
			_input.type = TextFieldType.INPUT;
			_input.background = true;
			stage.focus = _input;
		}
		
		private function disableInput():void
		{
			_inputting = false;
			_input.text = "";
			_input.type = TextFieldType.DYNAMIC;
			_input.background = false;
			if (stage) stage.focus = null;
		}
		
		private function execute():void
		{
			var args:Array = _input.text.split(" ");
			var command:String = args.shift();
			
			if (_commands[command])
			{
				ConsoleCommand(_commands[command]).execute(this, args);
			}
			else
			{
				addLine("Command not found: " + command);
			}
		}
	}

}