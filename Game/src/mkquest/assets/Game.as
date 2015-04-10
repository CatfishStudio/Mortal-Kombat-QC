package mkquest.assets 
{
	import flash.display.Bitmap;
	import flash.display.StageDisplayState;
	
	import starling.display.Image;
	import starling.display.Button;
	import starling.textures.Texture;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.core.Starling;
	
	import mkquest.assets.sounds.MusicAndSound;
	import mkquest.assets.events.Navigation;
	import mkquest.assets.statics.Constants;
	import mkquest.assets.statics.Resource;
	import mkquest.assets.initialization.Initialization;
	import mkquest.assets.menu.Menu;
	import mkquest.assets.fighters.Fighters;
	import mkquest.assets.settings.Settings;
	import mkquest.assets.stairs.Stairs;
	import mkquest.assets.levels.Level;
	import mkquest.assets.windows.BackMenu;
	import mkquest.assets.windows.BackStairs;
	import mkquest.assets.windows.EndedLife;
	import mkquest.assets.windows.Lost;
	import mkquest.assets.windows.Victory;
	import mkquest.assets.tutorial.Tutorial;
	import mkquest.assets.vkAPI.VK;
	
	public class Game extends Sprite 
	{
		private var _level:Level;
		
		public function Game() 
		{
			super();
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		private function onAddedToStage(event:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			addEventListener(Navigation.CHANGE_SCREEN, onChangeScreen);
			
			//Starling.current.showStats = true;
			
			showBackground();
			
			//showButtonFullscreen();
			
			initGameTextureAtlas();
				
			menu();
			
			tutorShow(Resource.tutorialStep);
		}
		
		
		
		private function showBackground():void
		{
			var bitmap:Bitmap = new Resource.TextureBackgroundGame();
			var image:Image = new Image(Texture.fromBitmap(bitmap));
			
			addChild(image);
			
			bitmap = null;
			image.dispose();
			image = null;
		}
		
		private function showButtonFullscreen():void
		{
			var bitmap:Bitmap = new Resource.TextureButtonFullscreen();
			var buttonFullscreen:Button = new Button(Texture.fromBitmap(bitmap));
			buttonFullscreen.addEventListener(TouchEvent.TOUCH, onFullscreenTouch);
			addChild(buttonFullscreen);
			
			bitmap = null;
		}
		
		private function onFullscreenTouch(e:TouchEvent):void 
		{
			var touch:Touch = e.getTouch(stage);
			if (touch)
			{
				if (touch.phase == TouchPhase.BEGAN)
				{
					if (Starling.current.nativeStage.displayState == StageDisplayState.NORMAL)
					{
						Starling.current.nativeStage.displayState = StageDisplayState.FULL_SCREEN;
					}else {
						Starling.current.nativeStage.displayState = StageDisplayState.NORMAL;
					}
				}
			}
		}
		
		private function initGameTextureAtlas():void
		{
			MusicAndSound.StopMusic();
			MusicAndSound.MusicInit(MusicAndSound.Music2);
			MusicAndSound.PlayMusic();
			
			Resource.disposeTextureAtlas();
			Resource.setTextureAtlasFromBitmap(Resource.AtlasSpritesGame, Resource.AtlasSpritesGameXML);
		}
		
		private function initLevelTextureAtlas():void
		{
			MusicAndSound.StopMusic();
			if (MusicAndSound.melodyIndex == 0) {
				MusicAndSound.MusicInit(MusicAndSound.Music1);
				MusicAndSound.melodyIndex = 1;
			}else{
				MusicAndSound.MusicInit(MusicAndSound.Music3);
				MusicAndSound.melodyIndex = 0;
			}
			
			MusicAndSound.PlayMusic();
			
			Resource.disposeTextureAtlas();
			Resource.setTextureAtlasFromBitmap(Resource.AtlasSpritesLevelTextures, Resource.AtlasSpritesLevelTexturesXML);
		}
		
		private function menu():void
		{
			if (getChildByName(Constants.MENU) != null)
			{
				removeChild(getChildByName(Constants.MENU));
			}
			else 
			{
				windowAllClose();
				addChild(new Menu());
			}
		}
		
		private function tutorShow(step:int):void
		{
			addChild(new Tutorial(step));
		}
		
		private function tutorClose():void
		{
			if (getChildByName(Constants.TUTORIAL) != null)
			{
				Resource.tutorialStep++;
				removeChild(getChildByName(Constants.TUTORIAL));
			}
		}
		
		private function fighters():void
		{
			if (getChildByName(Constants.FIGHTERS) != null)
			{
				removeChild(getChildByName(Constants.FIGHTERS));
			}
			else
			{
				windowAllClose();
				Resource.levels = Initialization.initLevels(Resource.ClassXMLFileLevel);
				addChild(new Fighters());
			}
		}
		
		private function settings():void
		{
			if (getChildByName(Constants.SETTINGS) != null)
			{
				removeChild(getChildByName(Constants.SETTINGS));
				if (getChildByName(Constants.MK_WINDOW_LEVEL)) _level.timerPause(false);
			}
			else
			{
				if (getChildByName(Constants.MK_WINDOW_LEVEL)) _level.timerPause(true);
				addChild(new Settings());
			}
		}
		
		private function stairs():void
		{
			if (getChildByName(Constants.MK_WINDOW_STAIRS) != null)
			{
				removeChild(getChildByName(Constants.MK_WINDOW_STAIRS));
			}
			else
			{
				windowAllClose();
				addChild(new Stairs());
			}
		}
		
		private function level():void
		{
			if (getChildByName(Constants.MK_WINDOW_LEVEL) != null)
			{
				removeChild(_level);
				initGameTextureAtlas();
			}
			else
			{
				initLevelTextureAtlas();
				_level = new Level();
				addChild(_level);
			}
		}
		
		private function windowBackMenu(sender:String):void
		{
			if (getChildByName(Constants.WINDOW_BACK_MENU) != null)
			{
				removeChild(getChildByName(Constants.WINDOW_BACK_MENU));
				if (getChildByName(Constants.MK_WINDOW_LEVEL)) _level.timerPause(false);
			}
			else
			{
				if (sender == Constants.MK_WINDOW_LEVEL) _level.timerPause(true);
				addChild(new BackMenu(sender));
			}
		}
		
		private function windowBackStairs():void
		{
			if (getChildByName(Constants.WINDOW_BACK_STAIRS) != null)
			{
				removeChild(getChildByName(Constants.WINDOW_BACK_STAIRS));
				if (getChildByName(Constants.MK_WINDOW_LEVEL)) _level.timerPause(false);
			}
			else
			{
				if (getChildByName(Constants.MK_WINDOW_LEVEL)) _level.timerPause(true);
				addChild(new BackStairs());
			}
		}
		
		private function windowEndedLife():void
		{
			if (getChildByName(Constants.WINDOW_ENDED_LIFE) != null)
			{
				removeChild(getChildByName(Constants.WINDOW_ENDED_LIFE));
			}
			else
			{
				addChild(new EndedLife());
			}
		}
		
		private function windowLost():void
		{
			if (getChildByName(Constants.WINDOW_LOST) != null)
			{
				removeChild(getChildByName(Constants.WINDOW_LOST));
			}
			else
			{
				addChild(new Lost());
			}
		}
		
		private function windowVictory():void
		{
			if (getChildByName(Constants.WINDOW_VICTORY) != null)
			{
				removeChild(getChildByName(Constants.WINDOW_VICTORY));
			}
			else
			{
				addChild(new Victory());
			}
		}
		
		private function windowAllClose():void
		{
			if (getChildByName(Constants.WINDOW_BACK_MENU) != null)	removeChild(getChildByName(Constants.WINDOW_BACK_MENU));
			if (getChildByName(Constants.WINDOW_BACK_STAIRS) != null) removeChild(getChildByName(Constants.WINDOW_BACK_STAIRS));
			if (getChildByName(Constants.WINDOW_ENDED_LIFE) != null)removeChild(getChildByName(Constants.WINDOW_ENDED_LIFE));
			if (getChildByName(Constants.WINDOW_LOST) != null)	removeChild(getChildByName(Constants.WINDOW_LOST));
			if (getChildByName(Constants.WINDOW_VICTORY) != null) removeChild(getChildByName(Constants.WINDOW_VICTORY));
			if (getChildByName(Constants.SETTINGS) != null) removeChild(getChildByName(Constants.SETTINGS));
		}
		
		
		private function onChangeScreen(event:Navigation):void 
		{
			switch(event.data.id)
			{
				case Constants.MENU_BUTTON_TOURNAMENT: // кнопка начать турнир
				{
					tutorClose();
					menu();
					fighters();
					if (Resource.tutorialStep == 2) tutorShow(Resource.tutorialStep);
					break;
				}
				
				case Constants.MENU_BUTTON_SATTINGS: // кнопка открыть окно настроек
				{
					settings();
					break;
				}
				
				case Constants.SETTINGS_BUTTON_APPLY: // кнопка закрыть окно настроек
				{
					settings();
					break;
				}
				
				case Constants.BUTTON_BACK: // кнопка назад (из выбора персонажа в меню)
				{
					menu();
					fighters();
					break;
				}
				
				case Constants.BUTTON_BACK_IN_MENU: // кнопка обратно в меню в окне соперников (открывается окно подтверждения)
				{
					windowBackMenu(Constants.MK_WINDOW_STAIRS);
					break;
				}
				
				case Constants.BUTTON_BACK_IN_MENU_LEVEL: // кнопка обратно в меню в окне уровня (открывается окно подтверждения)
				{
					windowBackMenu(Constants.MK_WINDOW_LEVEL);
					break;
				}
				
				case Constants.WINDOW_LEVEL_BACK_MENU: // подтверждение возврата в меню из уровня в окне подтверждения
				{
					windowBackMenu(null);
					level();
					menu();
					Resource.clearUser();
					Resource.clearAI();
					break;
				}
				
				case Constants.WINDOW_STAIRS_BACK_MENU: // подтверждение возврата в меню из соперников в окне подтверждения
				{
					windowBackMenu(null);
					stairs();
					menu();
					Resource.clearUser();
					Resource.clearAI();
					break;
				}
				
				case Constants.WINDOW_BACK_MENU_CLOSE: // закрыть окно подтверждения возврата в меню
				{
					windowBackMenu(null);
					break;
				}
				
				
				case Constants.BUTTON_PLAY: // начать игру
				{
					tutorClose();
					fighters();
					stairs();
					if (Resource.tutorialStep == 3) tutorShow(Resource.tutorialStep);
					break;
				}
				
				case Constants.BUTTON_FIGHT: // начать битву
				{
					tutorClose();
					stairs();
					level();
					break;
				}
				
				case Constants.BUTTON_FIGHT_END: // завершить битву
				{
					windowBackStairs();
					break;
				}
				
				case Constants.WINDOW_LEVEL_BACK_STAIRS: // завершить битву
				{
					windowBackStairs();
					level();
					stairs();
					break;
				}
				
				case Constants.WINDOW_BACK_STAIRS_CLOSE: // завершить битву
				{
					windowBackStairs();
					break;
				}
				
				case Constants.WINDOW_ENDED_LIFE_SHOW: // Окно завершились жизни
				{
					windowEndedLife();
					if (Resource.tutorialStep == 5 || Resource.tutorialStep == 6) tutorShow(6);
					break;
				}
				
				case Constants.WINDOW_ENDED_LIFE_STAIRS_BACK_MENU: // Окно завершились жизни
				{
					tutorClose();
					windowEndedLife();
					stairs();
					menu();
					Resource.clearUser();
					Resource.clearAI();
					break;
				}
				
				case Constants.WINDOW_ENDED_LIFE_INVITE_FRIENDS: // Позвать друга из окна завершения жизни
				{
					tutorClose();
					windowEndedLife();
					Resource.user_continue++;
					// VK
					VK.vkConnection.callMethod("showInviteBox");
					break;
				}
				
				case Constants.VK_BUTTON_INVITE: // Позвать друга
				{
					// VK
					VK.vkConnection.callMethod("showInviteBox");
					break;
				}
				
				case Constants.WINDOW_LOST: // Битва проиграна показываем окно
				{
					windowLost();
					break;
				}
				
				case Constants.WINDOW_LOST_BACK_MENU: // Битва проиграна возвращаемся в основное меню
				{
					windowLost();
					level();
					menu();
					Resource.clearUser();
					Resource.clearAI();
					break;
				}
				
				case Constants.WINDOW_LOST_BACK_STAIRS: // Битва проиграна нажали "продолжить"
				{
					windowLost();
					level();
					stairs();
					break;
				}
				
				case Constants.WINDOW_VICTORY: // Битва выиграна показываем окно
				{
					windowVictory();
					break;
				}
				
				case Constants.WINDOW_VICTORY_POST: // Битва выиграна постинг на стену
				{
					// VK
					if (Resource.tournamentProgress > 0 ) {
						VK.vkConnection.api('wall.post', { message: 'Mortal Kombat Quest. \nЯ победил ' + (Resource.getfFighterName(Resource.ai_enemies[Resource.tournamentProgress].aiName)) + ' в смертельной битве! \nНабрал ' + Resource.totalPointsPlayerLevel.toString() + ' очков за раунд. \nПрисоединяйтесь к игре https://vk.com/app4759608', attachments : 'photo-62618339_357271831' } , function(data) {} , function(data) {} );
					}else {
						VK.vkConnection.api('wall.post', { message: 'Mortal Kombat Quest. \nЯ победил ' + (Resource.getfFighterName(Resource.ai_enemies[Resource.tournamentProgress].aiName)) + ' в смертельной битве и выиграл турнир! \nНабрал ' + Resource.totalPointsPlayerTournament.toString() + ' очков за весь турнир. \nПрисоединяйтесь к игре https://vk.com/app4759608', attachments : 'photo-62618339_357271831' } , function(data) {} , function(data) {} );
					}
					break;
				}
				
				case Constants.WINDOW_VICTORY_NEXT: // Битва выиграна продолжить
				{
					windowVictory();
					level();
					stairs();
					if (Resource.tournamentProgress == 11 && Resource.tutorialStep == 5) tutorShow(Resource.tutorialStep);
					break;
				}
				
				case Constants.GAME_END: // Игра завершена
				{
					stairs();
					menu();
					break;
				}
				
				case Constants.TUTORIAL_CLOSE: // кнопка начать турнир
				{
					tutorClose();
					break;
				}
				
				default:
				{
					break;
				}

			}
		}
		
	}

}