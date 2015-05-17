package mkquest.assets.levels 
{
	public class Levels 
	{
		private var _levelFileXML:XML;
		private var _backgroundFileTexture:String;
		
		public function Levels() 
		{
			super();
		}
		
		public function get levelFileXML():XML
		{
			return _levelFileXML;
		}

		public function set levelFileXML(value:XML):void
		{
			_levelFileXML = value;
		}
		
		public function get backgroundFileTexture():String
		{
			return _backgroundFileTexture;
		}

		public function set backgroundFileTexture(value:String):void
		{
			_backgroundFileTexture = value;
		}
		
	}

}