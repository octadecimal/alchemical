/**
 * Copyright 2014, Dylan Heyes
 */
package alchemical.subsystems.ui.mediator 
{
	import alchemical.core.enum.ComponentNames;
	import alchemical.debug.Debugger;
	import alchemical.subsystems.ui.UILayer;
	import org.puremvc.as3.patterns.mediator.Mediator;
	
	/**
	 * UIMediator
	 * @author Dylan Heyes
	 */
	public class UIMediator extends Mediator 
	{
		/**
		 * Constructor.
		 * @param	uiLayer
		 */
		public function UIMediator(viewComponent:UILayer) 
		{
			super(ComponentNames.UI, viewComponent);
			if (CONFIG::debug) Debugger.data(this, "Created.");
		}
		
	}

}