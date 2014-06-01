/**
 * Copyright 2014, Dylan Heyes
 */
package alchemical.client.core.util 
{
	/**
	 * FileSizes
	 * @author Dylan Heyes
	 */
	public class FileSizes 
	{
		static public function toKB(bytes:Number):String
		{
			return Number(bytes / 1000).toFixed(2) + "kb";
		}
		
		static public function toMB(bytes:Number):String
		{
			return Number(bytes / 1000000).toFixed(2) + "mb";
		}
	}

}