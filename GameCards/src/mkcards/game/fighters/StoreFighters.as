package mkcards.game.fighters 
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
	
	import mkcards.events.Navigation;
	import mkcards.game.statics.Constants;
	import mkcards.game.statics.Resource;
	import mkcards.game.fighters.FighterCard;
	import mkcards.game.cards.Card;
	import mkcards.xml.FileXML;
	
	public class StoreFighters extends Sprite 
	{
		[Embed(source = 'StoreFighters.xml', mimeType='application/octet-stream')]
		private var ClassFileXML:Class;
		private var _fileXML:XML = FileXML.getFileXML(ClassFileXML);
		
		private var _listFighters:Vector.<FighterCard> = new Vector.<FighterCard>();
		private var _selectFighterIndex:int = 0;
		private var _selectFighterName:String;
		private var _selectFighterPrice:int = 0;
		
		private var _tween:Tween;		// анимация
		private var _xStart:int;		// начальное значение по Х
		private var _textField:TextField;
		private var _button:Button;

		
		public function StoreFighters() 
		{
			super();
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			addEventListener(Event.REMOVED_FROM_STAGE, onRemoveFromStage);
			addEventListener(Event.TRIGGERED, onButtonsClick);
		}
		
		private function onAddedToStage(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			name = Constants.WINDOW_STORE_FIGHTERS;
			Resource.initTextureAtlas(Resource.AtlasFighters, Resource.AtlasFightersXML, true, false) // инициализация атласа
			
			showTitle();
			buttons();
			navigationButtons();
			_listFighters = initListFighters(); // Инициализация ленты бойцов
			showListFighters();
		}
		
		private function onRemoveFromStage(e:Event):void 
		{
			removeEventListener(Event.REMOVED_FROM_STAGE, onRemoveFromStage);
			
		}
		
		private function onButtonsClick(e:Event):void 
		{
			if ((e.target as Button).name == Constants.WINDOW_STORE_FIGHTERS_BUTTON_LEFT) leafThroughLeft();
			if ((e.target as Button).name == Constants.WINDOW_STORE_FIGHTERS_BUTTON_RIGHT) leafThroughRight();
			//if ((e.target as Button).name == Constants.WINDOW_BUY_FIGHTER_BUTTON_BACK) back();
			//if ((e.target as Button).name == Constants.WINDOW_BUY_FIGHTER_BUTTON_BUY) buy();
		}
		
		
		private function showTitle():void
		{
			var bitmap:Bitmap = new Resource.TextureTitle();
			var image:Image = new Image(Texture.fromBitmap(bitmap));
			image.x = (Constants.GAME_WINDOW_WIDTH / 4.5) + 35;
			image.y = (Constants.GAME_WINDOW_HEIGHT / 3.5) + 15;
			addChild(image);
			
			var texture:Texture = Texture.fromEmbeddedAsset(Resource.FontTexture);
			var xml:XML = XML(new Resource.FontXml());
			TextField.registerBitmapFont(new BitmapFont(texture, xml), "Font01");
			
			_textField = new TextField(450, 50, _fileXML.Title, "Arial", 27, 0xffffff, false);
			_textField.fontName = "Font01";
			_textField.hAlign = "center";
			_textField.x = (Constants.GAME_WINDOW_WIDTH / 4.5) + 15;
			_textField.y = (Constants.GAME_WINDOW_HEIGHT / 3.5) + 15;
			addChild(_textField);
		
			bitmap = null;
			image.dispose();
			image = null;
		}
		
		private function buttons():void 
		{
			var bitmap:Bitmap = new Resource.TextureButton();
			_button = new Button(Texture.fromBitmap(bitmap));
			_button.name = _fileXML.ButtonBuy.Name;
			if (Resource.languageRus == true) _button.text = _fileXML.ButtonBuy.TextRus;
			else _button.text = _fileXML.ButtonBuy.TextEng;
			_button.fontName = _fileXML.ButtonBuy.FontName;
			_button.fontColor = _fileXML.ButtonBuy.FontColor;
			_button.fontSize = _fileXML.ButtonBuy.FontSize;
			_button.x = Constants.GAME_WINDOW_WIDTH - 200;
			_button.y = Constants.GAME_WINDOW_HEIGHT - 70;
			addChild(_button);
			
			_button = new Button(Texture.fromBitmap(bitmap));
			_button.name = _fileXML.ButtonClose.Name;
			if (Resource.languageRus == true) _button.text = _fileXML.ButtonClose.TextRus;
			else _button.text = _fileXML.ButtonClose.TextEng;
			_button.fontName = _fileXML.ButtonClose.FontName;
			_button.fontColor = _fileXML.ButtonClose.FontColor;
			_button.fontSize = _fileXML.ButtonClose.FontSize;
			_button.x = 25;
			_button.y = Constants.GAME_WINDOW_HEIGHT - 70;
			addChild(_button);
		
			bitmap = null;
		}
		
		private function navigationButtons():void 
		{
			var bitmap:Bitmap = new Resource.TextureButtonLeft();
			_button = new Button(Texture.fromBitmap(bitmap));
			_button.name = _fileXML.ButtonLeft.Name;
			_button.x = Constants.GAME_WINDOW_WIDTH / 3.5;
			_button.y = Constants.GAME_WINDOW_HEIGHT / 1.8;
			addChild(_button);
			
			bitmap = new Resource.TextureButtonRight();
			_button = new Button(Texture.fromBitmap(bitmap));
			_button.name = _fileXML.ButtonRight.Name;
			_button.x = Constants.GAME_WINDOW_WIDTH / 1.65;
			_button.y = Constants.GAME_WINDOW_HEIGHT / 1.8;
			addChild(_button);
			
			bitmap = null;
		}
		
		private function initListFighters():Vector.<FighterCard> 
		{
			var cards:Vector.<Card> = new Vector.<Card>();
			var list:Vector.<FighterCard> = new Vector.<FighterCard>();
			var fighter:Sprite;
			var damage:int = 0;
			var protection:int = 0;
			var life:int = 0;
			var mana:int = 0;
			
			var n:int = _fileXML.Fighter.length();
			for (var i:int = 0; i < n; i++)
			{
				damage = 0;
				protection = 0;
				life = 0;
				mana = 0;
				
				cards = new Vector.<Card>();
				
				var m:int = _fileXML.Fighter.Card.length();
				for (var j:int = 0; j < m; j++)
				{
					damage += fileXML.Fighter.Card[j].Damage;
					protection += fileXML.Fighter.Card[j].Protection;
					life += fileXML.Fighter.Card[j].Life;
					mana += fileXML.Fighter.Card[j].Mana;
					cards.push(new Card());
				}
			
				fighter = new FighterCard();
				fighter.name = _fileXML.Fighter[i].Name;
				fighter.addChild(new Image(Resource.textureAtlas.getTexture(_fileXML.Fighter[i].Name + ".png")));
				(fighter as FighterCard).Price = _fileXML.Fighter[i].Price;
				(fighter as FighterCard).Index = i;
				(fighter as FighterCard).Cards = cards;
				(fighter as FighterCard).specifications(damage, protection, life, mana);
				list.push(fighter);
			}
			
			return list;
		}

		private function showListFighters():void 
		{
			var fighter:FighterCard;
			var xStart:int = 325; //-350;
			var n:int = _listFighters.length;
			for (var i:int = 0; i < n; i++) {
				fighter = (_listFighters[i] as FighterCard); 
				fighter.x = xStart; 
				fighter.y = Constants.GAME_WINDOW_HEIGHT / 2.5; 
				this.addChild(fighter);
				xStart += 275;
			}
		}
		
		private function leafThroughRight():void
		{
			if ((_listFighters[_listFighters.length - 1] as Sprite).x > 500) {
				_selectFighterIndex++;
				var fighter:Sprite;
				var n:int = _listFighters.length;
				for (var i:int = 0; i < n; i++) {
					fighter = (_listFighters[i] as Sprite); 
					_tween = new Tween(fighter, 0.5); 
					_tween.moveTo(fighter.x - 275, Constants.GAME_WINDOW_HEIGHT / 2.5);
					_tween.onComplete = endMove;
					Starling.juggler.add(_tween);
				}
				//buttonPrice();
			}
		}
		
		private function leafThroughLeft():void
		{
			if ((_listFighters[0] as Sprite).x < 200) {
				_selectFighterIndex--;
				var fighter:Sprite;
				var n:int = _listFighters.length;
				for (var i:int = 0; i < n; i++) {
					fighter = (_listFighters[i] as Sprite); 
					_tween = new Tween(fighter, 0.5); 
					_tween.moveTo(fighter.x + 275, Constants.GAME_WINDOW_HEIGHT / 2.5);
					_tween.onComplete = endMove;
					Starling.juggler.add(_tween);
				}
				//buttonPrice();
			}
		}
		
		private function endMove():void
		{
			
		}
		
	}

}