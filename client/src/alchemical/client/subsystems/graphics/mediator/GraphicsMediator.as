/**
 * Copyright 2014, Dylan Heyes
 */
package alchemical.client.subsystems.graphics.mediator 
{
	import alchemical.client.core.architecture.SubsystemMediator;
	import alchemical.client.core.enum.ComponentNames;
	import alchemical.client.debugger.Debugger;
	import org.puremvc.as3.patterns.mediator.Mediator;
	import starling.core.Starling;
	
	/**
	 * GraphicsMediator
	 * @author Dylan Heyes
	 */
	public class GraphicsMediator extends SubsystemMediator 
	{
		/**
		 * Constructor.
		 * @param	viewComponent	Starling instance.
		 */
		public function GraphicsMediator(viewComponent:Starling) 
		{
			super(ComponentNames.GRAPHICS, viewComponent);
			Debugger.log(this, "Created.");
		}
		
	}

}