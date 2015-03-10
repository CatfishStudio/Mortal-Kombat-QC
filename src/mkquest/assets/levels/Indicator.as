package mkquest.assets.levels 
{
	import starling.display.Image;
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.text.TextField;
	
	import mkquest.assets.statics.Resource;
	import mkquest.assets.statics.Constants;
	
	public class Indicator extends Sprite 
	{
		private var _image:Image;
		private var _quad:Quad;
		private var _textField:TextField;
		
		private var _direction:String;
		private var _fighterName:String;
		
		
		public function Indicator(direction:String, fighterName:String) 
		{
			_direction = direction;
			_fighterName = fighterName;
			
			super();
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			addEventListener(Event.REMOVED_FROM_STAGE, onRemoveFromStage);
		}
		
		private function onAddedToStage(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			
			if (_direction == Constants.LEFT_TO_RIGHT) x = 20;
			if (_direction == Constants.RIGHT_TO_LEFT) x = 570;
			y = 30;
			
			_image = new Image(Resource.textureAtlas.getTexture("lifebar.png"));
			addChild(_image);
			
			_quad = new Quad(200, 10,  0x0000FF, true);
			_quad.x = 3;
			_quad.y = 2;
			addChild(_quad);
			
			_textField = new TextField(200, 30, _fighterName, "Arial", 14, 0xFFFFFF, false);
			_textField.y = -25;
			addChild(_textField);
			
		}
		
		private function onRemoveFromStage(e:Event):void 
		{
			removeEventListener(Event.REMOVED_FROM_STAGE, onRemoveFromStage);
			
			if (_image != null) _image.dispose();
			_image = null;
			if (_quad != null) _quad.dispose();
			_quad = null;
			_textField = null;
			
			while (this.numChildren)
			{
				this.removeChildren(0, -1, true);
			}
			this.removeFromParent(true);
			
			super.dispose();
			trace("[X] Удалена индикатора жизни");
		}
		
		public function get LifeBar():int
        {
			return _quad.width;
		}

		public function set LifeBar(value:int):void
		{
			_quad.width = value;
		}


		
		
	}

}