/**
 * Copyright 2014, Dylan Heyes
 */
package alchemical.subsystems.world 
{
	import alchemical.debug.Debugger;
	import starling.display.Sprite;
	import starling.textures.Texture;
	
	/**
	 * Sky
	 * @author Dylan Heyes
	 */
	public class Sky extends Sprite 
	{
		/**
		 * Constructor.
		 */
		public function Sky() 
		{
			super();
			
			if (CONFIG::debug) Debugger.data(this, "Created.");
		}
		
		
		
		// API
		// =========================================================================================
		
		public function disposeLayers():void 
		{
			
		}
		
		public function setLayerTextures(textures:Vector.<Texture>):void
		{
			resizeLayerArray(textures);
			
			for (var i:int = 0; i < textures.length; i++)
			{
				_layers[i].texture = textures[i];
				addChild(_layers[i]);
			}
		}
		
		
		
		// INTERNAL
		// =========================================================================================
		
		private function resizeLayerArray(textures:Vector.<Texture>):void 
		{
			var i:int;
			
			// Create initial
			if (_layers == null)
			{
				_layers = new Vector.<SkyLayer>(textures.length);
				
				for (i = 0; i < _layers.length; i++)
				{
					_layers[i] = new SkyLayer(textures[i]);
				}
			}
			else
			{
				// Copy old and create new
				var copy:Vector.<SkyLayer> = _layers.concat();
				_layers = new Vector.<SkyLayer>(textures.length);
				
				// Copy old convents into new
				for (i = 0; i < Math.min(_layers.length, copy.length); i++)
				{
					if (CONFIG::debug) Debugger.data(this, "Copying: "+i);
					_layers[i] = copy[i];
				}
				
				// Dispose any newly unused
				for (i = textures.length; i < copy.length; i++)
				{
					if (CONFIG::debug) Debugger.data(this, "Disposing: " + i);
					removeChild(copy[i]);
					copy[i].dispose();
				}
				
				// Fill new skylayers
				for (i = copy.length; i < textures.length; i++)
				{
					if (CONFIG::debug) Debugger.data(this, "Filling: " + i);
					_layers[i] = new SkyLayer(textures[i]);
				}
			}
		}
		
		
		
		// ACCESSORS
		// =========================================================================================
		
		/**
		 * Sky layers.
		 */
		public function get layers():Vector.<SkyLayer>		{ return _layers; }
		private var _layers:Vector.<SkyLayer>;
	}

}