/**
 * alchemical.client.game
 */
package alchemical.client.game 
{
	import flash.display.Stage;
	import starling.display.Sprite;
	import starling.events.EnterFrameEvent;
	
	/**
	 * Game
	 * @author Dylan Heyes
	 */
	public class Game extends Sprite 
	{
		
		public function Game() 
		{
			super();
		}
		
		
		/**
		 * Flash stage.
		 */
		public function set flashStage(a:Stage):void	{ _flashStage = a; }
		public function get flashStage():Stage		{ return _flashStage; }
		private var _flashStage:Stage;
	}

}