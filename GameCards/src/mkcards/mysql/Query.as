package mkcards.mysql 
{
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.events.Event;
	
	//import catfishqa.windows.MessageBox;
	
	/**
	 * ...
	 * @author Catfish Studio Games
	 */
	
	public class Query extends URLLoader 
	{
		private var result:*;
		
		public function Query() 
		{
			super();
			
		}
		
		public function performRequest(filePHP:String):void
		{
			try
			{
				var request:URLRequest = new URLRequest(filePHP);
				addEventListener(Event.COMPLETE, onComplete);
				load(request);
			}
			catch (error:Error)
			{
				//new MessageBox(error.message, "Сообщение");
			}
		}


		private function onComplete(e:Event):void
		{
			try
			{
				result = data;
			}
			catch (error:Error)
			{
				//new MessageBox(error.message, "Сообщение");
			}
		}
		
		public function get getResult():*
		{
			return result;
		}


	}

}