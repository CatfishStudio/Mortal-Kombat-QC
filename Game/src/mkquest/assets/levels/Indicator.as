package mkquest.assets.levels 
{
	import flash.system.*;
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
			_fighterName = getfFighterName(fighterName);
			
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
			_quad.y = 3;
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
			System.gc();
			super.dispose();
			
			trace("[X] Удалена индикатора жизни");
		}
		
		public function get LifeBar():int
        {
			return _quad.width;
		}

		public function set LifeBar(value:int):void
		{
			if (_direction == Constants.LEFT_TO_RIGHT)
			{
				if (value <= 0) _quad.width = 0;
				else _quad.width = value;
			}
			if (_direction == Constants.RIGHT_TO_LEFT)
			{
				if (value <= 0)
				{
					_quad.width = 0;
				}
				else
				{
					var shift:int = _quad.width - value;
					_quad.width = value;
					_quad.x += shift;
				}
			}
		}

		private function getfFighterName(name:String):String
		{
			if (name == "baraka") return "Baraka";
			if (name == "goro") return "Goro";
			if (name == "jax") return "Jax";
			if (name == "johnnycage") return "Johnny Cage";
			if (name == "kitana") return "Kitana";
			if (name == "kunglao") return "Kung Lao";
			if (name == "liukang") return "Liu Kang";
			if (name == "mileena") return "Mileena";
			if (name == "raiden") return "Raiden";
			if (name == "reptile") return "Reptile";
			if (name == "scorpion") return "Scorpion";
			if (name == "shangtsung") return "Shang Tsung";
			if (name == "shaokahn") return "Shao Kahn";
			if (name == "subzero") return "Sub-zero";
			return "";
		}
		
		
	}

}