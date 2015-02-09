package mkquest.assets 
{
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.core.Starling;
	
	import mkquest.assets.events.Navigation;
	import mkquest.assets.statics.Constants;
	import mkquest.assets.statics.Resource;
	import mkquest.assets.menu.Menu;
	import mkquest.assets.fighters.Fighters;
	import mkquest.assets.settings.Settings;
	
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
			menu()
		}
		
		
		private function showBackground():void
		{
			Resource.textureAtlas = Resource.getTextureAtlasFromBitmap(Resource.AtlasSpritesGame, Resource.AtlasSpritesGameXML);
			addChild(new Image(Resource.textureAtlas.getTexture("background_game.png")));
		}
		
		private function menu():void
		{
			if (getChildByName(Constants.MENU) != null)
			{
				removeChild(getChildByName(Constants.MENU));
			}
			else 
			{
				addChild(new Menu());
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
				addChild(new Fighters());
			}
		}
		
		private function settings():void
		{
			if (getChildByName(Constants.SETTINGS) != null)
			{
				removeChild(getChildByName(Constants.SETTINGS));
			}
			else
			{
				addChild(new Settings());
			}
		}
		
		
		
		private function onChangeScreen(event:Navigation):void 
		{
			switch(event.data.id)
			{
				case Constants.MENU_BUTTON_TOURNAMENT:
				{
					menu();
					fighters();
					break;
				}
				
				case Constants.MENU_BUTTON_SATTINGS:
				{
					settings();
					break;
				}
				
				case Constants.SETTINGS_BUTTON_APPLY:
				{
					settings();
					break;
				}
				
				case Constants.BUTTON_BACK:
				{
					menu();
					fighters();
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