package mkcards.assets.window.selectside 
{
	import flash.system.*;
	import flash.utils.ByteArray;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.display.Button;
	import flash.display.Bitmap;
	import starling.text.BitmapFont;
	import starling.text.TextField;
	import starling.events.Event;
	import starling.textures.Texture;
	
	import mkcards.assets.events.Navigation;
	import mkcards.assets.statics.Constants;
	import mkcards.assets.statics.Resource;
	
	import mkcards.assets.xml.FileXML;
	
	public class SelectSide extends Sprite 
	{
		[Embed(source = 'SelectSide.xml', mimeType='application/octet-stream')]
		private var ClassFileXML:Class;
		private var _fileXML:XML = FileXML.getFileXML(ClassFileXML);
		private var _textField:TextField;
		private var _button:Button;
		
		public function SelectSide() 
		{
			super();
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			addEventListener(Event.REMOVED_FROM_STAGE, onRemoveFromStage);
			addEventListener(Event.TRIGGERED, onButtonsClick);
		}
		
		private function onAddedToStage(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			name = Constants.WINDOW_SELECT_SIDE;
			x = Constants.GAME_WINDOW_WIDTH / 4.5;
			y = Constants.GAME_WINDOW_HEIGHT / 3.5;
			showBackground();
			createFromXML();
		}
		
		private function onRemoveFromStage(e:Event):void 
		{
			removeEventListener(Event.REMOVED_FROM_STAGE, onRemoveFromStage);
			
			ClassFileXML = null;
			_fileXML = null;
			if (_button) _button.dispose();
			_button = null;
			if (_textField) _textField.dispose();
			_textField = null;
				
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
			if (Button(event.target).name == Constants.WINDOW_SELECT_SIDE_BUTTON_OK)
			{
			dispatchEvent(new Navigation(Navigation.CHANGE_SCREEN, true, { id: Button(event.target).name }));
			}else{
				var image:Image; 
				image = Image(getChildByName("DARK"));
				if (Button(event.target).name == Constants.WINDOW_SELECT_SIDE_DARK) {
					image.visible = true;
					Resource.userSide = "DARK";
				} else image.visible = false;
			
				image = Image(getChildByName("WHITE"));
				if (Button(event.target).name == Constants.WINDOW_SELECT_SIDE_LIGHT) {
					image.visible = true;
					Resource.userSide = "WHITE";
				} else image.visible = false;
			
				image.dispose();
				image = null;
			}
		}
		
		private function showBackground():void
		{
			var bitmap:Bitmap = new Resource.TextureWindowBackground();
			var image:Image = new Image(Texture.fromBitmap(bitmap));
			addChild(image);
			
			bitmap = new Resource.TextureWindowBorder();
			image = new Image(Texture.fromBitmap(bitmap));
			addChild(image);
			
			bitmap = null;
			image.dispose();
			image = null;
		}
		
		private function createFromXML():void
		{
			var texture:Texture = Texture.fromEmbeddedAsset(Resource.FontTexture);
			var xml:XML = XML(new Resource.FontXml());
			TextField.registerBitmapFont(new BitmapFont(texture, xml), "Font01");
			
			_textField = new TextField(450, 50, "Выбери на чьей ты стороне.", "Arial", 27, 0xffffff, false);
			_textField.fontName = "Font01";
			_textField.hAlign = "center";
			_textField.x = 10;
			_textField.y = 20;
			addChild(_textField);
			
			var bitmap:Bitmap = new Resource.TextureYellow();
			var image:Image = new Image(Texture.fromBitmap(bitmap));
			image.name = "DARK";
			image.x = _fileXML.Button[0].X - 17;
			image.y = _fileXML.Button[0].Y - 17;
			image.visible = true;
			addChild(image);
			
			bitmap = new Resource.TextureDarkSide();
			_button = new Button(Texture.fromBitmap(bitmap));
			_button.name = _fileXML.Button[0].Name;
			_button.x = _fileXML.Button[0].X;
			_button.y = _fileXML.Button[0].Y;
			addChild(_button);
			
			bitmap = new Resource.TextureWhite();
			image = new Image(Texture.fromBitmap(bitmap));
			image.x = _fileXML.Button[1].X - 17;
			image.y = _fileXML.Button[1].Y - 17;
			image.name = "WHITE";
			image.visible = false;
			addChild(image);
			
			bitmap = new Resource.TextureLightSide();
			_button = new Button(Texture.fromBitmap(bitmap));
			_button.name = _fileXML.Button[1].Name;
			_button.x = _fileXML.Button[1].X;
			_button.y = _fileXML.Button[1].Y;
			addChild(_button);
			
			_textField = new TextField(450, 50, "Изменить свой выбор вы можите в настройках персонажа.", "Arial", 16, 0xffffff, false);
			_textField.hAlign = "center";
			_textField.x = 15;
			_textField.y = 215;
			addChild(_textField);
			
			bitmap = new Resource.TextureButton();
			_button = new Button(Texture.fromBitmap(bitmap));
			_button.name = _fileXML.Button[2].Name;
			if (Resource.languageRus == true)
			{
				_button.text = _fileXML.Button[2].TextRus;
			}
			else 
			{
				_button.text = _fileXML.Button[2].TextEng;
			}
			_button.fontName = _fileXML.Button[2].FontName;
			_button.fontColor = _fileXML.Button[2].FontColor;
			_button.fontSize = _fileXML.Button[2].FontSize;
			_button.x = _fileXML.Button[2].X;
			_button.y = _fileXML.Button[2].Y;
			addChild(_button);
				
			bitmap = null;
			texture = null;
			image.dispose();
			image = null;
		}
		
		
	}

}