/**
 * Copyright 2014, Dylan Heyes
 */
package alchemical.subsystems.world.mediator 
{
	import alchemical.core.enum.ComponentNames;
	import alchemical.debug.Debugger;
	import alchemical.subsystems.world.World;
	import org.puremvc.as3.patterns.mediator.Mediator;
	
	/**
	 * WorldMediator
	 * @author Dylan Heyes
	 */
	public class WorldMediator extends Mediator 
	{
		private var _view:World;
		
		/**
		 * Constructor.
		 * @param	viewComponent
		 */
		public function WorldMediator(viewComponent:World) 
		{
			_view = viewComponent;
			super(ComponentNames.WORLD, viewComponent);
			if (CONFIG::debug) Debugger.data(this, "Created.");
		}
		
	}

}