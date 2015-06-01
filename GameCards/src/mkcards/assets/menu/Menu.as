package mkcards.assets.menu 
{
	import flash.display.Bitmap;
	import flash.system.*;
	import flash.utils.ByteArray;
	import starling.display.Sprite;
	import starling.display.Button;
	import starling.events.Event;
	import starling.textures.Texture;
	
	import mkcards.assets.events.Navigation;
	import mkcards.assets.statics.Constants;
	import mkcards.assets.statics.Resource;
	
	import mkcards.assets.xml.FileXML;
	
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
			y = Constants.GAME_WINDOW_HEIGHT / 3.5;
			
			addEventListener(Event.TRIGGERED, onButtonsClick);
			createPanelButtonsFromXML();
			
			dispatchEvent(new Navigation(Navigation.CHANGE_SCREEN, true, { id: Constants.ON_ADDED_TO_STAGE }));
		}
		
		private function onRemoveFromStage(e:Event):void 
		{
			removeEventListener(Event.REMOVED_FROM_STAGE, onRemoveFromStage);
			
			dispatchEvent(new Navigation(Navigation.CHANGE_SCREEN, true, { id: Constants.ON_REMOVE_FROM_STAGE }));
			
			
			ClassFileXML = null;
			_fileXML = null;
			if (_button) _button.dispose();
			_button = null;
			
			while (this.numChildren)
			{
				this.removeChildren(0, -1, true);
			}
			this.removeFromParent(true);
			
			super.dispose();
			System.gc();
			trace("[X] onRemoveFromStage: " + this.name);
		}
		
		private function onButtonsClick(event:Event):void 
		{
			//MusicAndSound.PlaySound(MusicAndSound.Sound1);
			dispatchEvent(new Navigation(Navigation.CHANGE_SCREEN, true, { id: Button(event.target).name }));
		}
		
		private function createPanelButtonsFromXML():void
		{
			var bitmap:Bitmap = new Resource.TextureButton();
			
			var n:int = _fileXML.Button.length();
			for (var i:int = 0; i < n; i++)
			{
				_button = new Button(Texture.fromBitmap(bitmap));
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
			
			bitmap = null;
		}
		
	}

}