package mkquest.assets.fighters 
{
	import flash.utils.ByteArray;
	import starling.display.Sprite;
	import starling.display.Button;
	import starling.events.Event;
	
	import mkquest.assets.statics.Constants;
	import mkquest.assets.statics.Resource;
	import mkquest.assets.events.Navigation;
	import mkquest.assets.character.CharacterSmall;
	import mkquest.assets.character.CharacterAnimation;
	import mkquest.assets.xml.FileXML;
	
	public class Fighters extends Sprite 
	{
		[Embed(source = 'Fighters.xml', mimeType='application/octet-stream')]
		private var ClassFileXML1:Class;
		
		[Embed(source = 'FightersCharacteristics.xml', mimeType='application/octet-stream')]
		private var ClassFileXML2:Class;
		
		private var _fileXML:XML;
		private var _button:Button;
		
		private var _characteristics:Vector.<Vector.<String>> = new Vector.<Vector.<String>>();
		
		public function Fighters() 
		{
			super();
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			addEventListener(Event.TRIGGERED, onButtonsClick);
			addEventListener(Event.REMOVED_FROM_STAGE, onRemovedFromStage);
		}
		
		private function onAddedToStage(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			
			name = Constants.FIGHTERS;
			x = Constants.GAME_WINDOW_WIDTH / 3.0;
			y = Constants.GAME_WINDOW_HEIGHT / 2.8;
			
			_characteristics = loadCharacteristics();
			createCharacterSmall();
			createCharacterAnimation();
			createPanelIconButtonsXML();
			
		}
		
		private function loadCharacteristics():Vector.<Vector.<String>>
		{
			_fileXML = FileXML.getFileXML(ClassFileXML2);
		
			var matrix:Vector.<Vector.<String>> = new Vector.<Vector.<String>>();
			
			var n:int = _fileXML.Fighter.length();
			for (var i:int = 0; i < n; i++)
			{
				var newRow:Vector.<String> = new Vector.<String>();
                newRow.push(_fileXML.Fighter[i].Name); 
				newRow.push(_fileXML.Fighter[i].CharacterHit1);
				newRow.push(_fileXML.Fighter[i].CharacterHit2);
				newRow.push(_fileXML.Fighter[i].CharacterHit3);
				newRow.push(_fileXML.Fighter[i].CharacterHit4);
				newRow.push(_fileXML.Fighter[i].CharacterHit5);
				matrix.push(newRow);
			}
			return matrix;
		}
		
		private function showCharacteristics(name:String):void
		{
			var characterSmall:CharacterSmall = CharacterSmall(this.getChildByName(Constants.CHARACTER_SMALL));
			var characterAnimation:CharacterAnimation = CharacterAnimation(this.getChildByName(Constants.CHARACTER_ANIMATION));
			var n:int = _characteristics.length;
			for (var i:int = 0; i < n; i++)
			{
				if (_characteristics[i][0].toString() == name)
				{
					characterSmall.setValueCharacter(_characteristics[i]);	// окно характеристик
					characterAnimation.selectCharacterAnimamation(name);	// окно анимации бойца
					return;
				}
			}
		}
		
		private function createPanelIconButtonsXML():void
		{
			Resource.textureAtlas = Resource.getTextureAtlasFromBitmap(Resource.AtlasSpritesGame, Resource.AtlasSpritesGameXML);
			
			_fileXML = FileXML.getFileXML(ClassFileXML1);
			
			var n:int = _fileXML.Icon.length();
			for (var i:int = 0; i < n; i++)
			{
				_button = new Button(Resource.textureAtlas.getTexture(_fileXML.Icon[i].Texture));
				_button.name = _fileXML.Icon[i].Name;
				_button.x = _fileXML.Icon[i].PosX;
				_button.y = _fileXML.Icon[i].PosY;
				addChild(_button);
			}
			
			showCharacteristics(_fileXML.Icon[0].Name);
			
			Resource.textureAtlas = Resource.getTextureAtlasFromBitmap(Resource.AtlasSpritesGame, Resource.AtlasSpritesGameXML);
			n = _fileXML.Button.length();
			for (var k:int = 0; k < n; k++)
			{
				_button = new Button(Resource.textureAtlas.getTexture(_fileXML.Button[k].Texture));
				_button.name = _fileXML.Button[k].Name;
				if (Resource.languageRus == true)
				{
					_button.text = _fileXML.Button[k].TextRus;
				}
				else 
				{
					_button.text = _fileXML.Button[k].TextEng;
				}
				_button.fontName = _fileXML.Button[k].FontName;
				_button.fontColor = _fileXML.Button[k].FontColor;
				_button.fontSize = _fileXML.Button[k].FontSize;
				_button.x = _fileXML.Button[k].PosX;
				_button.y = _fileXML.Button[k].PosY;
				addChild(_button);
			}
		}
		
		
		private function createCharacterSmall():void 
		{
			addChild(new CharacterSmall());
		}
		
		private function createCharacterAnimation():void 
		{
			addChild(new CharacterAnimation());
		}
		
		private function onButtonsClick(event:Event):void 
		{
			if (Button(event.target).name == Constants.BUTTON_BACK || Button(event.target).name == Constants.MENU_BUTTON_SATTINGS || Button(event.target).name == Constants.BUTTON_PLAY)
			{
				dispatchEvent(new Navigation(Navigation.CHANGE_SCREEN, true, { id: Button(event.target).name } ));
			}
			else 
			{
				showCharacteristics(Button(event.target).name);
			}
		}
		
		private function onRemovedFromStage(e:Event):void 
		{
			removeEventListener(Event.REMOVED_FROM_STAGE, onRemovedFromStage);
			//ClassFileXML1 = null;
			//ClassFileXML2 = null;
			//_fileXML = null;
			//_button.dispose();
			//_button = null;
			//_characteristics = null;
			
			while (this.numChildren)
			{
				this.removeChildAt(0, true);
			}
			this.removeFromParent(true);
		}
	}

}