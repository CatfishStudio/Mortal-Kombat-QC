package mkcards.assets 
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
	
	import mkcards.assets.events.Navigation;
	import mkcards.assets.statics.Constants;
	import mkcards.assets.statics.Resource;
	
	import mkcards.assets.menu.Menu;
	import mkcards.assets.window.SelectSide;
	
	public class Game extends Sprite 
	{
		public function Game() 
		{
			super();
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		private function onAddedToStage(event:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			addEventListener(Navigation.CHANGE_SCREEN, onChangeScreen);
			
			Starling.current.showStats = true;
			
			showBackground();
			
			userInitialization();
			
			if (Resource.userID != null) menu();
			else selectSide();
		}
		
		private function onChangeScreen(event:Navigation):void 
		{
			switch(event.data.id)
			{
				case Constants.MENU_BUTTON_SINGLE_PLAYER: // кнопка меню
				{
					break;
				}
				
				case Constants.WINDOW_SELECT_SIDE_BUTTON_OK: // сделан выбор пользователя: свет или тьма
				{
					selectSide(); 	// закрываем
					menu(); 		// открываем
					break;
				}
				
				default:
				{
					break;
				}

			}
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
		
		private function userInitialization():void 
		{
			Resource.userID = null;
			Resource.userName = null;
			Resource.userNickName = null;
			Resource.userSide = "DARK";
		}
		
		private function windowAllClose():void
		{
			if (getChildByName(Constants.WINDOW_SELECT_SIDE) != null)	removeChild(getChildByName(Constants.WINDOW_SELECT_SIDE));
			//if (getChildByName(Constants.WINDOW_BACK_MENU) != null)	removeChild(getChildByName(Constants.WINDOW_BACK_MENU));
			//if (getChildByName(Constants.WINDOW_BACK_STAIRS) != null) removeChild(getChildByName(Constants.WINDOW_BACK_STAIRS));
			//if (getChildByName(Constants.WINDOW_ENDED_LIFE) != null)removeChild(getChildByName(Constants.WINDOW_ENDED_LIFE));
			//if (getChildByName(Constants.WINDOW_LOST) != null)	removeChild(getChildByName(Constants.WINDOW_LOST));
			//if (getChildByName(Constants.WINDOW_VICTORY) != null) removeChild(getChildByName(Constants.WINDOW_VICTORY));
			//if (getChildByName(Constants.WINDOW_END_GAME) != null) removeChild(getChildByName(Constants.WINDOW_END_GAME));
			//if (getChildByName(Constants.SETTINGS) != null) removeChild(getChildByName(Constants.SETTINGS));
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
		
		private function selectSide():void
		{
			if (getChildByName(Constants.WINDOW_SELECT_SIDE) != null)
			{
				removeChild(getChildByName(Constants.WINDOW_SELECT_SIDE));
			}
			else 
			{
				windowAllClose();
				addChild(new SelectSide());
			}
		}
		
	}

}