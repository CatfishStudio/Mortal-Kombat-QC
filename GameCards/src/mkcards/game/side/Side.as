package mkcards.game.side 
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
	
	import mkcards.events.Navigation;
	import mkcards.game.statics.Constants;
	import mkcards.game.statics.Resource;
	import mkcards.xml.FileXML;
		
	public class Side extends Sprite 
	{
		[Embed(source = 'Side.xml', mimeType='application/octet-stream')]
		private var ClassFileXML:Class;
		private var _fileXML:XML = FileXML.getFileXML(ClassFileXML);
		private var _textField:TextField;
		private var _button:Button;
		
		public function Side() 
		{
			super();
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			addEventListener(Event.REMOVED_FROM_STAGE, onRemoveFromStage);
			addEventListener(Event.TRIGGERED, onButtonsClick);
		}
		
		private function onAddedToStage(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			name = Constants.WINDOW_SIDE;
			x = Constants.GAME_WINDOW_WIDTH / 4.5;
			y = Constants.GAME_WINDOW_HEIGHT / 3.5;
			showTitle();
			createFromXML();
		}
		
		private function onRemoveFromStage(e:Event):void 
		{
			removeEventListener(Event.REMOVED_FROM_STAGE, onRemoveFromStage);
			
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
			if (Button(event.target).name == Constants.WINDOW_SIDE_SHAO_KAHN)
			{
				Resource.userSide = Constants.SHAOKAHN;
				Resource.userWins = 0;
				Resource.userDefeats = 0;
				dispatchEvent(new Navigation(Navigation.CHANGE_SCREEN, true, { id: Constants.WINDOW_SAVE_SIDE } ));
			}
			if (Button(event.target).name == Constants.WINDOW_SIDE_RAIDEN)
			{
				Resource.userSide = Constants.RAIDEN;
				Resource.userWins = 0;
				Resource.userDefeats = 0;
				dispatchEvent(new Navigation(Navigation.CHANGE_SCREEN, true, { id: Constants.WINDOW_SAVE_SIDE } ));
			}
			if (Button(event.target).name == Constants.WINDOW_SIDE_CLOSE)
			{
				dispatchEvent(new Navigation(Navigation.CHANGE_SCREEN, true, { id: Constants.WINDOW_SIDE_CLOSE } ));
			}
		}
		
		private function showTitle():void
		{
			var bitmap:Bitmap = new Resource.TextureTitle();
			var image:Image = new Image(Texture.fromBitmap(bitmap));
			image.x = 35;
			image.y = 15;
			addChild(image);
			
			var texture:Texture = Texture.fromEmbeddedAsset(Resource.FontTexture);
			var xml:XML = XML(new Resource.FontXml());
			TextField.registerBitmapFont(new BitmapFont(texture, xml), "Font01");
			
			_textField = new TextField(450, 50, _fileXML.Title, "Arial", 27, 0xffffff, false);
			_textField.fontName = "Font01";
			_textField.hAlign = "center";
			_textField.x = 15;
			_textField.y = 15;
			addChild(_textField);
			
			_textField = new TextField(450, 50, _fileXML.Text, "Arial", 12, 0xffffff, false);
			_textField.hAlign = "center";
			_textField.x = 10;
			_textField.y = 225;
			addChild(_textField);
			
			bitmap = null;
			image.dispose();
			image = null;
		}
		
		
		private function createFromXML():void
		{
			var bitmap:Bitmap = new Resource.TextureSideShaokahn();
			_button = new Button(Texture.fromBitmap(bitmap));
			_button.name = _fileXML.Button[0].Name;
			_button.x = _fileXML.Button[0].X;
			_button.y = _fileXML.Button[0].Y;
			addChild(_button);
			
			bitmap = new Resource.TextureSideRaiden();
			_button = new Button(Texture.fromBitmap(bitmap));
			_button.name = _fileXML.Button[1].Name;
			_button.x = _fileXML.Button[1].X;
			_button.y = _fileXML.Button[1].Y;
			addChild(_button);
			
			if (Resource.tutorialStep != 1)
			{
				bitmap = new Resource.TextureButton();
				_button = new Button(Texture.fromBitmap(bitmap));
				_button.name = _fileXML.Button[2].Name;
				if (Resource.languageRus == true) _button.text = _fileXML.Button[2].TextRus;
				else _button.text = _fileXML.Button[2].TextEng;
				_button.fontName = _fileXML.Button[2].FontName;
				_button.fontColor = _fileXML.Button[2].FontColor;
				_button.fontSize = _fileXML.Button[2].FontSize;
				_button.x = _fileXML.Button[2].X;
				_button.y = _fileXML.Button[2].Y;
				addChild(_button);
			}
		}
		
	}

}