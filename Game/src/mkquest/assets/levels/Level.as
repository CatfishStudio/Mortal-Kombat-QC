package mkquest.assets.levels 
{
	import flash.system.*;
	import flash.display.InteractiveObject;
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
	import mkquest.assets.levels.Indicator;
	import mkquest.assets.animation.PointsDamage;
	import mkquest.assets.sounds.MusicAndSound;
	
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
		
		private var _userLifeBar:Indicator;
		private var _userLife:int;
		private var _botLifeBar:Indicator;
		private var _botLife:int;
		
		private var _endBattle:Boolean = false;
		
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
			
			Resource.totalPointsPlayerLevel = 0;
			createWindow();					// Создание окна уровня
			createButtonsPanelFromXML();	// Создание кнопок меню
			_timer.start();					// Запуск таймера
			MusicAndSound.PlaySound(MusicAndSound.Sound5);
		}
		
		private function onRemoveStage(e:Event):void
		{
			_timer.stop();
			
			while (this.numChildren)
			{
				//this.removeChildAt(0, true);
				this.removeChildren(0, -1, true);
			}
			
			super.dispose();
			System.gc();
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
			
			/* Индикаторы жизни бойцов */
			Resource.user_life = Resource.ai_enemies[Resource.tournamentProgress].aiLife;
			_userLife = Resource.user_life;
			_userLifeBar = new Indicator(Constants.LEFT_TO_RIGHT, Resource.user_name);
			_window.addChild(_userLifeBar);
			_botLife = Resource.ai_enemies[Resource.tournamentProgress].aiLife;
			_botLifeBar = new Indicator(Constants.RIGHT_TO_LEFT, Resource.ai_enemies[Resource.tournamentProgress].aiName);
			_window.addChild(_botLifeBar);
			
			/* Рамка окна */
			_image = new Image(Resource.textureAtlas.getTexture(_fileXML.Border));
			_window.addChild(_image);
			
			/* Бойцы (анимация) */
			showFighters();
			
			/* Построение игрового поля и объектов игрового поля */
			Match3.modeAI = true;
			Match3.fieldBlocked = false;
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
		
		public function timerPause(status:Boolean):void
		{
			if (status == true) _timer.stop();
			if (status == false) _timer.start();
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
					if (_botBlock == false)
					{
						MusicAndSound.PlaySound(MusicAndSound.Sound6);
						if (Resource.user_name != Constants.KITANA && Resource.user_name != Constants.MILEENA) MusicAndSound.PlaySound(MusicAndSound.Sound11);
						else MusicAndSound.PlaySound(MusicAndSound.Sound2);
						
						if (Resource.ai_enemies[Resource.tournamentProgress].aiName != Constants.KITANA && Resource.ai_enemies[Resource.tournamentProgress].aiName != Constants.MILEENA) MusicAndSound.PlaySound(MusicAndSound.Sound13);
						else MusicAndSound.PlaySound(MusicAndSound.Sound4);
						
						_botActions = new Actions(0, 0, false, Resource.ai_enemies[Resource.tournamentProgress].aiName, Constants.DAMAGE, Constants.RIGHT_TO_LEFT);
					}
					else
					{
						MusicAndSound.PlaySound(MusicAndSound.Sound8);
						_botActions = new Actions(0, 0, false, Resource.ai_enemies[Resource.tournamentProgress].aiName, Constants.HIT_3, Constants.RIGHT_TO_LEFT);
					}
				}
				if (_hitType == Constants.HIT_2)
				{
					_userActions = new Actions(0, 0, false, Resource.user_name, Constants.HIT_2, Constants.LEFT_TO_RIGHT);
					if (_botBlock == false)
					{
						MusicAndSound.PlaySound(MusicAndSound.Sound7);
						
						MusicAndSound.PlaySound(MusicAndSound.Sound6);
						if (Resource.user_name != Constants.KITANA && Resource.user_name != Constants.MILEENA) MusicAndSound.PlaySound(MusicAndSound.Sound12);
						else MusicAndSound.PlaySound(MusicAndSound.Sound3);
						
						if (Resource.ai_enemies[Resource.tournamentProgress].aiName != Constants.KITANA && Resource.ai_enemies[Resource.tournamentProgress].aiName != Constants.MILEENA) MusicAndSound.PlaySound(MusicAndSound.Sound13);
						else MusicAndSound.PlaySound(MusicAndSound.Sound4);
						
						_botActions = new Actions(0, 0, false, Resource.ai_enemies[Resource.tournamentProgress].aiName, Constants.DAMAGE, Constants.RIGHT_TO_LEFT);
					}
					else
					{
						MusicAndSound.PlaySound(MusicAndSound.Sound8);
						_botActions = new Actions(0, 0, false, Resource.ai_enemies[Resource.tournamentProgress].aiName, Constants.HIT_3, Constants.RIGHT_TO_LEFT);
					}
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
					if (_botBlock == false) 
					{
						MusicAndSound.PlaySound(MusicAndSound.Sound7);
						
						if (Resource.user_name != Constants.KITANA && Resource.user_name != Constants.MILEENA) MusicAndSound.PlaySound(MusicAndSound.Sound12);
						else MusicAndSound.PlaySound(MusicAndSound.Sound3);
						
						if (Resource.ai_enemies[Resource.tournamentProgress].aiName != Constants.KITANA && Resource.ai_enemies[Resource.tournamentProgress].aiName != Constants.MILEENA) MusicAndSound.PlaySound(MusicAndSound.Sound13);
						else MusicAndSound.PlaySound(MusicAndSound.Sound4);
						
						_botActions = new Actions(0, 0, false, Resource.ai_enemies[Resource.tournamentProgress].aiName, Constants.DAMAGE, Constants.RIGHT_TO_LEFT);
					}
					else 
					{
						MusicAndSound.PlaySound(MusicAndSound.Sound8);
						_botActions = new Actions(0, 0, false, Resource.ai_enemies[Resource.tournamentProgress].aiName, Constants.HIT_3, Constants.RIGHT_TO_LEFT);
					}
				}
				if (_hitType == Constants.HIT_5)
				{
					_userActions = new Actions(0, 0, false, Resource.user_name, Constants.HIT_5, Constants.LEFT_TO_RIGHT);
					if (_botBlock == false) 
					{
						MusicAndSound.PlaySound(MusicAndSound.Sound6);
						
						if (Resource.user_name != Constants.KITANA && Resource.user_name != Constants.MILEENA) MusicAndSound.PlaySound(MusicAndSound.Sound11);
						else MusicAndSound.PlaySound(MusicAndSound.Sound2);
						
						if (Resource.ai_enemies[Resource.tournamentProgress].aiName != Constants.KITANA && Resource.ai_enemies[Resource.tournamentProgress].aiName != Constants.MILEENA) MusicAndSound.PlaySound(MusicAndSound.Sound13);
						else MusicAndSound.PlaySound(MusicAndSound.Sound4);
						
						_botActions = new Actions(0, 0, false, Resource.ai_enemies[Resource.tournamentProgress].aiName, Constants.DAMAGE, Constants.RIGHT_TO_LEFT);
					}
					else 
					{
						MusicAndSound.PlaySound(MusicAndSound.Sound8);
						_botActions = new Actions(0, 0, false, Resource.ai_enemies[Resource.tournamentProgress].aiName, Constants.HIT_3, Constants.RIGHT_TO_LEFT);
					}
				}
			}
			else // BOT
			{
				if (_hitType == Constants.HIT_1)
				{
					_botActions = new Actions(0, 0, false, Resource.ai_enemies[Resource.tournamentProgress].aiName, Constants.HIT_1, Constants.RIGHT_TO_LEFT);
					if (_userBlock == false) 
					{
						MusicAndSound.PlaySound(MusicAndSound.Sound6);
						
						if (Resource.ai_enemies[Resource.tournamentProgress].aiName != Constants.KITANA && Resource.ai_enemies[Resource.tournamentProgress].aiName != Constants.MILEENA) MusicAndSound.PlaySound(MusicAndSound.Sound11);
						else MusicAndSound.PlaySound(MusicAndSound.Sound2);
						
						if (Resource.user_name != Constants.KITANA && Resource.user_name != Constants.MILEENA) MusicAndSound.PlaySound(MusicAndSound.Sound13);
						else MusicAndSound.PlaySound(MusicAndSound.Sound4);
						
						_userActions = new Actions(0, 0, false, Resource.user_name, Constants.DAMAGE, Constants.LEFT_TO_RIGHT);
					}
					else
					{
						MusicAndSound.PlaySound(MusicAndSound.Sound8);
						_userActions = new Actions(0, 0, false, Resource.user_name, Constants.HIT_3, Constants.LEFT_TO_RIGHT);
					}
				}
				if (_hitType == Constants.HIT_2)
				{
					_botActions = new Actions(0, 0, false, Resource.ai_enemies[Resource.tournamentProgress].aiName, Constants.HIT_2, Constants.RIGHT_TO_LEFT);
					if (_userBlock == false) 
					{
						MusicAndSound.PlaySound(MusicAndSound.Sound7);
						
						if (Resource.ai_enemies[Resource.tournamentProgress].aiName != Constants.KITANA && Resource.ai_enemies[Resource.tournamentProgress].aiName != Constants.MILEENA) MusicAndSound.PlaySound(MusicAndSound.Sound12);
						else MusicAndSound.PlaySound(MusicAndSound.Sound3);
						
						if (Resource.user_name != Constants.KITANA && Resource.user_name != Constants.MILEENA) MusicAndSound.PlaySound(MusicAndSound.Sound13);
						else MusicAndSound.PlaySound(MusicAndSound.Sound4);
						
						_userActions = new Actions(0, 0, false, Resource.user_name, Constants.DAMAGE, Constants.LEFT_TO_RIGHT);
					}
					else 
					{
						MusicAndSound.PlaySound(MusicAndSound.Sound8);
						_userActions = new Actions(0, 0, false, Resource.user_name, Constants.HIT_3, Constants.LEFT_TO_RIGHT);
					}
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
					if (_userBlock == false) 
					{
						MusicAndSound.PlaySound(MusicAndSound.Sound7);
						
						if (Resource.ai_enemies[Resource.tournamentProgress].aiName != Constants.KITANA && Resource.ai_enemies[Resource.tournamentProgress].aiName != Constants.MILEENA) MusicAndSound.PlaySound(MusicAndSound.Sound12);
						else MusicAndSound.PlaySound(MusicAndSound.Sound3);
						
						if (Resource.user_name != Constants.KITANA && Resource.user_name != Constants.MILEENA) MusicAndSound.PlaySound(MusicAndSound.Sound13);
						else MusicAndSound.PlaySound(MusicAndSound.Sound4);
						
						_userActions = new Actions(0, 0, false, Resource.user_name, Constants.DAMAGE, Constants.LEFT_TO_RIGHT);
					}
					else
					{
						MusicAndSound.PlaySound(MusicAndSound.Sound8);
						_userActions = new Actions(0, 0, false, Resource.user_name, Constants.HIT_3, Constants.LEFT_TO_RIGHT);
					}
				}
				if (_hitType == Constants.HIT_5)
				{
					 _botActions = new Actions(0, 0, false, Resource.ai_enemies[Resource.tournamentProgress].aiName, Constants.HIT_5, Constants.RIGHT_TO_LEFT);
					if (_userBlock == false) 
					{
						MusicAndSound.PlaySound(MusicAndSound.Sound6);
						
						if (Resource.ai_enemies[Resource.tournamentProgress].aiName != Constants.KITANA && Resource.ai_enemies[Resource.tournamentProgress].aiName != Constants.MILEENA) MusicAndSound.PlaySound(MusicAndSound.Sound11);
						else MusicAndSound.PlaySound(MusicAndSound.Sound2);
						
						if (Resource.user_name != Constants.KITANA && Resource.user_name != Constants.MILEENA) MusicAndSound.PlaySound(MusicAndSound.Sound13);
						else MusicAndSound.PlaySound(MusicAndSound.Sound4);
						
						_userActions = new Actions(0, 0, false, Resource.user_name, Constants.DAMAGE, Constants.LEFT_TO_RIGHT);
					}
					else
					{
						MusicAndSound.PlaySound(MusicAndSound.Sound8);
						_userActions = new Actions(0, 0, false, Resource.user_name, Constants.HIT_3, Constants.LEFT_TO_RIGHT);
					}
				}
			}
			
			_userActions.x = (145 - _userActions.width) / 2;
			_userActions.y = Constants.MK_WINDOW_HEIGHT - (_userActions.height + 35);
			_window.addChild(_userActions);
			_botActions.x = (Constants.MK_WINDOW_WIDTH - 145) + ((145 - _botActions.width) / 2);
			_botActions.y = Constants.MK_WINDOW_HEIGHT - (_botActions.height + 35);
			_window.addChild(_botActions);
			
			if (_activePlayer == "USER" && _hitType != Constants.HIT_3 && _botBlock == false) _window.addChild(new Blood(_botActions.x - 50, _botActions.y - (_botActions.height / 4)));
			if (_activePlayer == "BOT" && _hitType != Constants.HIT_3 && _userBlock == false) _window.addChild(new Blood(_userActions.x - 85, _userActions.y - (_userActions.height / 4)));
		}
		
		
		private function winFighter(userWin:Boolean, botWin:Boolean):void
		{
			if (_userActions != null) _window.removeChild(_userActions);
			if (userWin == true)
			{
				MusicAndSound.PlaySound(MusicAndSound.Sound14);
				_userActions = new Actions(0, 0, false, Resource.user_name, Constants.VICTORY, "");
				dispatchEvent(new Navigation(Navigation.CHANGE_SCREEN, true, { id: Constants.WINDOW_VICTORY } ));
				
			}
			if (userWin == false)
			{
				MusicAndSound.PlaySound(MusicAndSound.Sound10);
				_userActions = new Actions(0, 0, true, Resource.user_name, Constants.LOST, "");
				dispatchEvent(new Navigation(Navigation.CHANGE_SCREEN, true, { id: Constants.WINDOW_LOST } ));
			}
			_userActions.x = (145 - _userActions.width) / 2;
			_userActions.y = Constants.MK_WINDOW_HEIGHT - (_userActions.height + 35);
			_window.addChild(_userActions);
			
			if (_botActions != null) _window.removeChild(_botActions);
			if (botWin == true) _botActions = new Actions(0, 0, false, Resource.ai_enemies[Resource.tournamentProgress].aiName, Constants.VICTORY, "");
			if (Resource.ai_enemies[Resource.tournamentProgress].aiName != Constants.GORO && Resource.ai_enemies[Resource.tournamentProgress].aiName != Constants.SHAOKAHN)
			{
				if (botWin == false) _botActions = new Actions(0, 0, true, Resource.ai_enemies[Resource.tournamentProgress].aiName, Constants.LOST, "");
			}
			else
			{
				if (botWin == false) _botActions = new Actions(0, 0, false, Resource.ai_enemies[Resource.tournamentProgress].aiName, Constants.LOST, "");
			}
			_botActions.x = (Constants.MK_WINDOW_WIDTH - 145) + ((145 - _botActions.width) / 2);
			_botActions.y = Constants.MK_WINDOW_HEIGHT - (_botActions.height + 35);
			_window.addChild(_botActions);
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
		
		/* Уменьшение жизни */
		private function reductionLife():void
		{
			var damage:int = 0;
			if (_activePlayer == "USER")
			{
				// ЖизньИИ -= ((ТипУдара * ЭффективностьУдара) - (ТипБлока * ЭффективностьБлока))
				if (_hitType == Constants.HIT_1 && _botBlock == false) damage = (Constants.DAMAGE_HIT_1 * Resource.user_hit_1);
				if (_hitType == Constants.HIT_1 && _botBlock == true) damage = ((Constants.DAMAGE_HIT_1 * Resource.user_hit_1) - (Constants.DAMAGE_HIT_3 * Resource.ai_enemies[Resource.tournamentProgress].aiHit3));
				
				if (_hitType == Constants.HIT_2 && _botBlock == false) damage = (Constants.DAMAGE_HIT_2 * Resource.user_hit_2);
				if (_hitType == Constants.HIT_2 && _botBlock == true) damage = ((Constants.DAMAGE_HIT_2 * Resource.user_hit_2) - (Constants.DAMAGE_HIT_3 * Resource.ai_enemies[Resource.tournamentProgress].aiHit3));
				
				if (_hitType == Constants.HIT_4 && _botBlock == false) damage = (Constants.DAMAGE_HIT_4 * Resource.user_hit_4);
				if (_hitType == Constants.HIT_4 && _botBlock == true) damage = ((Constants.DAMAGE_HIT_4 * Resource.user_hit_4) - (Constants.DAMAGE_HIT_3 * Resource.ai_enemies[Resource.tournamentProgress].aiHit3));
				
				if (_hitType == Constants.HIT_5 && _botBlock == false) damage = (Constants.DAMAGE_HIT_5 * Resource.user_hit_5);
				if (_hitType == Constants.HIT_5 && _botBlock == true) damage = ((Constants.DAMAGE_HIT_5 * Resource.user_hit_5) - (Constants.DAMAGE_HIT_3 * Resource.ai_enemies[Resource.tournamentProgress].aiHit3));
				
				if (damage < 0) damage = 0;
				if (_botBlock == false) _window.addChild(new PointsDamage(700, 300, damage.toString(), 0xFF0000));
				if (_botBlock == true) _window.addChild(new PointsDamage(700, 300, damage.toString(), 0xFFFF00));
				_botLife -= damage;
				_botLifeBar.LifeBar = _botLife / (Resource.ai_enemies[Resource.tournamentProgress].aiLife / 200);
				Resource.totalPointsPlayerLevel += (damage * 10);
			}
			else
			{
				if (_hitType == Constants.HIT_1 && _userBlock == false) damage = (Constants.DAMAGE_HIT_1 * Resource.ai_enemies[Resource.tournamentProgress].aiHit1);
				if (_hitType == Constants.HIT_1 && _userBlock == true) damage = ((Constants.DAMAGE_HIT_1 * Resource.ai_enemies[Resource.tournamentProgress].aiHit1) - (Constants.DAMAGE_HIT_3 * Resource.user_hit_3));
				
				if (_hitType == Constants.HIT_2 && _userBlock == false) damage = (Constants.DAMAGE_HIT_2 * Resource.ai_enemies[Resource.tournamentProgress].aiHit2);
				if (_hitType == Constants.HIT_2 && _userBlock == true) damage = ((Constants.DAMAGE_HIT_2 * Resource.ai_enemies[Resource.tournamentProgress].aiHit2) - (Constants.DAMAGE_HIT_3 * Resource.user_hit_3));
				
				if (_hitType == Constants.HIT_4 && _userBlock == false) damage = (Constants.DAMAGE_HIT_4 * Resource.ai_enemies[Resource.tournamentProgress].aiHit4);
				if (_hitType == Constants.HIT_4 && _userBlock == true) damage = ((Constants.DAMAGE_HIT_4 * Resource.ai_enemies[Resource.tournamentProgress].aiHit4) - (Constants.DAMAGE_HIT_3 * Resource.user_hit_3));
				
				if (_hitType == Constants.HIT_5 && _userBlock == false) damage = (Constants.DAMAGE_HIT_5 * Resource.ai_enemies[Resource.tournamentProgress].aiHit5);
				if (_hitType == Constants.HIT_5 && _userBlock == true) damage = ((Constants.DAMAGE_HIT_5 * Resource.ai_enemies[Resource.tournamentProgress].aiHit5) - (Constants.DAMAGE_HIT_3 * Resource.user_hit_3));
				
				if (damage < 0) damage = 0;
				if (_userBlock == false) _window.addChild(new PointsDamage(20, 300, damage.toString(), 0xFF0000));
				if (_userBlock == true) _window.addChild(new PointsDamage(20, 300, damage.toString(), 0xFFFF00));
				_userLife -= damage;
				_userLifeBar.LifeBar = _userLife / (Resource.user_life / 200);
			}
		}
		
		
		private function onMatch3Events(event:Events):void 
		{
			switch(event.data.id)
			{
				case Match3.ON_AI_MOVE:
				{
					_activePlayer = "BOT";
					MusicAndSound.PlaySound(MusicAndSound.Sound9);
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
					reductionLife();
					trace(Match3.ON_MATCH_GROUP_DEFINED_TYPE_1);
					break;
				}
				
				case Match3.ON_MATCH_GROUP_DEFINED_TYPE_2:
				{
					_hitType = Constants.HIT_2;
					reductionLife();
					trace(Match3.ON_MATCH_GROUP_DEFINED_TYPE_2);
					break;
				}
				
				case Match3.ON_MATCH_GROUP_DEFINED_TYPE_3:
				{
					_hitType = Constants.HIT_3;
					if (_activePlayer == "USER") 
					{
						_botBlock = false;
					} else {
						_userBlock = false;
					}
					trace(Match3.ON_MATCH_GROUP_DEFINED_TYPE_3);
					break;
				}
				
				case Match3.ON_MATCH_GROUP_DEFINED_TYPE_4:
				{
					_hitType = Constants.HIT_4;
					reductionLife();
					trace(Match3.ON_MATCH_GROUP_DEFINED_TYPE_4);
					break;
				}
				
				case Match3.ON_MATCH_GROUP_DEFINED_TYPE_5:
				{
					_hitType = Constants.HIT_5;
					reductionLife();
					trace(Match3.ON_MATCH_GROUP_DEFINED_TYPE_5);
					break;
				}
				
				case Match3.ON_MOVE_BACK:
				{
					MusicAndSound.PlaySound(MusicAndSound.Sound9);
					trace(Match3.ON_MOVE_BACK);
					break;
				}
				
				case Match3.ON_MOVE_COMPLITE:
				{
					showFighters();
					if (_userLife <= 0)
					{
						if (_endBattle == false)
						{
							winFighter(false, true);
							_endBattle = true;
						}
						trace("{END} AI победил!");
					}
					else
					{
						if (_botLife <= 0)
						{
							if (_endBattle == false)
							{
								winFighter(true, false);
								_endBattle = true;
							}
							trace("{END} User победил!");
						}
						else
						{
							_countTimer = 0;
							_timer.start();
						}
					}
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
					MusicAndSound.PlaySound(MusicAndSound.Sound9);
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
			MusicAndSound.PlaySound(MusicAndSound.Sound1);
			if (Button(event.target).name == Constants.BUTTON_BACK_IN_MENU_LEVEL || Button(event.target).name == Constants.MENU_BUTTON_SATTINGS || Button(event.target).name == Constants.BUTTON_FIGHT_END || Button(event.target).name == Constants.VK_BUTTON_INVITE)
			{
				dispatchEvent(new Navigation(Navigation.CHANGE_SCREEN, true, { id: Button(event.target).name } ));
			}
		}
		
		
		
	}

}