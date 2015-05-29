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

	import flash.system.*;
	import flash.display.Bitmap;
	import flash.ui.Mouse;
	import flash.ui.MouseCursor;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	
	import mkcards.assets.events.Navigation;
	import mkcards.assets.statics.Constants;
	import mkcards.assets.statics.Resource;
	
	public class Fighter extends Sprite 
	{
		public var title:String;
		public var text:String;
		public var textLeftCard:String;
		public var textRightCard:String;
		
		private var _textField:TextField;
		private var _button:Button;
		
		private var _textureFont:Texture = Texture.fromEmbeddedAsset(Resource.FontTexture);
		private	var _xmlFont:XML = XML(new Resource.FontXml());
		private var _bitmap:Bitmap;
		private var _image:Image;
		
		private var _cardsLeft:Sprite;
		private var _cardsRight:Sprite;
		
		public function Fighter(_name:String) 
		{
			super();
			name = _name;
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			addEventListener(Event.REMOVED_FROM_STAGE, onRemoveFromStage);
		}
		
		private function onAddedToStage(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			
			TextField.registerBitmapFont(new BitmapFont(_textureFont, _xmlFont), "Font01");
			
			_bitmap = new Resource.TextureWindowBackground();
			_image = new Image(Texture.fromBitmap(_bitmap));
			addChild(_image);
			
			_image = new Image(Resource.textureAtlas.getTexture("window_select_fighter_" + this.name + ".png"));
			_image.x = 15; _image.y = 80;
			addChild(_image);
			
			_bitmap = new Resource.TextureWindowBorder();
			_image = new Image(Texture.fromBitmap(_bitmap));
			addChild(_image);
			
			_textField = new TextField(200, 50, title, "Arial", 27, 0xffffff, false);
			_textField.fontName = "Font01";
			_textField.hAlign = "left";
			_textField.x = 40;
			_textField.y = 20;
			addChild(_textField);
			
			_textField = new TextField(200, 150, text, "Arial", 14, 0xffffff, false);
			_textField.hAlign = "left";
			_textField.x = 40;
			_textField.y = 5;
			addChild(_textField);
			
			_textField = new TextField(100, 50, textLeftCard, "Arial", 16, 0xffffff, false);
			_textField.hAlign = "left";
			_textField.x = 250;
			_textField.y = 25;
			addChild(_textField);
			
			_textField = new TextField(100, 50, textRightCard, "Arial", 16, 0xffffff, false);
			_textField.hAlign = "left";
			_textField.x = 350;
			_textField.y = 25;
			addChild(_textField);
			
			initCardsLeft();
			initCardsRight();
			setMask();
			
			_bitmap = null;
			_image.dispose();
			_image = null;
			_textField.dispose();
			_textField = null;
		}
		
		private function onRemoveFromStage(e:Event):void 
		{
			removeEventListener(Event.REMOVED_FROM_STAGE, onRemoveFromStage);
			
			_bitmap = null;
			if (_textureFont) _textureFont.dispose();
			_textureFont = null;
			if (_image) _image.dispose();
			_image = null;
			if (_textField) _textField.dispose();
			_textField = null;
			if (_button) _button.dispose();
			_button = null;
			
			while (this.numChildren)
			{
				this.removeChildren(0, -1, true);
			}
			this.removeFromParent(true);
			super.dispose();
			System.gc();
			trace("[X] onRemoveFromStage: " + this.name);
		}
		
		
		private function initCardsLeft():void
		{
			_cardsLeft = new Sprite();
			_cardsLeft.width = 105;
			_cardsLeft.height = 2000;
			
			for (var i:int = 0; i < 12; i++)
			{
				_image = new Image(Resource.textureAtlas.getTexture("card_front_1.png"));
				_image.x = 225; _image.y = 100 + (160 * i);
				_cardsLeft.addChild(_image);
			}
			addChild(_cardsLeft);
		}
		
		private function initCardsRight():void
		{
			_cardsRight = new Sprite();
			_cardsRight.width = 105;
			_cardsRight.height = 2000;
			
			for (var i:int = 0; i < 12; i++)
			{
				_image = new Image(Resource.textureAtlas.getTexture("card_front_1.png"));
				_image.x = 340; _image.y = 100 + (160 * i);
				_cardsRight.addChild(_image);
			}
			addChild(_cardsRight);
		}
		
		private function setMask():void
		{
			_cardsLeft.clipRect = new Rectangle(225, 100, 105, 155);
			_cardsRight.clipRect = new Rectangle(340, 100, 105, 155);
		}
	}

}