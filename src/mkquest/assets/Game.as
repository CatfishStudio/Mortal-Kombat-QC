package mkquest.assets 
{
	import flash.display.Bitmap;
	
	import starling.display.Image;
	import starling.textures.Texture;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.core.Starling;
	
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
			
			initGameTextureAtlas();
				
			menu();
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
		
		private function initGameTextureAtlas():void
		{
			Resource.disposeTextureAtlas();
			Resource.setTextureAtlasFromBitmap(Resource.AtlasSpritesGame, Resource.AtlasSpritesGameXML);
		}
		
		private function initLevelTextureAtlas():void
		{
			Resource.disposeTextureAtlas();
			Resource.setTextureAtlasFromBitmap(Resource.AtlasSpritesLevelTextures, Resource.AtlasSpritesLevelTexturesXML);
			//Resource.setTextureAtlasEmbeddedAsset(Resource.AtlasSpritesLevelAnimation, Resource.AtlasSpritesLevelAnimationXML);
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
		
		private function stairs():void
		{
			if (getChildByName(Constants.MK_WINDOW_STAIRS) != null)
			{
				removeChild(getChildByName(Constants.MK_WINDOW_STAIRS));
			}
			else
			{
				addChild(new Stairs());
			}
		}
		
		private function level():void
		{
			if (getChildByName(Constants.MK_WINDOW_LEVEL) != null)
			{
				removeChild(getChildByName(Constants.MK_WINDOW_LEVEL));
				initGameTextureAtlas();
			}
			else
			{
				Resource.levels = Initialization.initLevels(Resource.ClassXMLFileLevel);
				initLevelTextureAtlas();
				addChild(new Level());
			}
		}
		
		private function windowBackMenu(sender:String):void
		{
			if (getChildByName(Constants.WINDOW_BACK_MENU) != null)
			{
				removeChild(getChildByName(Constants.WINDOW_BACK_MENU));
			}
			else
			{
				addChild(new BackMenu(sender));
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
				
				case Constants.BUTTON_BACK_IN_MENU:
				{
					windowBackMenu(Constants.MK_WINDOW_STAIRS);
					break;
				}
				
				case Constants.BUTTON_BACK_IN_MENU_LEVEL:
				{
					windowBackMenu(Constants.MK_WINDOW_LEVEL);
					break;
				}
				
				case Constants.WINDOW_LEVEL_BACK_MENU:
				{
					windowBackMenu(null);
					level();
					menu();
					Resource.clearUser();
					Resource.clearAI();
					break;
				}
				
				case Constants.WINDOW_BACK_MENU_CLOSE:
				{
					windowBackMenu(null);
					break;
				}
				
				case Constants.WINDOW_STAIRS_BACK_MENU:
				{
					windowBackMenu(null);
					stairs();
					menu();
					Resource.clearUser();
					Resource.clearAI();
					break;
				}
				
				case Constants.BUTTON_PLAY:
				{
					fighters();
					stairs();
					break;
				}
				
				case Constants.BUTTON_FIGHT:
				{
					stairs();
					level();
					break;
				}
				
				case Constants.BUTTON_FIGHT_END:
				{
					level();
					stairs();
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