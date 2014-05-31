/**
 * Copyright 2014, Dylan Heyes
 */
package alchemical.subsystems.graphics.controller 
{
	import alchemical.core.display.Fonts;
	import alchemical.debug.Debugger;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.AsyncCommand;
	import starling.text.BitmapFont;
	import starling.text.TextField;
	import starling.textures.Texture;
	
	/**
	 * CLoadFonts
	 * @author Dylan Heyes
	 */
	public class CLoadFonts extends AsyncCommand 
	{
		override public function execute(notification:INotification):void 
		{
			if (CONFIG::debug) Debugger.log(this, "Registering fonts...");
			
			registerFont("Monospace_12", Fonts.Consolas12_Texture, Fonts.Consolas12_Font);
			registerFont("Monospace_16", Fonts.Consolas16_Texture, Fonts.Consolas16_Font);
			
			if (CONFIG::debug) Debugger.log(this, "Registered fonts.");
			commandComplete();
		}
		
		private function registerFont(name:String, textureDefinition:Class, fontDefinition:Class):void
		{
			var font:XML = XML(new fontDefinition());
			var texture:Texture = Texture.fromBitmap(new textureDefinition());
			
			TextField.registerBitmapFont(new BitmapFont(texture, font), name);
			
			if (CONFIG::debug) Debugger.data(this, "Registered font: "+name);
		}
	}

}