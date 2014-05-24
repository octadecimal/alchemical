/**
 * Copyright 2014, Dylan Heyes
 */
package alchemical.client.subsystems.ui 
{
	import alchemical.client.subsystems.ui.model.ChatMessage;
	import flash.geom.Rectangle;
	import starling.display.Quad;
	import starling.display.Sprite;
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
		static private const LINE_HEIGHT:int = 10;
		
		
		/**
		 * Constructor.
		 */
		public function Chatbox() 
		{
			super();
			
			// Default size
			_size = new Rectangle(0, 0, 500, 200);
			
			// Create background
			_background = new Quad(_size.width, _size.height, 0x0);
			_background.alpha = 0.66;
			addChild(_background);
			
			// Create message buffer
			_messageBuffer = new Vector.<ChatMessage>();
			
			// Create output text
			_output = new TextField(_size.width - (PADDING * 2), _size.height - (PADDING * 2), "", "Consolas", 11, Color.WHITE, false);
			_output.hAlign = HAlign.LEFT;
			_output.vAlign = VAlign.TOP;
			_output.x = _output.y = PADDING;
			addChild(_output);
		}
		
		
		
		// API
		// =========================================================================================
		
		public function addMessage(chatMessage:ChatMessage):void 
		{
			_output.text += "\n" + chatMessage.msg;
		}
		
		
		
		// INTERNAL
		// =========================================================================================
		
		private function buildLineFields():void
		{
			
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
		
		private var _background:Quad;							// Background
		private var _messageBuffer:Vector.<ChatMessage>;		// Message buffer
		private var _output:TextField;							// Output textfield
		private var _lines:Vector.<TextField>
	}

}