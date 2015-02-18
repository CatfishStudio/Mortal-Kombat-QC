package mkquest.assets.stairs 
{
	import flash.geom.Rectangle;
	import starling.display.Button;
	
	import starling.core.Starling;
	import starling.animation.Tween;
	import starling.animation.Transitions;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	
	import mkquest.assets.xml.FileXML;
	import mkquest.assets.events.Navigation;
	import mkquest.assets.statics.Constants;
	import mkquest.assets.statics.Resource;
	
	public class Stairs extends Sprite
	{
		[Embed(source = 'Stairs.xml', mimeType='application/octet-stream')]
		private var ClassFileXML:Class;
		private var _fileXML:XML = FileXML.getFileXML(ClassFileXML);
		
		private var _tween:Tween;
		private var _xStart:int;
		private var _yStart:int;
		private var _xEnd:int;
		private var _yEnd:int;
		
		private var _image:Image;
		private var _button:Button;
		private var _window:Sprite;
		private var _fighterStairs:Sprite;
		
		public function Stairs() 
		{
			super();
			this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			this.addEventListener(Event.REMOVED, onRemoveStage);
			addEventListener(Event.TRIGGERED, onButtonsClick);
		}
		
		private function onAddedToStage(e:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			name = Constants.MK_WINDOW_STAIRS;
			
			createStairsFromXML();
			createButtonsPanelFromXML();
			
			animationFighterStairs();
		}
		
		/* Создание: окна, столбца бойцов, окна характеристик, кнопки меню */
		private function createStairsFromXML():void
		{
			/* окно */
			_window = new Sprite();
			_window.x = _fileXML.WindowPosX;
			_window.y = _fileXML.WindowPosY;
			
			/* Фоновая картинка */
			_image = new Image(Resource.textureAtlas.getTexture(_fileXML.Background));
			_image.scaleX += 1;
			_image.scaleY += 1.35;
			_window.addChild(_image);
			
			/* Столб бойцов */
			_fighterStairs = new Sprite();
			var n:int = _fileXML.StairsCount - 1;
			for (var k:int = 0; k < n; k++)
			{
				_image = new Image(Resource.textureAtlas.getTexture(Resource.ai_enemies[k].aiName + ".png")); // иконка
				_image.x = _fileXML.Icon[k].PosX;
				_image.y = _fileXML.Icon[k].PosY;
				_fighterStairs.addChild(_image);
				
				_image = new Image(Resource.textureAtlas.getTexture(_fileXML.StairsUp)); // блок
				_image.y += k * _fileXML.StairsUpHeight;
				_fighterStairs.addChild(_image);
			}
			
			_image = new Image(Resource.textureAtlas.getTexture(Resource.ai_enemies[n].aiName + ".png")); // иконка
			_image.x = _fileXML.Icon[n].PosX;
			_image.y = _fileXML.Icon[n].PosY;
			_fighterStairs.addChild(_image);
			_image = new Image(Resource.textureAtlas.getTexture(_fileXML.StairsDown)); // блок
			_image.y += _fileXML.StairsCount * _fileXML.StairsUpHeight - _fileXML.StairsUpHeight;
			_fighterStairs.addChild(_image);
			_fighterStairs.x = _fileXML.StairsPosX;
			_fighterStairs.y = _fileXML.StairsPosY;
			_window.addChild(_fighterStairs);
			
			/* Рамка окна*/
			_image = new Image(Resource.textureAtlas.getTexture(_fileXML.Border));
			_window.addChild(_image);
			
			/* Окна характеристик */
			
			/* Добавляем всё в окно */
			addChild(_window);
			
			/* Маска окна */
			clipMask(_window, 0, 0, Constants.MK_WINDOW_WIDTH, Constants.MK_WINDOW_HEIGHT);
			
			
		}
		
		private function createButtonsPanelFromXML():void
		{
			var n:int = _fileXML.Button.length();
			for (var m:int = 0; m < n; m++)
			{
				_button = new Button(Resource.textureAtlas.getTexture(_fileXML.Button[m].Texture));
				_button.name = _fileXML.Button[m].Name;
				if (Resource.languageRus == true)
				{
					_button.text = _fileXML.Button[m].TextRus;
				}
				else 
				{
					_button.text = _fileXML.Button[m].TextEng;
				}
				_button.fontName = _fileXML.Button[m].FontName;
				_button.fontColor = _fileXML.Button[m].FontColor;
				_button.fontSize = _fileXML.Button[m].FontSize;
				_button.x = _fileXML.Button[m].PosX;
				_button.y = _fileXML.Button[m].PosY;
				addChild(_button);
			}
		}
		
		private function clipMask(_sprite:Sprite, _x:int, _y:int, _width:int, _height:int):void
		{
			_sprite.clipRect = new Rectangle(_x, _y, _width, _height);
		}

		private function animationFighterStairs():void
		{
			_tween = new Tween(_fighterStairs, 5.0);

			_tween.moveTo(_fighterStairs.x, -710);
			
			//_tween.onComplete = animationFighterStairs;
			Starling.juggler.add(_tween);
		}
		
		
		private function onButtonsClick(event:Event):void 
		{
			if (Button(event.target).name == Constants.BUTTON_BACK_IN_MENU || Button(event.target).name == Constants.MENU_BUTTON_SATTINGS || Button(event.target).name == Constants.BUTTON_FIGHTER)
			{
				dispatchEvent(new Navigation(Navigation.CHANGE_SCREEN, true, { id: Button(event.target).name } ));
			}
		}
		
		private function onRemoveStage(e:Event):void
		{
			//_image.dispose();
			_image = null;
			//_button.dispose();
			_button = null;
			
			//_window.dispose();
			_window = null;
			//_fighterStairs.dispose();
			_fighterStairs = null;
			
			/*
			while (this.numChildren)
			{
				this.removeChildAt(0, true);
			}
			this.removeFromParent(true);
			*/
			
			Starling.juggler.remove(_tween);
			_tween = null;
			
			super.dispose();
		}
	}

}