/**
 * Copyright 2014, Dylan Heyes
 */
package alchemical.subsystems.world.controller.update 
{
	import alchemical.core.enum.ComponentNames;
	import alchemical.subsystems.world.Entity;
	import alchemical.subsystems.world.World;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;
	
	/**
	 * CProjectEntities
	 * @author Dylan Heyes
	 */
	public class CProjectEntities extends SimpleCommand 
	{
		override public function execute(notification:INotification):void 
		{
			var entity:Entity;
			
			var world:World = facade.retrieveMediator(ComponentNames.WORLD).getViewComponent() as World;
			
			for (var i:int = 0, c:int = world.entities.length; i < c; i++)
			{
				if (world.entities[i] != null)
				{
					entity = world.entities[i];
					
					entity.view.x = entity.transform.x;
					entity.view.y = entity.transform.y;
					entity.view.rotation = entity.transform.rotation;
				}
			}
		}
	}

}