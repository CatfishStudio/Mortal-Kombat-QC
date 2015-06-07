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
		public var price:int;
		
		private var _textField:TextField;
		private var _button:Button;
		
		private var _textureFont:Texture = Texture.fromEmbeddedAsset(Resource.FontTexture);
		private	var _xmlFont:XML = XML(new Resource.FontXml());
		private var _bitmap:Bitmap;
		private var _image:Image;
		
		private var _cards:Sprite;
		private var _cardsLeft:Sprite;
		private var _cardsRight:Sprite;
		private var _cardsAttack:Array = [];
		private var _cardsDefence:Array = [];
		
		private var _tween:Tween;		// анимация
		private var _yStart:int;		// начальное значение по Y
		private var _move:Boolean = true; // флаг движения
		
		
		public function Fighter(_name:String, cardsAttack:Array, cardsDefence:Array) 
		{
			super();
			name = _name;
			_cardsAttack = cardsAttack;
			_cardsDefence = cardsDefence;
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			addEventListener(Event.REMOVED_FROM_STAGE, onRemoveFromStage);
			addEventListener(Event.TRIGGERED, onButtonsClick);
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
			_textField.y = 15;
			addChild(_textField);
			
			_textField = new TextField(100, 50, textLeftCard, "Arial", 16, 0xffffff, false);
			_textField.hAlign = "left";
			_textField.x = 245;
			_textField.y = 45;
			addChild(_textField);
			
			_textField = new TextField(100, 50, textRightCard, "Arial", 16, 0xffffff, false);
			_textField.hAlign = "left";
			_textField.x = 370;
			_textField.y = 45;
			addChild(_textField);
			
			_cards = new Sprite();
			initCardsLeft();
			initCardsRight();
			setMask();
			addChild(_cards);
			
			navigationButtons();
			
			_bitmap = null;
			if (_image) _image.dispose();
			_image = null;
			if (_textField) _textField.dispose();
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
			
			Starling.juggler.remove(_tween);
			
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
			
			var n:int = _cardsAttack.length;
			for (var i:int = 0; i < n; i++)
			{
				_image = new Image(Resource.textureAtlas.getTexture("card_front_" + _cardsAttack[i][6] + ".png"));
				_image.x = 225; 
				_image.y = 100 + (160 * i);
				_cardsLeft.addChild(_image);
				
				_image = new Image(Resource.textureAtlas.getTexture(_cardsAttack[i][4]));
				_image.x = 215 + (105 / 2) - (_image.width / 3);
				_image.y = (100 + (160 * i)) + (155 / 2) - (_image.height / 3);
				_image.scaleX -= 0.2;
				_image.scaleY -= 0.2;
				_cardsLeft.addChild(_image);
				
				_textField = new TextField(100, 50, "x" + _cardsAttack[i][1], "Arial Black", 20, 0xffffff, false);
				_textField.hAlign = "left";
				_textField.x = 235;
				_textField.y = 95 + (160 * i);
				_cardsLeft.addChild(_textField);
				
				_textField = new TextField(120, 60, _cardsAttack[i][2], "Arial Black", 48, 0xffffff, false);
				_textField.hAlign = "right";
				_textField.x = 200;
				_textField.y = 190 + (160 * i);
				_cardsLeft.addChild(_textField);
			}
			_cards.addChild(_cardsLeft);
		}
		
		private function initCardsRight():void
		{
			_cardsRight = new Sprite();
			_cardsRight.width = 105;
			_cardsRight.height = 2000;
			
			var n:int = _cardsDefence.length;
			for (var i:int = 0; i < n; i++)
			{
				_image = new Image(Resource.textureAtlas.getTexture("card_front_" + _cardsDefence[i][6] + ".png"));
				_image.x = 340; 
				_image.y = 100 + (160 * i);
				_cardsRight.addChild(_image);
				
				_image = new Image(Resource.textureAtlas.getTexture(_cardsDefence[i][4]));
				_image.x = 330 + (105 / 2) - (_image.width / 3);
				_image.y = (100 + (160 * i)) + (155 / 2) - (_image.height / 3);
				_image.scaleX -= 0.2;
				_image.scaleY -= 0.2;
				_cardsRight.addChild(_image);
				
				_textField = new TextField(100, 50, "x" + _cardsDefence[i][1], "Arial Black", 20, 0xffffff, false);
				_textField.hAlign = "left";
				_textField.x = 350;
				_textField.y = 95 + (160 * i);
				_cardsRight.addChild(_textField);
				
				_textField = new TextField(120, 60, _cardsDefence[i][2], "Arial Black", 48, 0xffffff, false);
				_textField.hAlign = "right";
				_textField.x = 315;
				_textField.y = 190 + (160 * i);
				_cardsRight.addChild(_textField);
			}
			_cards.addChild(_cardsRight);
		}
		
		private function setMask():void
		{
			_cards.clipRect = new Rectangle(225, 100, 220, 155);
		}
		
		private function navigationButtons():void 
		{
			var bitmap:Bitmap = new Resource.TextureButtonUp();
			_button = new Button(Texture.fromBitmap(bitmap));
			_button.name = Constants.WINDOW_BUY_FIGHTER_BUTTON_UP;
			_button.x = 305;
			_button.y = 45;
			_button.scaleX -= 0.3;
			_button.scaleY -= 0.3;
			addChild(_button);
			
			bitmap = new Resource.TextureButtonDown();
			_button = new Button(Texture.fromBitmap(bitmap));
			_button.name = Constants.WINDOW_BUY_FIGHTER_BUTTON_DOWN;
			_button.x = 305;
			_button.y = 255;
			_button.scaleX -= 0.3;
			_button.scaleY -= 0.3;
			addChild(_button);
			
			bitmap = null;
		}
		
		private function onButtonsClick(e:Event):void 
		{
			if ((e.target as Button).name == Constants.WINDOW_BUY_FIGHTER_BUTTON_UP) leafThroughUp();
			if ((e.target as Button).name == Constants.WINDOW_BUY_FIGHTER_BUTTON_DOWN) leafThroughDown();
		}
		
		private function leafThroughDown():void 
		{
			if (_move == true)
			{
				if (_cardsLeft.y > ((_cardsLeft.height -160) * -1)) {
					_move = false;
					_tween = new Tween(_cardsLeft, 0.5); 
					_tween.moveTo(_cardsLeft.x, _cardsLeft.y - 160);
					Starling.juggler.add(_tween);
					_tween = new Tween(_cardsRight, 0.5); 
					_tween.moveTo(_cardsRight.x, _cardsRight.y - 160);
					_tween.onComplete = endMove;
					Starling.juggler.add(_tween);
				}
			}
		}
		
		private function leafThroughUp():void 
		{
			if (_move == true)
			{
				if (_cardsLeft.y < 0) {
					_move = false;
					_tween = new Tween(_cardsLeft, 0.5); 
					_tween.moveTo(_cardsLeft.x, _cardsLeft.y + 160);
					Starling.juggler.add(_tween);
					_tween = new Tween(_cardsRight, 0.5); 
					_tween.moveTo(_cardsRight.x, _cardsRight.y + 160);
					_tween.onComplete = endMove;
					Starling.juggler.add(_tween);
				}
			}
		}
		
		private function endMove():void
		{
			_move = true; // движение разрешено
		}
		
		
		public function get CardsAttack():Array
		{
			return _cardsAttack;
		}

		public function set CardsAttack(value:Array):void
		{
			_cardsAttack = value;
		}
		
		public function get CardsDefence():Array
		{
			return _cardsDefence;
		}

		public function set CardsDefence(value:Array):void
		{
			_cardsDefence = value;
		}
		
	}

}