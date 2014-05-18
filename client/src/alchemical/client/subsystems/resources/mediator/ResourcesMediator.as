/**
 * Copyright 2014, Dylan Heyes
 */
package alchemical.client.subsystems.resources.mediator 
{
	import alchemical.client.core.architecture.SubsystemMediator;
	import alchemical.client.core.enum.ComponentNames;
	import alchemical.client.debugger.Debugger;
	import starling.utils.AssetManager;
	
	/**
	 * ResourcesMediator
	 * @author Dylan Heyes
	 */
	public class ResourcesMediator extends SubsystemMediator 
	{
		/**
		 * Constructor.
		 * @param	viewComponent	Starling asset manager.
		 */
		public function ResourcesMediator(viewComponent:AssetManager) 
		{
			super(ComponentNames.RESOURCES, viewComponent);
			Debugger.log(this, "Created.");
		}
		
	}

}