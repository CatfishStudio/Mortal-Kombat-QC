package mkquest.assets.events 
{
	import starling.events.Event;
	
	public class Navigation extends Event 
	{
		public static const CHANGE_SCREEN:String = "changeScreen";
		
		public function Navigation(type:String, bubbles:Boolean=false, data:Object=null) 
		{
			super(type, bubbles, data);
		}
		
	}

}