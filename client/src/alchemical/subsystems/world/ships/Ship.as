/**
 * Copyright 2014, Dylan Heyes
 */
package alchemical.subsystems.world.ships 
{
	import alchemical.subsystems.world.Entity;
	import alchemical.subsystems.world.model.nodes.DynamicsNode;
	import alchemical.subsystems.world.model.nodes.TransformNode;
	import starling.core.Starling;
	import starling.display.DisplayObject;
	import starling.display.Image;
	import starling.display.MovieClip;
	import starling.display.Sprite;
	import starling.textures.Texture;
	
	/**
	 * Ship
	 * @author Dylan Heyes
	 */
	public class Ship extends Entity 
	{
		private var _hullImage:Image;
		private var _engineImages:Vector.<MovieClip>;
		
		/**
		 * Constructor.
		 * @param	view
		 * @param	transform
		 * @param	dynamics
		 */
		public function Ship(view:DisplayObject=null, transform:TransformNode=null, dynamics:DynamicsNode=null, numEnginebays:int = 0) 
		{
			super(view, transform, dynamics);
			
			_engines = new Vector.<int>(numEnginebays);
			_engineImages = new Vector.<MovieClip>(numEnginebays);
		}
		
		/**
		 * Dispose routine.
		 */
		override public function dispose():void 
		{
			_hullImage.dispose();
			_hullImage = null;
			
			for (var i:int = 0, c:int = _engines.length; i < c; i++)
			{
				_engineImages[i].dispose();
				_engineImages[i] = null;
			}
			
			_engineImages = null
			
			super.dispose();
		}
		
		
		
		// API
		// =========================================================================================
		
		public function setHull(type:int, texture:Texture):void
		{
			_hull = type;
			_hullImage = new Image(texture);
			
			_hullImage.pivotX = _hullImage.width / 2;
			
			Sprite(view).addChild(_hullImage);
		}
		
		public function setEngineAt(type:int, index:int, textures:Vector.<Texture>, x:int, y:int):void
		{
			_engines[index] = type;
			
			var mc:MovieClip = new MovieClip(textures, 12);
			_engineImages[index] = mc;
			
			mc.pivotX = mc.width / 2;
			mc.x = x;
			mc.y = y;
			
			Sprite(view).addChildAt(mc, 0);
			
			//temp
			mc.rotation = Math.PI;
			mc.currentFrame = int(Math.random() * 20);
			mc.y += 37;
			mc.x += 0.5;
			mc.scaleY = 0.75;
			mc.fps = Math.random() * 12 + 12;
			//temp
			
			mc.play();
			Starling.juggler.add(mc);
		}
		
		
		
		// ACCESSORS
		// =========================================================================================
		
		/**
		 * Hull type.
		 */
		public function get hull():int					{ return _hull; }
		private var _hull:int;
		
		/**
		 * Engine types.
		 */
		public function get engines():Vector.<int>		{ return _engines; }
		private var _engines:Vector.<int>;
		
	}

}