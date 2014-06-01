/**
 * Copyright 2014, Dylan Heyes
 */
package alchemical.subsystems.resources 
{
	import alchemical.debug.Debugger;
	import flash.filesystem.File;
	import starling.utils.AssetManager;
	
	/**
	 * Resources
	 * @author Dylan Heyes
	 */
	public class Resources extends AssetManager 
	{
		/**
		 * Constructor.
		 * @param	scaleFactor
		 * @param	useMipmaps
		 */
		public function Resources(scaleFactor:Number=1, useMipmaps:Boolean=false) 
		{
			super(scaleFactor, useMipmaps);
			if (CONFIG::debug) Debugger.data(this, "Created.");
		}
		
		
		
		// API
		// =========================================================================================
		
		override public function enqueue(...rawAssets):void 
		{
			var file:File = rawAssets.concat()[0] as File;
			if (CONFIG::debug) Debugger.enqueue(this, "Enqueuing: " + file.nativePath);
			super.enqueue(file);
		}
	}

}