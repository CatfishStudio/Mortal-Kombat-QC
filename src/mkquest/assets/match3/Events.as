package mkquest.assets.match3 
{
	import starling.events.Event;
	
	public class Events extends Event 
	{
		public static const MATCH_3_EVENTS:String = "match3Events";
		
		public function Events(type:String, bubbles:Boolean=false, data:Object=null) 
		{
			super(type, bubbles, data);
		}
		
	}

}