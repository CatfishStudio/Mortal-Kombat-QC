package mkcards.game 
{
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
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
	
	import mkcards.vkAPI.VK;
	import mkcards.events.Navigation;
	import mkcards.game.statics.Constants;
	import mkcards.game.statics.Resource;
	import mkcards.game.server.CheckUser;
	import mkcards.game.windows.Preloader;
	import mkcards.game.windows.MessageError;
	
	import mkcards.game.tutorial.Tutorial;
	import mkcards.game.menu.Menu;
	import mkcards.game.side.Side;
	import mkcards.game.server.SaveSide;
	import mkcards.game.fighters.StoreFighters;
	
	/**
	 * ...
	 * @author Catfish Studio Games
	 */
	public class Game extends Sprite 
	{
		
		public function Game() 
		{
			super();
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		private function onAddedToStage(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			addEventListener(Navigation.CHANGE_SCREEN, onChangeScreen);
			
			Starling.current.showStats = true;
			
			showBackground();
			identification();
		}
		
		/* СОБЫТИЯ: основные события показа окон ===============================================*/
		private function onChangeScreen(e:Navigation):void 
		{
			switch(e.data.id)
			{
				// Системные события ---------------------------------------
				case Constants.ON_ERROR_SET_DATA: //ERROR! при загрузки данных
				{
					closeAllWindow();
					addChild(new MessageError("Произошла ошибка при сохранении! \nВозможно проблемы с сервером. \nПриносим вам свои извинения."));
					break;
				}
				
				case Constants.ON_ERROR_GET_DATA: //ERROR! при получении данных
				{
					closeAllWindow();
					addChild(new MessageError("Произошла ошибка при загрузке! \nВозможно проблемы с сервером. \nПриносим вам свои извинения."));
					break;
				}
				//----------------------------------------------------------
				
				// Меню ---------------------------------
				case Constants.MENU_BUTTON_SINGLE_PLAYER: // кнопка меню: Одиночная игра
				{
					break;
				}
				
				case Constants.MENU_BUTTON_CARD_GAME: // кнопка меню: Карточная игра
				{
					break;
				}
				
				case Constants.MENU_BUTTON_STORE: // кнопка меню: Магазин
				{
					break;
				}
				
				case Constants.MENU_BUTTON_PERSONAGE: // кнопка меню: Персонаж
				{
					break;
				}
				
				case Constants.MENU_BUTTON_RATING: // кнопка меню: Рейтинг
				{
					break;
				}
				
				case Constants.MENU_BUTTON_SATTINGS: // кнопка меню: Настройки
				{
					break;
				}
				
				case Constants.MENU_BUTTON_INVATE: // кнопка меню: Пригласить
				{
					break;
				}
				//----------------------------------------------------------
				
				// Выбор стороны -------------------------------------------
				case Constants.WINDOW_SIDE_SHOW: // показать окно выбора
				{
					side();
					break;
				}
				
				case Constants.WINDOW_SIDE_CLOSE: // закрыть окно выбора
				{
					side();
					menu();
					break;
				}
				
				case Constants.WINDOW_SAVE_SIDE: // окно сохраения выбранной стороны
				{
					side();
					saveSide();
					break;
				}
				
				case Constants.ON_SAVE_SIDE_COMPLETE: // сохранение стороны выполнено
				{
					if (Resource.tutorialStep == 0)
					{
						saveSide(); // закрыть
						menu();		// октыть
					}else {
						Resource.tutorialStep = 2;
						saveSide();		// закрыть
						storeFighters();// открыть
						tutorShow(Resource.tutorialStep);
					}
					break;
				}
				//----------------------------------------------------------
				
				
				// Проверка пользователя. Загрузка данных ------------------
				case Constants.ON_CHECK_USER_COMPLETE: //Проверка пользователя успешно выполнена
				{
					closeAllWindow();
					if (Resource.userSide == "") // сторона не выбрана
					{
						Resource.tutorialStep = 1;
						side();
						tutorShow(Resource.tutorialStep);
					}
					else
					{
						if (Resource.userSelectFighter == -1) // нет героя и калоды
						{
							Resource.tutorialStep = 2;
							storeFighters();
							tutorShow(Resource.tutorialStep);
						}else{
							menu();
						}
					}
					break;
				}
				//----------------------------------------------------------
				
				
				default:
				{
					break;
				}
			}
		}
		/*======================================================================================*/
		
		private function closeAllWindow():void
		{
			if (getChildByName(Constants.WINDOW_STORE_FIGHTERS) != null) removeChild(getChildByName(Constants.WINDOW_STORE_FIGHTERS));
			if (getChildByName(Constants.WINDOW_MENU) != null) removeChild(getChildByName(Constants.WINDOW_MENU));
			if (getChildByName(Constants.WINDOW_CHECK_USER) != null) removeChild(getChildByName(Constants.WINDOW_CHECK_USER));
			if (getChildByName(Constants.WINDOW_SIDE) != null) removeChild(getChildByName(Constants.WINDOW_SIDE));
			if (getChildByName(Constants.TUTORIAL) != null)	removeChild(getChildByName(Constants.TUTORIAL));
			
		}
		
		private function showBackground():void
		{
			var bitmap:Bitmap = new Resource.TextureBackgroundGame1();
			var image:Image = new Image(Texture.fromBitmap(bitmap));
			
			addChild(image);
			
			bitmap = null;
			image.dispose();
			image = null;
		}
		
		private function identification():void
		{
			if (Resource.userID == null)
			{
				var data:Array = [];
				data = VK.getUserID();
				
				if (data != null)
				{
					checkUser(data);
				}else {
					//ERROR!
					closeAllWindow();
					addChild(new MessageError("Пользователь не идентивицирован! \nЗапустите игру в социальной сети."));
				}
			}
					
		}
		
		private function checkUser(data:Array):void
		{
			if (getChildByName(Constants.WINDOW_CHECK_USER) != null)
			{
				removeChild(getChildByName(Constants.WINDOW_CHECK_USER));
			}
			else 
			{
				closeAllWindow();
				addChild(new CheckUser(data));
			}
		}
		
		private function preloader():void
		{
			if (getChildByName(Constants.WINDOW_PRELOADER) != null)
			{
				removeChild(getChildByName(Constants.WINDOW_PRELOADER));
			}
			else 
			{
				closeAllWindow();
				addChild(new Preloader());
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
				removeChild(getChildByName(Constants.TUTORIAL));
			}
		}
		
		
		
		private function menu():void
		{
			if (getChildByName(Constants.WINDOW_MENU) != null)
			{
				removeChild(getChildByName(Constants.WINDOW_MENU));
			}
			else 
			{
				closeAllWindow();
				addChild(new Menu());
			}
		}
		
		private function side():void
		{
			if (getChildByName(Constants.WINDOW_SIDE) != null)
			{
				removeChild(getChildByName(Constants.WINDOW_SIDE));
			}
			else 
			{
				closeAllWindow();
				addChild(new Side());
			}
		}
		
		private function saveSide():void
		{
			if (getChildByName(Constants.WINDOW_SAVE_SIDE) != null)
			{
				removeChild(getChildByName(Constants.WINDOW_SAVE_SIDE));
			}
			else 
			{
				closeAllWindow();
				addChild(new SaveSide());
			}
		}
		
		private function storeFighters():void
		{
			if (getChildByName(Constants.WINDOW_STORE_FIGHTERS) != null)
			{
				removeChild(getChildByName(Constants.WINDOW_STORE_FIGHTERS));
			}
			else 
			{
				closeAllWindow();
				addChild(new StoreFighters());
			}
		}
		
		
	}

}