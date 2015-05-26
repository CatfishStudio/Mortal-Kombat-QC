package mkcards.assets.window.buyfighter 
{
	import starling.display.Image;
	import starling.text.BitmapFont;
	import starling.textures.Texture;
	import starling.display.Sprite;
	import starling.text.TextField;
	import starling.events.Event;
	import starling.display.Button;
	import starling.core.Starling;
	import starling.animation.Tween;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	
	import flash.display.Bitmap;
	import flash.ui.Mouse;
	import flash.ui.MouseCursor;
	import flash.events.MouseEvent;
	
	import mkcards.assets.events.Navigation;
	import mkcards.assets.statics.Constants;
	import mkcards.assets.statics.Resource;
	
	public class Fighter extends Sprite 
	{
		public var title:String;
		private var _textField:TextField;
		private var _button:Button;
		
		private var _textureFont:Texture = Texture.fromEmbeddedAsset(Resource.FontTexture);
		private	var _xmlFont:XML = XML(new Resource.FontXml());
		private var _bitmap:Bitmap;
		private var _image:Image;
		
		public function Fighter(_name:String) 
		{
			super();
			name = _name;
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		private function onAddedToStage(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			
			TextField.registerBitmapFont(new BitmapFont(_textureFont, _xmlFont), "Font01");
			
			addChild(new Image(Resource.textureAtlas.getTexture("window_select_fighter_background.png")));
			_image = new Image(Resource.textureAtlas.getTexture("window_select_fighter_" + this.name + ".png"));
			_image.x = 15; _image.y = 80;
			addChild(_image);
			addChild(new Image(Resource.textureAtlas.getTexture("window_select_fighter_border.png")));
			
			_textField = new TextField(200, 50, title, "Arial", 27, 0xffffff, false);
			_textField.fontName = "Font01";
			_textField.hAlign = "left";
			_textField.x = 40;
			_textField.y = 20;
			addChild(_textField);
		}
		
		
	}

}