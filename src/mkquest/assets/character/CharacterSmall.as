package mkquest.assets.character 
{
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.text.TextField;
	
	import mkquest.assets.statics.Constants;
	import mkquest.assets.statics.Resource;
	import mkquest.assets.xml.FileXML;
	
	public class CharacterSmall extends Sprite 
	{
		[Embed(source = 'CharacterSmall.xml', mimeType='application/octet-stream')]
		private var ClassFileXML:Class;
		private var _fileXML:XML = FileXML.getFileXML(ClassFileXML);
		private var _image:Image;
		private var _textField:TextField;
		
		public function CharacterSmall() 
		{
			super();
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			addEventListener(Event.REMOVED_FROM_STAGE, onRemoveFromStage);
		}
		
		private function onAddedToStage(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			
			name = Constants.CHARACTER_SMALL;
			x = Constants.GAME_WINDOW_WIDTH / 2.6;
			y = 0;
			
			createCharacterSmallFromXML();
		}
		
		private function createCharacterSmallFromXML():void
		{
			_image = new Image(Resource.textureAtlas.getTexture(_fileXML.Background));
			addChild(_image);
						
			var n:int = _fileXML.Characteristic.length();
			for (var i:int = 0; i < n; i++)
			{
				_image = new Image(Resource.textureAtlas.getTexture(_fileXML.Characteristic[i].Texture));
				_image.x = _fileXML.Characteristic[i].TexturePosX;
				_image.y = _fileXML.Characteristic[i].TexturePosY;
				addChild(_image);
				
				if (Resource.languageRus == true)
				{
					_textField = new TextField(100, 30, _fileXML.Characteristic[i].TextRus, _fileXML.Characteristic[i].FontName, _fileXML.Characteristic[i].FontSize, _fileXML.Characteristic[i].FontColor, false);
				}
				else
				{
					_textField = new TextField(100, 30, _fileXML.Characteristic[i].TextEng, _fileXML.Characteristic[i].FontName, _fileXML.Characteristic[i].FontSize, _fileXML.Characteristic[i].FontColor, false);
				}
				_textField.hAlign = "left";
				_textField.x = _fileXML.Characteristic[i].TextPosX;
				_textField.y = _fileXML.Characteristic[i].TextPosY;
				addChild(_textField);
				
				_textField = new TextField(100, 30, _fileXML.Characteristic[i].Value, _fileXML.Characteristic[i].FontName, _fileXML.Characteristic[i].FontSize, _fileXML.Characteristic[i].FontColor, false);
				_textField.hAlign = "left";
				_textField.x = _fileXML.Characteristic[i].ValuePosX;
				_textField.y = _fileXML.Characteristic[i].ValuePosY;
				_textField.name = _fileXML.Characteristic[i].Name;
				addChild(_textField);
				
			}
			
			_image = new Image(Resource.textureAtlas.getTexture(_fileXML.Border));
			addChild(_image);
			
		}
		
		public function setValueCharacter(value:Vector.<String>):void
		{
			Resource.clearUser();
			
			_textField = TextField(this.getChildByName(Constants.CHARACTER_HIT_1));
			Resource.user_hit_1 = int(value[1]);
			_textField.text = value[1].toString();
			
			_textField = TextField(this.getChildByName(Constants.CHARACTER_HIT_2));
			Resource.user_hit_2 = int(value[2]);
			_textField.text = value[2].toString();
			
			_textField = TextField(this.getChildByName(Constants.CHARACTER_HIT_3));
			Resource.user_hit_3 = int(value[3]);
			_textField.text = value[3].toString();
			
			_textField = TextField(this.getChildByName(Constants.CHARACTER_HIT_4));
			Resource.user_hit_4 = int(value[4]);
			_textField.text = value[4].toString();
			
			_textField = TextField(this.getChildByName(Constants.CHARACTER_HIT_5));
			Resource.user_hit_5 = int(value[5]);
			_textField.text = value[5].toString();
		}
		
		private function onRemoveFromStage(e:Event):void 
		{
			removeEventListener(Event.REMOVED_FROM_STAGE, onRemoveFromStage);
			
			ClassFileXML = null;
			_fileXML = null;
			_image.dispose();
			_image = null;
			_textField.dispose();
			_textField = null;
			
			while (this.numChildren)
			{
				this.removeChildAt(0, true);
			}
			this.removeFromParent(true);
		}
	}

}