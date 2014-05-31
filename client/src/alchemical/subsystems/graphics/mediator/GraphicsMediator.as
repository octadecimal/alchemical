/**
 * Copyright 2014, Dylan Heyes
 */
package alchemical.subsystems.graphics.mediator 
{
	import alchemical.core.enum.ComponentNames;
	import alchemical.debug.Debugger;
	import org.puremvc.as3.patterns.mediator.Mediator;
	import starling.core.Starling;
	
	/**
	 * GraphicsMediator
	 * @author Dylan Heyes
	 */
	public class GraphicsMediator extends Mediator 
	{
		/**
		 * Constructor.
		 * @param	viewComponent	Starling instance.
		 */
		public function GraphicsMediator(viewComponent:Starling) 
		{
			super(ComponentNames.GRAPHICS, viewComponent);
			if (CONFIG::debug) Debugger.data(this, "Created.");
		}
		
	}

}