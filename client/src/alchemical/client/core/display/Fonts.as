/**
 * Copyright 2014, Dylan Heyes
 */
package alchemical.client.core.display 
{
	/**
	 * Fonts
	 * @author Dylan Heyes
	 */
	public class Fonts 
	{
		// Consolas 11
		//[Embed(source="../../../../../bin/fonts/consolas_11.fnt", mimeType="application/octet-stream")]
		//public static const Consolas11_Font:Class;
		//[Embed(source = "../../../../../bin/fonts/consolas_11.png")]
		//public static const Consolas11_Texture:Class;
		
		// Consolas 12
		[Embed(source="../../../../../bin/fonts/consolas_12.fnt", mimeType="application/octet-stream")]
		public static const Consolas12_Font:Class;
		[Embed(source = "../../../../../bin/fonts/consolas_12.png")]
		public static const Consolas12_Texture:Class;
		
		// Consolas 16
		//[Embed(source="../../../../../bin/fonts/consolas_16.fnt", mimeType="application/octet-stream")]
		//public static const Consolas16_Font:Class;
		//[Embed(source = "../../../../../bin/fonts/consolas_16.png")]
		//public static const Consolas16_Texture:Class;
		
		// Eras 72
		//[Embed(source="../../../../../bin/fonts/eras_72.fnt", mimeType="application/octet-stream")]
		//public static const Eras72_Font:Class;
		//[Embed(source = "../../../../../bin/fonts/eras_72.png")]
		//public static const Eras72_Texture:Class;
		
		
		public static function registerFont(font:Class, texture:Class):void
		{
			registeredFonts.push( { font: font, texture: texture } );
		}
		
		public static var registeredFonts:Vector.<Object> = new Vector.<Object>();
	}

}