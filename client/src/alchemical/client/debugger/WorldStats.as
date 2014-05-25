/**
 * Copyright 2014, Dylan Heyes
 */
package alchemical.client.debugger 
{
	import alchemical.client.subsystems.world.entities.Camera;
	import alchemical.client.subsystems.world.entities.Player;
	import alchemical.client.subsystems.world.World;
	import starling.display.Sprite;
	import starling.text.TextField;
	import starling.text.TextFieldAutoSize;
	import starling.utils.Color;
	import starling.utils.HAlign;
	import starling.utils.VAlign;
	
	/**
	 * WorldStats
	 * @author Dylan Heyes
	 */
	public class WorldStats extends Sprite 
	{
		private var _tfWorld:TextField;
		private var _tfCamera:TextField;
		private var _tfPlayer:TextField;
		
		/**
		 * Constructor.
		 */
		public function WorldStats() 
		{
			super();
			
			x = 1;
			y = 40;
			
			_tfWorld = createTextField();
			_tfCamera = createTextField(_tfWorld);
			_tfPlayer = createTextField(_tfCamera);
		}
		
		
		
		// API
		// =========================================================================================
		
		public function updateWorld(world:World):void
		{
			_tfWorld.text = label("world") + world.worldBounds.width + "x" + world.worldBounds.height;
		}
		
		public function updateCamera(camera:Camera):void
		{
			_tfCamera.text = label("camera") + camera.transform.x.toFixed(1) + "," + camera.transform.y.toFixed(1);
		}
		
		public function updatePlayer(player:Player):void
		{
			_tfPlayer.text = label("player") + player.transform.x.toFixed(1) + "," + player.transform.y.toFixed(1);
		}
		
		
		
		// INTERNAL
		// =========================================================================================
		
		private function createTextField(neighbor:TextField = null):TextField
		{
			var tf:TextField = new TextField(100, 12, "", "Consolas", 12, Color.WHITE, false);
			tf.vAlign = VAlign.TOP;
			tf.hAlign = HAlign.LEFT;
			tf.autoSize = TextFieldAutoSize.HORIZONTAL;
			tf.batchable = true;
			
			if (neighbor)
			{
				tf.y = neighbor.y + neighbor.height;
			}
			
			addChild(tf);
			
			return tf;
		}
		
		private function label(text:String):String
		{
			const width:int = 7;
			var output:String = "";
			
			output += text + ": ";
			
			for (var i:int = 0; i < width - text.length; i++)
			{
				output += " ";
			}
			
			return output;
		}
		
	}

}