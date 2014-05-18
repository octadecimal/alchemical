/**
 * Copyright 2014, Dylan Heyes
 */
package alchemical.client.core.architecture 
{
	import org.puremvc.as3.patterns.mediator.Mediator;
	
	/**
	 * SubsystemMediator
	 * @author Dylan Heyes
	 */
	public class SubsystemMediator extends Mediator 
	{
		
		public function SubsystemMediator(mediatorName:String=null, viewComponent:Object=null) 
		{
			super(mediatorName, viewComponent);
			
		}
		
	}

}