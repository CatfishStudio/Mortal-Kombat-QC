package mkquest.assets.levels 
{
	import flash.geom.Rectangle;
	import flash.utils.Timer;
	import flash.events.TimerEvent;
	import starling.text.TextField;
	
	import starling.display.Button;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	
	import mkquest.assets.xml.FileXML;
	import mkquest.assets.events.Navigation;
	import mkquest.assets.statics.Constants;
	import mkquest.assets.statics.Resource;
	import mkquest.assets.match3.Match3;
	import mkquest.assets.match3.Events;
	import mkquest.assets.animation.Actions;
	import mkquest.assets.animation.Blood;
	
	
	public class Level extends Sprite 
	{
		private var _fileXML:XML = FileXML.getFileXML(Resource.ClassXMLFileLevel);
		private var _image:Image;
		private var _button:Button;
		private var _window:Sprite;
		private var _textField:TextField;
		
		private var _countTimer:int = 10; 
		private var _timer:Timer;
		
		private var _activePlayer:String = "USER";
		private var _userActions:Actions;
		private var _userBlock:Boolean = false;
		private var _botActions:Actions;
		private var _botBlock:Boolean = false;
		private var _hitType:String;
		
		public function Level() 
		{
			super();
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			addEventListener(Event.REMOVED_FROM_STAGE, onRemoveStage);
			addEventListener(Event.TRIGGERED, onButtonsClick);
		}
		
		private function onAddedToStage(e:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			name = Constants.MK_WINDOW_LEVEL;
			
			createWindow();					// Создание окна уровня
			createButtonsPanelFromXML();	// Создание кнопок меню
			_timer.start();					// Запуск таймера
		}
		
		private function onRemoveStage(e:Event):void
		{
			_timer.stop();
			super.dispose();
			trace("[X] Удалена сцена уровня");
		}
		
		private function createWindow():void
		{
			/* окно */
			_window = new Sprite();
			_window.addEventListener(Events.MATCH_3_EVENTS, onMatch3Events);
			_window.x = _fileXML.WindowPosX;
			_window.y = _fileXML.WindowPosY;
			
			/* Фоновая картинка */
			_image = new Image(Resource.textureAtlas.getTexture(Resource.levels[Resource.tournamentProgress].backgroundFileTexture));
			_image.scaleX += 1;
			_image.scaleY += 1.35;
			_window.addChild(_image);
			
			/* Таймер */
			_timer  = new Timer(1000, 1);
			_timer.addEventListener(TimerEvent.TIMER, timerHandler);
            _timer.addEventListener(TimerEvent.TIMER_COMPLETE, completeHandler);
			if (Resource.languageRus == true) _textField = new TextField(200, 50, _fileXML.Timer.YourHitRus + " " + _countTimer.toString(), _fileXML.Timer.FontName, _fileXML.Timer.FontSize, _fileXML.Timer.FontColor, true);
			else _textField = new TextField(200, 50, _fileXML.Timer.YourHitEng + " " + _countTimer.toString(), _fileXML.Timer.FontName, _fileXML.Timer.FontSize, _fileXML.Timer.FontColor, true);
			_textField.x = _fileXML.Timer.PosX;
			_textField.y = _fileXML.Timer.PosY;
			
			_window.addChild(_textField);
			
			/* Рамка окна */
			_image = new Image(Resource.textureAtlas.getTexture(_fileXML.Border));
			_window.addChild(_image);
			
			/* Бойцы (анимация) */
			showFighters();
			
			/* Построение игрового поля и объектов игрового поля */
			Match3.modeAI = true;
			Match3.BuildCellsAndUnits(_window, Resource.textureAtlas, Resource.levels[Resource.tournamentProgress].levelFileXML, FileXML.getFileXML(Resource.ClassXMLFileLevel0));
			
			/* Добавляем окно на сцену*/
			addChild(_window);
			
			/* Маска окна */
			clipMask(_window, 0, 0, Constants.MK_WINDOW_WIDTH, Constants.MK_WINDOW_HEIGHT);
		}
		
		private function timerHandler(e:TimerEvent):void
		{
			//...
		}
		
		private function completeHandler(e:TimerEvent):void
		{
			if (_countTimer <= 0)
			{
				_countTimer = 10;
				Exchange();
			}
			if (_activePlayer == "USER")
			{
				if (Resource.languageRus == true) _textField.text = _fileXML.Timer.YourHitRus + " " + _countTimer.toString();
				else _textField.text = _fileXML.Timer.YourHitEng + " " + _countTimer.toString();
			}
			else
			{
				if (Resource.languageRus == true) _textField.text = _fileXML.Timer.OpponentHitRus + " " + _countTimer.toString();
				else _textField.text = _fileXML.Timer.OpponentHitEng + " " + _countTimer.toString();
				if (_countTimer == 9) Match3.ActionAI(); // ход искуственного интеллекта
			}
			_countTimer--;
			_timer.start();
		} 
		
		
		/* Отображение бойцов */
		private function showFighters():void
		{
			if (_userActions != null) _window.removeChild(_userActions);
			if (_userBlock == false) _userActions = new Actions(0, 0, true, Resource.user_name, Constants.STANCE, Constants.LEFT_TO_RIGHT);
			else _userActions = new Actions(0, 0, false, Resource.user_name, Constants.HIT_3, Constants.LEFT_TO_RIGHT);
			_userActions.x = (145 - _userActions.width) / 2;
			_userActions.y = Constants.MK_WINDOW_HEIGHT - (_userActions.height + 35);
			_window.addChild(_userActions);
			
			if(_botActions != null) _window.removeChild(_botActions);
			if (_botBlock == false) _botActions = new Actions(0, 0, true, Resource.ai_enemies[Resource.tournamentProgress].aiName, Constants.STANCE, Constants.RIGHT_TO_LEFT);
			else _botActions = new Actions(0, 0, false, Resource.ai_enemies[Resource.tournamentProgress].aiName, Constants.HIT_3, Constants.RIGHT_TO_LEFT);
			_botActions.x = (Constants.MK_WINDOW_WIDTH - 145) + ((145 - _botActions.width) / 2);
			_botActions.y = Constants.MK_WINDOW_HEIGHT - (_botActions.height + 35);
			_window.addChild(_botActions);
		}
		
		private function updateFighters():void
		{
			trace("+++ Удар: " + _hitType + " (" + _activePlayer + ")");
			if (_userActions != null) _window.removeChild(_userActions);
			if (_botActions != null) _window.removeChild(_botActions);
			
			if (_activePlayer == "USER")
			{
				if (_hitType == Constants.HIT_1)
				{
					_userActions = new Actions(0, 0, false, Resource.user_name, Constants.HIT_1, Constants.LEFT_TO_RIGHT);
					if (_botBlock == false)	_botActions = new Actions(0, 0, false, Resource.ai_enemies[Resource.tournamentProgress].aiName, Constants.DAMAGE, Constants.RIGHT_TO_LEFT);
					else _botActions = new Actions(0, 0, false, Resource.ai_enemies[Resource.tournamentProgress].aiName, Constants.HIT_3, Constants.RIGHT_TO_LEFT);
				}
				if (_hitType == Constants.HIT_2)
				{
					_userActions = new Actions(0, 0, false, Resource.user_name, Constants.HIT_2, Constants.LEFT_TO_RIGHT);
					if (_botBlock == false) _botActions = new Actions(0, 0, false, Resource.ai_enemies[Resource.tournamentProgress].aiName, Constants.DAMAGE, Constants.RIGHT_TO_LEFT);
					else _botActions = new Actions(0, 0, false, Resource.ai_enemies[Resource.tournamentProgress].aiName, Constants.HIT_3, Constants.RIGHT_TO_LEFT);
				}
				if (_hitType == Constants.HIT_3)
				{
					_userActions = new Actions(0, 0, false, Resource.user_name, Constants.HIT_3, Constants.LEFT_TO_RIGHT);
					_userBlock = true;
					if (_botBlock == false) _botActions = new Actions(0, 0, true, Resource.ai_enemies[Resource.tournamentProgress].aiName, Constants.STANCE, Constants.RIGHT_TO_LEFT);
					else _botActions = new Actions(0, 0, false, Resource.ai_enemies[Resource.tournamentProgress].aiName, Constants.HIT_3, Constants.RIGHT_TO_LEFT);
				}
				if (_hitType == Constants.HIT_4)
				{
					_userActions = new Actions(0, 0, false, Resource.user_name, Constants.HIT_4, Constants.LEFT_TO_RIGHT);
					if (_botBlock == false) _botActions = new Actions(0, 0, false, Resource.ai_enemies[Resource.tournamentProgress].aiName, Constants.DAMAGE, Constants.RIGHT_TO_LEFT);
					else _botActions = new Actions(0, 0, false, Resource.ai_enemies[Resource.tournamentProgress].aiName, Constants.HIT_3, Constants.RIGHT_TO_LEFT);
				}
				if (_hitType == Constants.HIT_5)
				{
					_userActions = new Actions(0, 0, false, Resource.user_name, Constants.HIT_5, Constants.LEFT_TO_RIGHT);
					if (_botBlock == false) _botActions = new Actions(0, 0, false, Resource.ai_enemies[Resource.tournamentProgress].aiName, Constants.DAMAGE, Constants.RIGHT_TO_LEFT);
					else _botActions = new Actions(0, 0, false, Resource.ai_enemies[Resource.tournamentProgress].aiName, Constants.HIT_3, Constants.RIGHT_TO_LEFT);
				}
			}
			else // BOT
			{
				if (_hitType == Constants.HIT_1)
				{
					_botActions = new Actions(0, 0, false, Resource.ai_enemies[Resource.tournamentProgress].aiName, Constants.HIT_1, Constants.RIGHT_TO_LEFT);
					if (_userBlock == false) _userActions = new Actions(0, 0, false, Resource.user_name, Constants.DAMAGE, Constants.LEFT_TO_RIGHT);
					else _userActions = new Actions(0, 0, false, Resource.user_name, Constants.HIT_3, Constants.LEFT_TO_RIGHT);
				}
				if (_hitType == Constants.HIT_2)
				{
					_botActions = new Actions(0, 0, false, Resource.ai_enemies[Resource.tournamentProgress].aiName, Constants.HIT_2, Constants.RIGHT_TO_LEFT);
					if (_userBlock == false) _userActions = new Actions(0, 0, false, Resource.user_name, Constants.DAMAGE, Constants.LEFT_TO_RIGHT);
					else _userActions = new Actions(0, 0, false, Resource.user_name, Constants.HIT_3, Constants.LEFT_TO_RIGHT);
				}
				if (_hitType == Constants.HIT_3)
				{
					_botActions = new Actions(0, 0, false, Resource.ai_enemies[Resource.tournamentProgress].aiName, Constants.HIT_3, Constants.RIGHT_TO_LEFT);
					_botBlock = true;
					if (_userBlock == false) _userActions = new Actions(0, 0, true, Resource.user_name, Constants.STANCE, Constants.LEFT_TO_RIGHT);
					else _userActions = new Actions(0, 0, false, Resource.user_name, Constants.HIT_3, Constants.LEFT_TO_RIGHT);
				}
				if (_hitType == Constants.HIT_4)
				{
					 _botActions = new Actions(0, 0, false, Resource.ai_enemies[Resource.tournamentProgress].aiName, Constants.HIT_4, Constants.RIGHT_TO_LEFT);
					if (_userBlock == false) _userActions = new Actions(0, 0, false, Resource.user_name, Constants.DAMAGE, Constants.LEFT_TO_RIGHT);
					else _userActions = new Actions(0, 0, false, Resource.user_name, Constants.HIT_3, Constants.LEFT_TO_RIGHT);
				}
				if (_hitType == Constants.HIT_5)
				{
					 _botActions = new Actions(0, 0, false, Resource.ai_enemies[Resource.tournamentProgress].aiName, Constants.HIT_5, Constants.RIGHT_TO_LEFT);
					if (_userBlock == false) _userActions = new Actions(0, 0, false, Resource.user_name, Constants.DAMAGE, Constants.LEFT_TO_RIGHT);
					else _userActions = new Actions(0, 0, false, Resource.user_name, Constants.HIT_3, Constants.LEFT_TO_RIGHT);
				}
			}
			
			_userActions.x = (145 - _userActions.width) / 2;
			_userActions.y = Constants.MK_WINDOW_HEIGHT - (_userActions.height + 35);
			_window.addChild(_userActions);
			_botActions.x = (Constants.MK_WINDOW_WIDTH - 145) + ((145 - _botActions.width) / 2);
			_botActions.y = Constants.MK_WINDOW_HEIGHT - (_botActions.height + 35);
			_window.addChild(_botActions);
			
			if (_activePlayer == "USER" && _hitType != Constants.HIT_3 && _botBlock == false) _window.addChild(new Blood(_botActions.x - 50, _botActions.y - (_botActions.height / 3)));
			if (_activePlayer == "BOT" && _hitType != Constants.HIT_3 && _userBlock == false) _window.addChild(new Blood(_userActions.x - 85, _userActions.y - (_userActions.height / 3)));
		}
		
		/* Смена очередности ударов. */
		private function Exchange():void
		{
			if (_activePlayer == "USER") {
				_activePlayer = "BOT";
				_botBlock = false;
				Match3.fieldBlocked = true;
			} else {
				_activePlayer = "USER";
				_userBlock = false;
				Match3.fieldBlocked = false;
			}
		}
		
		private function onMatch3Events(event:Events):void 
		{
			switch(event.data.id)
			{
				case Match3.ON_AI_MOVE:
				{
					_activePlayer = "BOT";
					trace(Match3.ON_AI_MOVE);
					break;
				}
				
				case Match3.ON_COMPLITE_BUILD_CELLS_UNITS:
				{
					trace(Match3.ON_COMPLITE_BUILD_CELLS_UNITS);
					break;
				}
				
				case Match3.ON_MATCH_GROUP_DEFINED:
				{
					_timer.stop();
					updateFighters();
					trace(Match3.ON_MATCH_GROUP_DEFINED);
					break;
				}
				
				case Match3.ON_MATCH_GROUP_DEFINED_TYPE_1:
				{
					_hitType = Constants.HIT_1;
					trace(Match3.ON_MATCH_GROUP_DEFINED_TYPE_1);
					break;
				}
				
				case Match3.ON_MATCH_GROUP_DEFINED_TYPE_2:
				{
					_hitType = Constants.HIT_2;
					trace(Match3.ON_MATCH_GROUP_DEFINED_TYPE_2);
					break;
				}
				
				case Match3.ON_MATCH_GROUP_DEFINED_TYPE_3:
				{
					_hitType = Constants.HIT_3;
					trace(Match3.ON_MATCH_GROUP_DEFINED_TYPE_3);
					break;
				}
				
				case Match3.ON_MATCH_GROUP_DEFINED_TYPE_4:
				{
					_hitType = Constants.HIT_4;
					trace(Match3.ON_MATCH_GROUP_DEFINED_TYPE_4);
					break;
				}
				
				case Match3.ON_MATCH_GROUP_DEFINED_TYPE_5:
				{
					_hitType = Constants.HIT_5;
					trace(Match3.ON_MATCH_GROUP_DEFINED_TYPE_5);
					break;
				}
				
				case Match3.ON_MOVE_BACK:
				{
					trace(Match3.ON_MOVE_BACK);
					break;
				}
				
				case Match3.ON_MOVE_COMPLITE:
				{
					showFighters();
					_countTimer = 0;
					_timer.start();
					trace(Match3.ON_MOVE_COMPLITE);
					break;
				}
				
				case Match3.ON_UNIT_CLICK:
				{
					trace(Match3.ON_UNIT_CLICK);
					break;
				}
				
				case Match3.ON_UNIT_REMOVE:
				{
					trace(Match3.ON_UNIT_REMOVE);
					break;
				}
				
				case Match3.ON_USER_MOVE:
				{
					_activePlayer = "USER";
					trace(Match3.ON_USER_MOVE);
					break;
				}
				
				default:
				{
					break;
				}
			}
		}
		
		private function clipMask(_sprite:Sprite, _x:int, _y:int, _width:int, _height:int):void
		{
			_sprite.clipRect = new Rectangle(_x, _y, _width, _height);
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
		
		
		private function onButtonsClick(event:Event):void 
		{
			if (Button(event.target).name == Constants.BUTTON_BACK_IN_MENU || Button(event.target).name == Constants.MENU_BUTTON_SATTINGS || Button(event.target).name == Constants.BUTTON_FIGHTER)
			{
				//dispatchEvent(new Navigation(Navigation.CHANGE_SCREEN, true, { id: Button(event.target).name } ));
				updateFighters();
			}
		}
		
		
		
	}

}