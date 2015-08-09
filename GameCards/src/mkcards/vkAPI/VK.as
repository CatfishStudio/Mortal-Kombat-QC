package mkcards.vkAPI 
{
	import vk.APIConnection;
	
	
	public class VK 
	{
		/* VK API */
		public static var vkConnection:APIConnection;
		
		public static function getUserID():Array
		{
			var data:Array = [];
			data.push("0000001");
			data.push("Test");
			data.push("VK");
			data.push("");
			data.push(0);
			data.push(0);
			data.push(1000);
			data.push(-1);
			
			return data;
		}
	}

}