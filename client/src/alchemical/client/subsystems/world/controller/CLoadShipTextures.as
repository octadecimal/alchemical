/**
 * Copyright 2014, Dylan Heyes
 */
package alchemical.client.subsystems.world.controller 
{
	import alchemical.client.core.enum.ComponentNames;
	import alchemical.client.debugger.Debugger;
	import flash.filesystem.File;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.AsyncCommand;
	import starling.utils.AssetManager;
	
	/**
	 * CLoadShips
	 * @author Dylan Heyes
	 */
	public class CLoadShipTextures extends AsyncCommand 
	{
		private static const PATH_PREFIX:String = "textures/ships/";
		private static const FILE_PREFIX:String = "ships_";
		
		override public function execute(notification:INotification):void 
		{
			Debugger.log(this, "Ship textures loading...");
			
			var resources:AssetManager = facade.retrieveMediator(ComponentNames.RESOURCES).getViewComponent() as AssetManager;
			
			// TODO: Later implement effecient ship loading rather than all at once, probably cache into separate runtime sheet
			resources.enqueue(PATH_PREFIX + FILE_PREFIX + "01.png");
			resources.enqueue(PATH_PREFIX + FILE_PREFIX + "01.xml");
			
			resources.loadQueue(function (ratio:Number):void
			{
				if (ratio >= 1)
				{
					Debugger.log(this, "Ship textures loaded.");
					commandComplete();
				}
			});
		}
	}

}