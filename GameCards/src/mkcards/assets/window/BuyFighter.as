package mkcards.assets.window 
{
	
	import starling.display.Image;
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
	
	import mkcards.assets.xml.FileXML;
	
	public class BuyFighter extends Sprite 
	{
		[Embed(source = 'BuyFighter.xml', mimeType='application/octet-stream')]
		private var ClassFileXML:Class;
		private var _fileXML:XML = FileXML.getFileXML(ClassFileXML);
		
		private var _listFighters:Vector.<Sprite> = new Vector.<Sprite>();
		
		private var _tween:Tween;		// анимация
		private var _xStart:int;		// начальное значение по Х
		private var _textField:TextField;
		private var _button:Button;
		
		public function BuyFighter() 
		{
			super();
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			addEventListener(Event.REMOVED_FROM_STAGE, onRemoveFromStage);
			addEventListener(Event.TRIGGERED, onButtonsClick);
		}
		
		private function onAddedToStage(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			name = Constants.WINDOW_BUY_FIGHTER;
			
			buttons(); // Кнопки общего назначения
			
			navigationButtons(); // Кнопки навигации
			
			_listFighters = initListFighters(); // Инициализация ленты бойцов
						
			showListFighters(); // Отображение ленты бойцов 
		}
		
		private function onRemoveFromStage(e:Event):void 
		{
			removeEventListener(Event.REMOVED_FROM_STAGE, onRemoveFromStage);
			
		}
		
		private function onButtonsClick(e:Event):void 
		{
			if ((e.target as Button).name == Constants.WINDOW_BUY_FIGHTER_BUTTON_LEFT) leafThroughLeft();
			if ((e.target as Button).name == Constants.WINDOW_BUY_FIGHTER_BUTTON_RIGHT) leafThroughRight();
		}
		
		private function buttons():void 
		{
			var bitmap:Bitmap = new Resource.TextureButton();
			_button = new Button(Texture.fromBitmap(bitmap));
			_button.name = _fileXML.Button[0].Name;
			if (Resource.languageRus == true) _button.text = _fileXML.Button[0].TextRus;
			else _button.text = _fileXML.Button[0].TextEng;
			_button.fontName = _fileXML.Button[0].FontName;
			_button.fontColor = _fileXML.Button[0].FontColor;
			_button.fontSize = _fileXML.Button[0].FontSize;
			_button.x = Constants.GAME_WINDOW_WIDTH - 200;
			_button.y = Constants.GAME_WINDOW_HEIGHT - 70;
			addChild(_button);
			
			_button = new Button(Texture.fromBitmap(bitmap));
			_button.name = _fileXML.Button[1].Name;
			if (Resource.languageRus == true) _button.text = _fileXML.Button[1].TextRus;
			else _button.text = _fileXML.Button[1].TextEng;
			_button.fontName = _fileXML.Button[1].FontName;
			_button.fontColor = _fileXML.Button[1].FontColor;
			_button.fontSize = _fileXML.Button[1].FontSize;
			_button.x = 25;
			_button.y = Constants.GAME_WINDOW_HEIGHT - 70;
			addChild(_button);
			
			bitmap = null;
		}
		
		private function navigationButtons():void 
		{
			var bitmap:Bitmap = new Resource.TextureButtonLeft();
			_button = new Button(Texture.fromBitmap(bitmap));
			_button.name = _fileXML.Button[2].Name;
			_button.x = Constants.GAME_WINDOW_WIDTH / 7.2;
			_button.y = Constants.GAME_WINDOW_HEIGHT / 2.1;
			addChild(_button);
			
			bitmap = new Resource.TextureButtonRight();
			_button = new Button(Texture.fromBitmap(bitmap));
			_button.name = _fileXML.Button[3].Name;
			_button.x = Constants.GAME_WINDOW_WIDTH / 1.28;
			_button.y = Constants.GAME_WINDOW_HEIGHT / 2.1;
			addChild(_button);
			
			bitmap = null;
		}
		
		
		private function initListFighters():Vector.<Sprite> 
		{
			var list:Vector.<Sprite> = new Vector.<Sprite>();
			var fighter:Sprite;
			var bitmap:Bitmap;
			var image:Image;
			
			
			var n:int = _fileXML.Fighter.length();
			for (var i:int = 0; i < n; i++)
			{
				fighter = new Sprite();
				bitmap = new Resource.TextureSelectFighterBackground();
				fighter.addChild(new Image(Texture.fromBitmap(bitmap)));
				bitmap = new Resource.TextureSelectFighterBorder();
				fighter.addChild(new Image(Texture.fromBitmap(bitmap)));
				fighter.name = _fileXML.Fighter[i].Name;
				fighter.addEventListener(TouchEvent.TOUCH, onButtonTouch);
				list.push(fighter);
			}
			return list;
		}
		
		private function onButtonTouch(e:TouchEvent):void 
		{
			var touch:Touch = e.getTouch(stage);
			if (touch)
			{
				if (touch.phase == TouchPhase.BEGAN) { _xStart = touch.globalX; Mouse.cursor = MouseCursor.BUTTON; }
				else if (touch.phase == TouchPhase.ENDED)
				{
					if (_xStart > touch.globalX) leafThroughLeft();
					if (_xStart < touch.globalX) leafThroughRight();
					Mouse.cursor = MouseCursor.AUTO;
				}
				
			} 
		}
		
		private function leafThroughLeft():void
		{
			if((_listFighters[_listFighters.length - 1] as Sprite).x > 300){
				var fighter:Sprite;
				var n:int = _listFighters.length;
				for (var i:int = 0; i < n; i++) {
					fighter = (_listFighters[i] as Sprite); 
					_tween = new Tween(fighter, 0.5); 
					_tween.moveTo(fighter.x - 550, 200);
					Starling.juggler.add(_tween);
				}
			}
		}
		
		private function leafThroughRight():void
		{
			if((_listFighters[0] as Sprite).x < 200){
				var fighter:Sprite;
				var n:int = _listFighters.length;
				for (var i:int = 0; i < n; i++) {
					fighter = (_listFighters[i] as Sprite); 
					_tween = new Tween(fighter, 0.5); 
					_tween.moveTo(fighter.x + 550, 200);
					Starling.juggler.add(_tween);
				}
			}
		}
		
		
		private function showListFighters():void 
		{
			var fighter:Sprite;
			var xStart:int = -350;
			var n:int = _listFighters.length;
			for (var i:int = 0; i < n; i++) {
				fighter = (_listFighters[i] as Sprite); 
				fighter.x = xStart; 
				fighter.y = Constants.GAME_WINDOW_HEIGHT / 3.5; 
				this.addChild(fighter);
				xStart += 550;
			}
		}
		
	}

}