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
	import mkquest.assets.character.CharacterSmall;
	
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
		private var _userIcon:Sprite;
		private var _character:CharacterSmall;
		
		public function Stairs() 
		{
			super();
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			addEventListener(Event.REMOVED, onRemoveStage);
			addEventListener(Event.TRIGGERED, onButtonsClick);
		}
		
		private function onAddedToStage(e:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			name = Constants.MK_WINDOW_STAIRS;
			
			if (Resource.tournamentProgress >= 0)
			{
				createWindow();					// Создание окна турнира
				createButtonsPanelFromXML();	// Создание кнопок меню
			
				if (Resource.tournamentProgress == 12)
				{
					animationStartFighterStairs(); // Анимация при первой битве
				}
				else
				{
					animationNextFighterStairs(); // Анимация перемещения вверх по турнирной лестнице
				}
				if (Resource.user_continue == 0) dispatchEvent(new Navigation(Navigation.CHANGE_SCREEN, true, { id: Constants.WINDOW_ENDED_LIFE_SHOW } ));
			}
			else
			{
				dispatchEvent(new Navigation(Navigation.CHANGE_SCREEN, true, { id: Constants.GAME_END } ));
			}
		}
		
		/* Создание: окна, столбца бойцов, окна характеристик, кнопки меню */
		private function createWindow():void
		{
			/* окно */
			_window = new Sprite();
			_window.x = _fileXML.WindowPosX;
			_window.y = _fileXML.WindowPosY;
			
			/* Фоновая картинка */
			createWindowBackground();
			
			/* Столб бойцов */
			createWindowStairFightersAndUserIcon();
			
			/* Рамка окна */
			_image = new Image(Resource.textureAtlas.getTexture(_fileXML.Border));
			_window.addChild(_image);
			
			/* Окна характеристик */
			createWindowCharacters();
			
			/* Добавляем окно на сцену*/
			addChild(_window);
			
			/* Маска окна */
			clipMask(_window, 0, 0, Constants.MK_WINDOW_WIDTH, Constants.MK_WINDOW_HEIGHT);
		}
		
		
		private function createWindowBackground():void
		{
			_image = new Image(Resource.textureAtlas.getTexture(_fileXML.Background));
			_image.scaleX += 1;
			_image.scaleY += 1.35;
			_window.addChild(_image);
		}
		
		private function createWindowStairFightersAndUserIcon():void
		{
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
			if (Resource.tournamentProgress < 12)
			{
				_fighterStairs.y = -710 + (95 * (11 - Resource.tournamentProgress)); 
			}
			else
			{
				_fighterStairs.y = _fileXML.StairsPosY;
			}
			
			
			/* Иконка Пользователя */
			_userIcon = new Sprite();
			if (Resource.tournamentProgress == 12)
			{
				_userIcon.x = _fileXML.UserIcon[Resource.tournamentProgress].PosX;
				_userIcon.y = _fileXML.UserIcon[Resource.tournamentProgress].PosY;
			}
			else
			{
				_userIcon.x = _fileXML.UserIcon[Resource.tournamentProgress + 1].PosX;
				_userIcon.y = _fileXML.UserIcon[Resource.tournamentProgress + 1].PosY;
			}
			_image = new Image(Resource.textureAtlas.getTexture(Resource.user_name + ".png"));
			_image.scaleX -= 0.15;
			_image.scaleY -= 0.15;
			_userIcon.addChild(_image); 
			_fighterStairs.addChild(_userIcon); // Добавляем иконку пользователя на столб
			
			/* Добавляем столб в окно */
			_window.addChild(_fighterStairs);
			
		}
		
		private function createWindowCharacters():void
		{
			/* Характеристики пользователя */
			_character = new CharacterSmall(-200, _fileXML.Character[0].PosY);
			_character.name = _fileXML.Character[0].Name;
			if (Resource.experiencePoints > 0)
			{
				_character.createButtonsPlus();
			}
			_character.selectValueUserCharacter();
			_window.addChild(_character);
			animationCharactersStairs(_character, _fileXML.Character[0].PosX, _fileXML.Character[0].PosY);
		
			
			/* Характеристики ИИ */
			_character = new CharacterSmall(800, _fileXML.Character[1].PosY);
			_character.name = _fileXML.Character[1].Name;
			_character.selectValueAICharacter(Resource.tournamentProgress);
			_window.addChild(_character);
			animationCharactersStairs(_character, _fileXML.Character[1].PosX, _fileXML.Character[1].PosY);
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

		private function animationCharactersStairs(character:CharacterSmall, characterX:int, characterY:int):void
		{
			_tween = new Tween(character, 1.0);
			_tween.moveTo(characterX, characterY);
			Starling.juggler.add(_tween);
		}
		
		private function animationNextFighterStairs():void
		{
			_tween = new Tween(_fighterStairs, 5.0);
			_tween.moveTo(_fighterStairs.x, _fighterStairs.y + 95);
			Starling.juggler.add(_tween);
			_tween = new Tween(_userIcon, 5.0);
			_tween.moveTo(_userIcon.x, _userIcon.y - 95);
			Starling.juggler.add(_tween);
		}
		
		private function animationStartFighterStairs():void
		{
			_tween = new Tween(_fighterStairs, 5.0);

			_tween.moveTo(_fighterStairs.x, -710);
			
			//_tween.onComplete = animationFighterStairs;
			Starling.juggler.add(_tween);
		}
		
		
		private function onButtonsClick(event:Event):void 
		{
			if (Button(event.target).name == Constants.BUTTON_BACK_IN_MENU  || Button(event.target).name == Constants.MENU_BUTTON_SATTINGS || Button(event.target).name == Constants.BUTTON_FIGHT)
			{
				dispatchEvent(new Navigation(Navigation.CHANGE_SCREEN, true, { id: Button(event.target).name } ));
			}
		}
		
		private function onRemoveStage(e:Event):void
		{
			Starling.juggler.remove(_tween);
			_tween = null;
			
			super.dispose();
			trace("[X] Удалена сцена столб бойцов");
		}
	}

}