/**
 * Copyright 2014, Dylan Heyes
 */
package alchemical.subsystems.resources.mediator 
{
	import alchemical.core.enum.ComponentNames;
	import alchemical.debug.Debugger;
	import org.puremvc.as3.patterns.mediator.Mediator;
	import starling.utils.AssetManager;
	
	/**
	 * ResourcesMediator
	 * @author Dylan Heyes
	 */
	public class ResourcesMediator extends Mediator 
	{
		/**
		 * Constructor.
		 * @param	viewComponent	Starling asset manager.
		 */
		public function ResourcesMediator(viewComponent:AssetManager) 
		{
			super(ComponentNames.RESOURCES, viewComponent);
			if (CONFIG::debug) Debugger.data(this, "Created.");
		}
		
	}

}