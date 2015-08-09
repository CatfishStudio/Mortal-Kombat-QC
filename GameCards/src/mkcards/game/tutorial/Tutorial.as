package mkcards.game.tutorial 
{
	import flash.system.*;
	import flash.display.Bitmap;
	
	import starling.textures.Texture;
	import starling.core.Starling;
	import starling.animation.Tween;
	import starling.animation.Transitions;
	import starling.display.Image;
	import starling.text.TextField;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.display.Quad;
	
	import mkcards.game.statics.Constants;
	import mkcards.game.statics.Resource;
	
	
	public class Tutorial extends Sprite 
	{
		private var _step:int = 0;
		private var _tween:Tween;
		private var _image:Image;
		private var _textField:TextField;
		private var _bg:Quad;
		private var _shaokahn:Sprite;
		private var _dialog:Sprite;
		private var _arrow:Sprite;
		private var _arrowPosX:int = 0;
		private var _arrowPosY:int = 0;
		private var _moveX:int = 5;
		private var _moveY:int = 5;
		
		
		public function Tutorial(step:int) 
		{
			super();
			_step = step;
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			addEventListener(Event.REMOVED, onRemoveStage);
		}
		
		private function onRemoveStage(e:Event):void
		{
			Starling.juggler.remove(_tween);
			_tween = null;
			super.dispose();
			System.gc();
			trace("[X] Удалена сцена Тутора");
		}
		
		private function onAddedToStage(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			name = Constants.TUTORIAL;
			
			animationShaokahn();
		}
		
		public function get Step():int
		{
			return _step;
		}

		public function set Step(value:int):void
		{
			_step = value;
		}

		private function animationShaokahn():void
		{
			_shaokahn = new Sprite(); // ширина(width) 390 x высота(height) 350
			_shaokahn.x = -350;
			_shaokahn.y = Constants.GAME_WINDOW_HEIGHT - 350;
			
			var bitmap:Bitmap = new Resource.TextureTutorialShaokahn();
			_image = new Image(Texture.fromBitmap(bitmap));
			_image.x = 0;
			_image.y = 0;
			_shaokahn.addChild(_image);
			bitmap = null;
			
			this.addChild(_shaokahn);
			
			_tween = new Tween(_shaokahn, 0.5);
			_tween.moveTo(-150, _shaokahn.y);
			_tween.onComplete = showDialogAndArrow;
			Starling.juggler.add(_tween);
		}
		
		private function showDialogAndArrow():void
		{
			_dialog = new Sprite();
			_dialog.x = 100;
			_dialog.y = Constants.GAME_WINDOW_HEIGHT - 200;
			
			var bitmap:Bitmap = new Resource.TextureTutorialDialog();
			_image = new Image(Texture.fromBitmap(bitmap));
			_dialog.addChild(_image);
			bitmap = null;
			
			if (_step == 1)
			{
				_textField = new TextField(180, 150, "Выбери на чьей ты стороне.", "Arial", 17, 0xffffff, false);
				_textField.x = 25;
				_textField.y = 10;
				_dialog.addChild(_textField);
				
				_arrow = new Sprite();
				_arrowPosX = Constants.GAME_WINDOW_WIDTH / 2.0 + 5;
				_arrowPosY = Constants.GAME_WINDOW_HEIGHT / 1.5;
				_arrow.x = _arrowPosX;
				_arrow.y = _arrowPosY;
				bitmap = new Resource.TextureTutorialUp();
				_image = new Image(Texture.fromBitmap(bitmap));
				_arrow.addChild(_image);
				bitmap = null;
				this.addChild(_arrow);
				
				_moveX = 100;
				animationArrowLeftRight();
			}
			
			if (_step == 2)
			{
				_textField = new TextField(180, 150, "У тебя есть \n 1000 монет. \n Выбери бойца.", "Arial", 17, 0xffffff, false);
				_textField.x = 25;
				_textField.y = 10;
				_dialog.addChild(_textField);
				
				_arrow = new Sprite();
				_arrowPosX = Constants.GAME_WINDOW_WIDTH - 150;
				_arrowPosY = Constants.GAME_WINDOW_HEIGHT - 140;
				_arrow.x = _arrowPosX;
				_arrow.y = _arrowPosY;
				bitmap = new Resource.TextureTutorialDown();
				_image = new Image(Texture.fromBitmap(bitmap));
				_arrow.addChild(_image);
				bitmap = null;
				this.addChild(_arrow);
				
				animationArrowUpDown();
			}
			
			if (_step == 3)
			{
				_textField = new TextField(180, 150, "Прими свою судьбу. \n Начни битву.", "Arial", 17, 0xffffff, false);
				_textField.x = 25;
				_textField.y = 10;
				_dialog.addChild(_textField);
				
				_arrow = new Sprite();
				_arrowPosX = Constants.GAME_WINDOW_WIDTH - 175;
				_arrowPosY = Constants.GAME_WINDOW_HEIGHT - 150;
				_arrow.x = _arrowPosX;
				_arrow.y = _arrowPosY;
				bitmap = new Resource.TextureTutorialDown();
				_image = new Image(Texture.fromBitmap(bitmap));
				_arrow.addChild(_image);
				bitmap = null;
				this.addChild(_arrow);
				
				animationArrowUpDown();
			}
			
			if (_step == 4)
			{
				_textField = new TextField(180, 150, "Нанеси свой удар. \n Собери три фишки в ряд.", "Arial", 17, 0xffffff, false);
				_textField.x = 25;
				_textField.y = 10;
				_dialog.addChild(_textField);
				
				_arrow = new Sprite();
				_arrowPosX = Constants.GAME_WINDOW_WIDTH / 2 - 45;
				_arrowPosY = Constants.GAME_WINDOW_HEIGHT - 125;
				_arrow.x = _arrowPosX;
				_arrow.y = _arrowPosY;
				bitmap = new Resource.TextureTutorialUp();
				_image = new Image(Texture.fromBitmap(bitmap));
				_arrow.addChild(_image);
				bitmap = null;
				this.addChild(_arrow);
				
				_bg = new Quad(Constants.GAME_WINDOW_WIDTH, 100,  0x000000, true);
				_bg.x = 0;
				_bg.y = Constants.GAME_WINDOW_HEIGHT - 100;
				_bg.alpha = 0;
				this.addChild(_bg);
				
				animationArrowUpDown();
			}
			
			if (_step == 5)
			{
				_textField = new TextField(180, 150, "Ты получил очко опыта. Потрать его на улучшения боевого искуства.", "Arial", 17, 0xffffff, false);
				_textField.x = 25;
				_textField.y = 10;
				_dialog.addChild(_textField);
				
				_arrow = new Sprite();
				_arrowPosX = Constants.GAME_WINDOW_WIDTH / 4 + 5;
				_arrowPosY = 115;
				_arrow.x = _arrowPosX;
				_arrow.y = _arrowPosY;
				bitmap = new Resource.TextureTutorialDown();
				_image = new Image(Texture.fromBitmap(bitmap));
				_arrow.addChild(_image);
				bitmap = null;
				this.addChild(_arrow);
				
				_bg = new Quad(Constants.GAME_WINDOW_WIDTH, 100,  0x000000, true);
				_bg.x = 0;
				_bg.y = Constants.GAME_WINDOW_HEIGHT - 100;
				_bg.alpha = 0;
				this.addChild(_bg);
				
				animationArrowUpDown();
			}
			
			if (_step == 6)
			{
				_textField = new TextField(180, 150, "Закончились жизни. Позови друга в игру и получишь жизнь в подарок.", "Arial", 17, 0xffffff, false);
				_textField.x = 25;
				_textField.y = 10;
				_dialog.addChild(_textField);
				
				_arrow = new Sprite();
				_arrowPosX = Constants.GAME_WINDOW_WIDTH / 4 + 265;
				_arrowPosY = 425;
				_arrow.x = _arrowPosX;
				_arrow.y = _arrowPosY;
				bitmap = new Resource.TextureTutorialUp();
				_image = new Image(Texture.fromBitmap(bitmap));
				_arrow.addChild(_image);
				bitmap = null;
				this.addChild(_arrow);
				
				animationArrowUpDown();
			}
			
			this.addChild(_dialog);
			
			animationDialog();
		}
		
		private function animationDialog():void
		{
			_tween = new Tween(_dialog, 1.0);
			if (_dialog.x == 100) _tween.moveTo(_dialog.x - 10, _dialog.y);
			if (_dialog.x == 90) _tween.moveTo(_dialog.x + 10, _dialog.y);
			_tween.onComplete = animationDialog;
			Starling.juggler.add(_tween);
		}
		
		private function animationArrowLeftRight():void
		{
			_tween = new Tween(_arrow, 0.5);
			if (_arrow.x == _arrowPosX) _tween.moveTo(_arrow.x - _moveX, _arrow.y);
			if (_arrow.x == _arrowPosX - _moveX) _tween.moveTo(_arrow.x + _moveX, _arrow.y);
			_tween.onComplete = animationArrowLeftRight;
			Starling.juggler.add(_tween);
		}
		
		private function animationArrowUpDown():void
		{
			_tween = new Tween(_arrow, 0.5);
			if (_arrow.y == _arrowPosY) _tween.moveTo(_arrow.x, _arrow.y - _moveY);
			if (_arrow.y == _arrowPosY - _moveY) _tween.moveTo(_arrow.x, _arrow.y + _moveY);
			_tween.onComplete = animationArrowUpDown;
			Starling.juggler.add(_tween);
		}
		
	}

}