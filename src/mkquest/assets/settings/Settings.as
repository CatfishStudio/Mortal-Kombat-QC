package mkquest.assets.settings 
{
	import flash.net.URLRequest;
	import flash.net.navigateToURL;
	
	import starling.display.Button;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.text.TextField;
	import starling.textures.Texture;
	import starling.display.Quad;
	
	import mkquest.assets.statics.Constants;
	import mkquest.assets.statics.Resource;
	import mkquest.assets.events.Navigation;
	import mkquest.assets.xml.FileXML;
	
	public class Settings extends Sprite 
	{
		[Embed(source = 'Settings.xml', mimeType='application/octet-stream')]
		private var ClassFileXML:Class;
		private var _fileXML:XML = FileXML.getFileXML(ClassFileXML);
		private var _button:Button;
		private var _image:Image;
		private var _quad:Quad;
		
		public function Settings() 
		{
			super();
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			addEventListener(Event.REMOVED_FROM_STAGE, onRemovedFromStage);
		}
		
		private function onAddedToStage(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			addEventListener(Event.TRIGGERED, onButtonsClick);
			
			name = Constants.SETTINGS;
			x = Constants.GAME_WINDOW_WIDTH / 2.55;
			y = Constants.GAME_WINDOW_HEIGHT / 2.5;
			
			createQuad();
			
			createWindowSettingsFromXML();
		}
		
		private function createQuad():void
		{
			_quad = new Quad(Constants.GAME_WINDOW_WIDTH, Constants.GAME_WINDOW_HEIGHT,  0x000000, true);
			_quad.alpha = 0.5;
			_quad.x = 0 - this.x;
			_quad.y = 0 - this.y;
			this.addChild(_quad);
		}
		
		private function createWindowSettingsFromXML():void 
		{
			Resource.textureAtlas = Resource.getTextureAtlasFromBitmap(Resource.AtlasSpritesGame, Resource.AtlasSpritesGameXML);
			
			_image = new Image(Resource.textureAtlas.getTexture(_fileXML.Background));
			addChild(_image);
			_image = new Image(Resource.textureAtlas.getTexture(_fileXML.Border));
			addChild(_image);
			
			_button = new Button(Resource.textureAtlas.getTexture(_fileXML.Button.Texture));
			_button.name = _fileXML.Button.Name;
			if (Resource.languageRus == true)
			{
				_button.text = _fileXML.Button.TextRus;
			}
			else 
			{
				_button.text = _fileXML.Button.TextEng;
			}
			_button.fontName = _fileXML.Button.FontName;
			_button.fontColor = _fileXML.Button.FontColor;
			_button.fontSize = _fileXML.Button.FontSize;
			_button.x = _fileXML.Button.PosX;
			_button.y = _fileXML.Button.PosY;
			addChild(_button);
			
			var n:int = _fileXML.Buttons.length();
			for (var i:int = 0; i < n; i++)
			{
				_button = new Button(Resource.textureAtlas.getTexture(_fileXML.Buttons[i].TexturesOn));
				_button.name = _fileXML.Buttons[i].Name;
				_button.x = _fileXML.Buttons[i].PosX;
				_button.y = _fileXML.Buttons[i].PosY;
				addChild(_button);
			}
			
			settingsSoundMusic();
		}
		
		private function settingsSoundMusic():void
		{
			Resource.textureAtlas = Resource.getTextureAtlasFromBitmap(Resource.AtlasSpritesGame, Resource.AtlasSpritesGameXML);
			
			_button = Button(this.getChildByName(Constants.SETTINGS_BUTTON_SOUND));
			if (Resource.soundOn == true)
			{
				_button.upState = Resource.textureAtlas.getTexture(_fileXML.Buttons[0].TexturesOn);
			
			}
			else
			{
				_button.upState = Resource.textureAtlas.getTexture(_fileXML.Buttons[0].TexturesOff);
			}
			
			_button = Button(this.getChildByName(Constants.SETTINGS_BUTTON_MUSIC));
			if (Resource.musicOn == true)
			{
				_button.upState = Resource.textureAtlas.getTexture(_fileXML.Buttons[1].TexturesOn);
			}
			else
			{
				_button.upState = Resource.textureAtlas.getTexture(_fileXML.Buttons[1].TexturesOff);
			}
		}
		
		private function soundOnOff():void
		{
			Resource.textureAtlas = Resource.getTextureAtlasFromBitmap(Resource.AtlasSpritesGame, Resource.AtlasSpritesGameXML);
			
			_button = Button(this.getChildByName(Constants.SETTINGS_BUTTON_SOUND));
			if (Resource.soundOn == true)
			{
				Resource.soundOn = false;
				_button.upState = Resource.textureAtlas.getTexture(_fileXML.Buttons[0].TexturesOff);
			}
			else
			{
				Resource.soundOn = true;
				_button.upState = Resource.textureAtlas.getTexture(_fileXML.Buttons[0].TexturesOn);
			}
		}
		
		private function musicOnOff():void
		{
			Resource.textureAtlas = Resource.getTextureAtlasFromBitmap(Resource.AtlasSpritesGame, Resource.AtlasSpritesGameXML);
			
			_button = Button(this.getChildByName(Constants.SETTINGS_BUTTON_MUSIC));
			if (Resource.musicOn == true)
			{
				Resource.musicOn = false;
				_button.upState = Resource.textureAtlas.getTexture(_fileXML.Buttons[1].TexturesOff);
			}
			else
			{
				Resource.musicOn = true;
				_button.upState = Resource.textureAtlas.getTexture(_fileXML.Buttons[1].TexturesOn);
			}
		}
		
		private function information():void
		{
			navigateToURL(new URLRequest('https://vk.com/club62618339'));
		}
		
		private function onButtonsClick(event:Event):void 
		{
			if (Button(event.target).name == Constants.SETTINGS_BUTTON_APPLY)
			{
				dispatchEvent(new Navigation(Navigation.CHANGE_SCREEN, true, { id: Button(event.target).name } ));
			}
			if (Button(event.target).name == Constants.SETTINGS_BUTTON_SOUND)
			{
				soundOnOff();
			}
			if (Button(event.target).name == Constants.SETTINGS_BUTTON_MUSIC)
			{
				musicOnOff();
			}
			if (Button(event.target).name == Constants.SETTINGS_BUTTON_INFORMATION)
			{
				information();
			}
		}
		
		private function onRemovedFromStage(e:Event):void 
		{
			removeEventListener(Event.REMOVED_FROM_STAGE, onRemovedFromStage);
			//ClassFileXML = null;
			//_fileXML = null;
			//_image.dispose();
			//_image = null;
			//_button.dispose();
			//_button = null;
			//_quad.dispose();
			//_quad = null;
			
			while (this.numChildren)
			{
				this.removeChildAt(0, true);
			}
			this.removeFromParent(true);
		}
	}

}