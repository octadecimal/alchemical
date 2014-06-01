/**
 * Copyright 2014, Dylan Heyes
 */
package alchemical.core.display 
{
	/**
	 * Fonts
	 * @author Dylan Heyes
	 */
	public class Fonts 
	{
		// Consolas 12
		[Embed(source="../../../../bin/fonts/consolas_12.fnt", mimeType = "application/octet-stream")]
		public static const Consolas12_Font:Class;
		[Embed(source="../../../../bin/fonts/consolas_12.png")]
		public static const Consolas12_Texture:Class;
		
		// Consolas 16
		[Embed(source="../../../../bin/fonts/consolas_16.fnt", mimeType="application/octet-stream")]
		public static const Consolas16_Font:Class;
		[Embed(source="../../../../bin/fonts/consolas_16.png")]
		public static const Consolas16_Texture:Class;
	}

}