/**
 * Copyright 2014, Dylan Heyes
 */
package alchemical.client.subsystems.resources 
{
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
		}
	}

}