package mkquest.assets.character 
{
	import flash.system.*;
	import starling.display.Button;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.text.TextField;
	
	import mkquest.assets.statics.Constants;
	import mkquest.assets.statics.Resource;
	import mkquest.assets.xml.FileXML;
	import mkquest.assets.sounds.MusicAndSound;
	import mkquest.assets.events.Navigation;
		
	public class CharacterSmall extends Sprite 
	{
		[Embed(source = 'CharacterSmall.xml', mimeType='application/octet-stream')]
		private var ClassFileXML:Class;
		private var _fileXML:XML = FileXML.getFileXML(ClassFileXML);
		private var _image:Image;
		private var _textField:TextField;
		private var _button:Button;
		
		public function CharacterSmall(_x:int, _y:int) 
		{
			super();
			
			this.x = _x;
			this.y = _y;
			createCharacterSmallFromXML();
			
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			addEventListener(Event.REMOVED, onRemoveStage);
			addEventListener(Event.TRIGGERED, onButtonsClick);
		}
		
		private function onAddedToStage(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			
			name = Constants.CHARACTER_SMALL;
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
			Resource.clearAI();
			
			Resource.user_name = value[0].toString();
			
			_textField = TextField(this.getChildByName(Constants.CHARACTER_HIT_1));
			Resource.user_hit_1 = int(value[1]);
			_textField.text = Resource.user_hit_1.toString();
			
			_textField = TextField(this.getChildByName(Constants.CHARACTER_HIT_2));
			Resource.user_hit_2 = int(value[2]);
			_textField.text = Resource.user_hit_2.toString();
			
			_textField = TextField(this.getChildByName(Constants.CHARACTER_HIT_3));
			Resource.user_hit_3 = int(value[3]);
			_textField.text = Resource.user_hit_3.toString();
			
			_textField = TextField(this.getChildByName(Constants.CHARACTER_HIT_4));
			Resource.user_hit_4 = int(value[4]);
			_textField.text = Resource.user_hit_4.toString();
			
			_textField = TextField(this.getChildByName(Constants.CHARACTER_HIT_5));
			Resource.user_hit_5 = int(value[5]);
			_textField.text = Resource.user_hit_5.toString();
		}
		
		public function selectValueUserCharacter():void
		{
			_textField = TextField(this.getChildByName(Constants.CHARACTER_HIT_1));
			_textField.text = Resource.user_hit_1.toString();
			_textField = TextField(this.getChildByName(Constants.CHARACTER_HIT_2));
			_textField.text = Resource.user_hit_2.toString();
			_textField = TextField(this.getChildByName(Constants.CHARACTER_HIT_3));
			_textField.text = Resource.user_hit_3.toString();
			_textField = TextField(this.getChildByName(Constants.CHARACTER_HIT_4));
			_textField.text = Resource.user_hit_4.toString();
			_textField = TextField(this.getChildByName(Constants.CHARACTER_HIT_5));
			_textField.text = Resource.user_hit_5.toString();
		}
		
		public function selectValueAICharacter(indexAI:int):void
		{
			_textField = TextField(this.getChildByName(Constants.CHARACTER_HIT_1));
			_textField.text = Resource.ai_enemies[indexAI].aiHit1.toString();
			_textField = TextField(this.getChildByName(Constants.CHARACTER_HIT_2));
			_textField.text = Resource.ai_enemies[indexAI].aiHit2.toString();
			_textField = TextField(this.getChildByName(Constants.CHARACTER_HIT_3));
			_textField.text = Resource.ai_enemies[indexAI].aiHit3.toString();
			_textField = TextField(this.getChildByName(Constants.CHARACTER_HIT_4));
			_textField.text = Resource.ai_enemies[indexAI].aiHit4.toString();
			_textField = TextField(this.getChildByName(Constants.CHARACTER_HIT_5));
			_textField.text = Resource.ai_enemies[indexAI].aiHit5.toString();
			
		}
		
		public function createButtonsPlus():void
		{
			var n:int = _fileXML.ButtonPlus.length();
			for (var i:int = 0; i < n; i++)
			{
				_button = new Button(Resource.textureAtlas.getTexture(_fileXML.ButtonPlus[i].Texture));
				_button.name = _fileXML.ButtonPlus[i].Name;
				_button.x = _fileXML.ButtonPlus[i].PosX;
				_button.y = _fileXML.ButtonPlus[i].PosY;
				this.addChild(_button);
			}
		}
		
		private function removeButtonPlus():void
		{
			getChildByName(Constants.CHARACTER_BUTTON_PLUS_1).visible = false;
			getChildByName(Constants.CHARACTER_BUTTON_PLUS_2).visible = false;
			getChildByName(Constants.CHARACTER_BUTTON_PLUS_3).visible = false;
			getChildByName(Constants.CHARACTER_BUTTON_PLUS_4).visible = false;
			getChildByName(Constants.CHARACTER_BUTTON_PLUS_5).visible = false;
			dispatchEvent(new Navigation(Navigation.CHANGE_SCREEN, true, { id: Constants.TUTORIAL_CLOSE } ));
		}
		
		private function onButtonsClick(event:Event):void 
		{
			MusicAndSound.PlaySound(MusicAndSound.Sound1);
			if (Button(event.target).name == Constants.CHARACTER_BUTTON_PLUS_1)
			{
				Resource.user_hit_1++;
				Resource.experiencePoints--;
				_textField = TextField(this.getChildByName(Constants.CHARACTER_HIT_1));
				_textField.text = Resource.user_hit_1.toString();
			}
			if (Button(event.target).name == Constants.CHARACTER_BUTTON_PLUS_2)
			{
				Resource.user_hit_2++;
				Resource.experiencePoints--;
				_textField = TextField(this.getChildByName(Constants.CHARACTER_HIT_2));
				_textField.text = Resource.user_hit_2.toString();
			}
			if (Button(event.target).name == Constants.CHARACTER_BUTTON_PLUS_3)
			{
				Resource.user_hit_3++;
				Resource.experiencePoints--;
				_textField = TextField(this.getChildByName(Constants.CHARACTER_HIT_3));
				_textField.text = Resource.user_hit_3.toString();
			}
			if (Button(event.target).name == Constants.CHARACTER_BUTTON_PLUS_4)
			{
				Resource.user_hit_4++;
				Resource.experiencePoints--;
				_textField = TextField(this.getChildByName(Constants.CHARACTER_HIT_4));
				_textField.text = Resource.user_hit_4.toString();
			}
			if (Button(event.target).name == Constants.CHARACTER_BUTTON_PLUS_5)
			{
				Resource.user_hit_5++;
				Resource.experiencePoints--;
				_textField = TextField(this.getChildByName(Constants.CHARACTER_HIT_5));
				_textField.text = Resource.user_hit_5.toString();
			}
			if (Resource.experiencePoints == 0)
			{
				removeButtonPlus();
			}
		}


		
		private function onRemoveStage(e:Event):void 
		{
			removeEventListener(Event.REMOVED, onRemoveStage);
			
			ClassFileXML = null;
			_fileXML = null;
			if(_image != null) _image.dispose();
			_image = null;
			if(_textField != null) _textField.dispose();
			_textField = null;
			if(_button != null) _button.dispose();
			_button = null;
			
			while (this.numChildren)
			{
				this.removeChildAt(0, true);
			}
			this.removeFromParent(true);
			
			super.dispose();
			System.gc();
			trace("[X] Удалена сцена харктеристик бойца");
		}
	}

}