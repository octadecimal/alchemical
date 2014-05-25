/**
 * Copyright 2014, Dylan Heyes
 */
package alchemical.client.subsystems.ui 
{
	import alchemical.client.subsystems.ui.enum.EChatMessageTypes;
	import alchemical.client.subsystems.ui.events.UIEvent;
	import alchemical.client.subsystems.ui.model.ChatMessage;
	import flash.geom.Rectangle;
	import flash.ui.Keyboard;
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.events.KeyboardEvent;
	import starling.text.TextField;
	import starling.utils.Color;
	import starling.utils.HAlign;
	import starling.utils.VAlign;
	
	/**
	 * Chatbox
	 * @author Dylan Heyes
	 */
	public class Chatbox extends Sprite 
	{
		static private const PADDING:int = 5;
		static private const LINE_HEIGHT:int = 15;
		
		/**
		 * Constructor.
		 */
		public function Chatbox() 
		{
			super();
			
			// Default size
			_size = new Rectangle(0, 0, 500, 193);
			
			// Create background
			_background = new Quad(_size.width, _size.height, 0x0);
			_background.alpha = 0.2;
			addChild(_background);
			
			// Create command background
			_backgroundInput = new Quad(_size.width, 20, 0x222222);
			_backgroundInput.y = _size.height - 20;
			_backgroundInput.alpha = 0.5;
			addChild(_backgroundInput);
			
			// Create message buffer
			_messageBuffer = new Vector.<ChatMessage>();
			
			// Create input text
			_input = new TextField(_size.width - (PADDING * 2), LINE_HEIGHT, "", "Consolas", 12, Color.WHITE, false);
			_input.hAlign = HAlign.LEFT;
			_input.vAlign = VAlign.TOP;
			_input.x = _input.y = PADDING;
			_input.y = _size.height - _input.height - PADDING;
			addChild(_input);
			_input.batchable = true;
			
			// Create line fields
			buildLineFields();
			
			// Default unfocused
			unfocus();
			
			// Refresh
			refresh();
		}
		
		
		
		// API
		// =========================================================================================
		
		public function addMessage(chatMessage:ChatMessage):void 
		{
			_messageBuffer.push(chatMessage);
			
			if (_messageBuffer.length > _lineFields.length)
			{
				_scrollV++;
			}
			
			refresh();
		}
		
		public function refresh():void
		{
			for (var i:int = 0; i < _lineFields.length; i++)
			{
				if (_messageBuffer.length > i+_scrollV)
				{
					var msg:ChatMessage = _messageBuffer[i + _scrollV];
					
					if (msg.type == 0)
					{
						_lineFields[i].color = Color.YELLOW;
						_lineFields[i].text = "[" + msg.type+"] " + msg.msg;
					}
					else
					{
						_lineFields[i].color = Color.WHITE;
						_lineFields[i].text = "[" + msg.type+"] <" + msg.sender + "> " + msg.msg;
					}
				}
			}
		}
		
		public function toggleFocus():void 
		{
			(_focused) ? unfocus() : focus();
			_focused = !_focused;
		}
		
		
		
		// INTERNAL
		// =========================================================================================
		
		private function focus():void
		{
			_background.alpha = 0.4;
			enableCommandLine();
			
			dispatchEvent(new UIEvent(UIEvent.CHATBOX_FOCUSED));
		}
		
		private function unfocus():void
		{
			_background.alpha = 0.0;
			disableCommandLine();
			
			dispatchEvent(new UIEvent(UIEvent.CHATBOX_UNFOCUSED));
		}
		
		private function enableCommandLine():void 
		{
			_backgroundInput.visible = true;
			_input.visible = true;
			
			stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
		}
		
		private function disableCommandLine():void 
		{
			_backgroundInput.visible = false;
			_input.visible = false;
			
			if (_input.text.length > 2)
			{
				var chatMessage:ChatMessage = new ChatMessage(1, _input.text, "You");
				//addMessage(chatMessage);
				dispatchEvent(new UIEvent(UIEvent.CHATBOX_MESSAGE_ENTERED, chatMessage));
			}
			
			_input.text = "";
			
			if (stage)
			{
				stage.removeEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
			}
		}
		
		private function buildLineFields():void
		{
			var numFields:int = ((_size.height-(PADDING*2)) / LINE_HEIGHT) - 1;
			
			_lineFields = new Vector.<TextField>(numFields);
			
			for (var i:int = 0; i < numFields; i++)
			{
				var tf:TextField = createLineField();
				tf.y = i * LINE_HEIGHT + PADDING;
				_lineFields[i] = tf;
			}
		}
		
		private function createLineField():TextField
		{
			var tf:TextField = new TextField(_size.width - (PADDING * 2), _size.height - (PADDING * 2), "" , "Consolas", 12, Color.WHITE, false);
			tf.hAlign = HAlign.LEFT;
			tf.vAlign = VAlign.TOP;
			tf.x = tf.y = PADDING;
			addChild(tf);
			tf.batchable = true;
			return tf;
		}
		
		
		
		// EVENT HANDLERS
		
		// =========================================================================================
		
		private function onKeyDown(e:KeyboardEvent):void 
		{
			if (e.keyCode == Keyboard.BACKSPACE)
			{
				_input.text = _input.text.slice(0, _input.text.length - 1);
			}
			else if (e.keyCode != Keyboard.SHIFT)
			{
				_input.text += String.fromCharCode(e.charCode);
			}
		}
		
		
		
		// ACCESSORS
		// =========================================================================================
		
		/**
		 * Chat size.
		 */
		public function get size():Rectangle		{ return _size; }
		private var _size:Rectangle;
		
		
		
		// PRIVATE
		// =========================================================================================
		
		private var _background:Quad;
		private var _backgroundInput:Quad;
		private var _messageBuffer:Vector.<ChatMessage>;
		private var _output:TextField;
		private var _input:TextField;
		private var _focused:Boolean;
		private var _lineFields:Vector.<TextField>;
		private var _scrollV:int = 0;
	}

}