/**
 * Copyright 2014, Dylan Heyes
 */
package alchemical.client.debugger.mediator 
{
	import alchemical.client.core.enum.ComponentNames;
	import alchemical.client.debugger.Debugger;
	import org.puremvc.as3.patterns.mediator.Mediator;
	
	/**
	 * DebuggerMediator
	 * @author Dylan Heyes
	 */
	public class DebuggerMediator extends Mediator 
	{
		/**
		 * Constructor.
		 * @param	viewComponent
		 */
		public function DebuggerMediator(viewComponent:Debugger) 
		{
			super(ComponentNames.DEBUGGER, viewComponent);
			
		}
		
	}

}