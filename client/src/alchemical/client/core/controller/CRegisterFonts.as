/**
 * Copyright 2014, Dylan Heyes
 */
package alchemical.client.core.controller 
{
	import alchemical.client.core.display.Fonts;
	import alchemical.client.platforms.DesktopPlatform;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.AsyncCommand;
	import starling.text.BitmapFont;
	import starling.text.TextField;
	import starling.textures.Texture;
	
	/**
	 * CRegisterFonts
	 * @author Dylan Heyes
	 */
	public class CRegisterFonts extends AsyncCommand 
	{
		override public function execute(notification:INotification):void 
		{
			var font:XML;
			var texture:Texture;
			
			var fontDefinition:Class;
			var textureDefinition:Class;
			
			for (var i:int = 0; i < Fonts.registeredFonts.length; i++)
			{
				fontDefinition = Fonts.registeredFonts[i].font as Class;
				font = XML(new fontDefinition());
				
				textureDefinition = Fonts.registeredFonts[i].texture as Class;
				texture = Texture.fromBitmap(new textureDefinition());
				
				TextField.registerBitmapFont(new BitmapFont(texture, font));
			}
			
			commandComplete();
		}
	}

}