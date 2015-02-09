package mkquest.assets.menu 
{
	import flash.utils.ByteArray;
	import starling.display.Sprite;
	import starling.display.Button;
	import starling.events.Event;
	import starling.textures.Texture;
	
	import mkquest.assets.events.Navigation;
	import mkquest.assets.statics.Constants;
	import mkquest.assets.statics.Resource;
	import mkquest.assets.xml.FileXML;
	
	public class Menu extends Sprite 
	{
		[Embed(source = 'Menu.xml', mimeType='application/octet-stream')]
		private var ClassFileXML:Class;
		private var _fileXML:XML = FileXML.getFileXML(ClassFileXML);
		private var _button:Button;
		
		public function Menu() 
		{
			super();
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			addEventListener(Event.REMOVED_FROM_STAGE, onRemoveFromStage);
		}
		
		private function onAddedToStage(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			
			name = Constants.MENU;
			x = Constants.GAME_WINDOW_WIDTH / 2.5;
			y = Constants.GAME_WINDOW_HEIGHT / 2.5;
			
			addEventListener(Event.TRIGGERED, onButtonsClick);
			createPanelButtonsFromXML();
		}
		
		private function createPanelButtonsFromXML():void
		{
			Resource.textureAtlas = Resource.getTextureAtlasFromBitmap(Resource.AtlasSpritesGame, Resource.AtlasSpritesGameXML);
						
			var n:int = _fileXML.Button.length();
			for (var i:int = 0; i < n; i++)
			{
				_button = new Button(Resource.textureAtlas.getTexture(_fileXML.Button[i].Texture));
				_button.name = _fileXML.Button[i].Name;
				if (Resource.languageRus == true)
				{
					_button.text = _fileXML.Button[i].TextRus;
				}
				else 
				{
					_button.text = _fileXML.Button[i].TextEng;
				}
				_button.fontName = _fileXML.Button[i].FontName;
				_button.fontColor = _fileXML.Button[i].FontColor;
				_button.fontSize = _fileXML.Button[i].FontSize;
				_button.y = _button.height * i;
				addChild(_button);
			}
		}
		
		private function onButtonsClick(event:Event):void 
		{
			dispatchEvent(new Navigation(Navigation.CHANGE_SCREEN, true, { id: Button(event.target).name }));
		}
		
		private function onRemoveFromStage(e:Event):void 
		{
			removeEventListener(Event.REMOVED_FROM_STAGE, onRemoveFromStage);
			//ClassFileXML = null;
			//_fileXML = null;
			//_button.dispose();
			//_button = null;
			
			while (this.numChildren)
			{
				this.removeChildAt(0, true);
			}
			this.removeFromParent(true);
		}
	}

}