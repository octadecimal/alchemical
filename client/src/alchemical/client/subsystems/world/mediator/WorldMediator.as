/**
 * Copyright 2014, Dylan Heyes
 */
package alchemical.client.subsystems.world.mediator 
{
	import alchemical.client.core.architecture.SubsystemMediator;
	import alchemical.client.core.enum.ComponentNames;
	import alchemical.client.debugger.Debugger;
	import alchemical.client.subsystems.world.World;
	
	/**
	 * WorldMediator
	 * @author Dylan Heyes
	 */
	public class WorldMediator extends SubsystemMediator 
	{
		/**
		 * Constructor.
		 * @param	viewComponent
		 */
		public function WorldMediator(viewComponent:World) 
		{
			super(ComponentNames.WORLD, viewComponent);
			Debugger.log(this, "Created.");
		}
		
	}

}