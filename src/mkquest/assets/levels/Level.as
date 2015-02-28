package mkquest.assets.levels 
{
	import flash.geom.Rectangle;
	
	import starling.display.Button;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	
	import mkquest.assets.xml.FileXML;
	import mkquest.assets.events.Navigation;
	import mkquest.assets.statics.Constants;
	import mkquest.assets.statics.Resource;
	
	
	public class Level extends Sprite 
	{
		private var _fileXML:XML = FileXML.getFileXML(Resource.ClassXMLFileLevel);
		private var _image:Image;
		private var _button:Button;
		private var _window:Sprite;
		
		
		public function Level() 
		{
			super();
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			addEventListener(Event.REMOVED, onRemoveStage);
		}
		
		private function onAddedToStage(e:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			name = Constants.MK_WINDOW_LEVEL;
			
			createWindow();					// Создание окна уровня
			createButtonsPanelFromXML();	// Создание кнопок меню
		}
		
		private function onRemoveStage(e:Event):void
		{
			//Starling.juggler.remove(_tween);
			//_tween = null;
			super.dispose();
		}
		
		private function createWindow():void
		{
			/* окно */
			_window = new Sprite();
			_window.x = _fileXML.WindowPosX;
			_window.y = _fileXML.WindowPosY;
			
			/* Фоновая картинка */
			_image = new Image(Resource.textureAtlas.getTexture(Resource.levels[Resource.tournamentProgress].backgroundFileTexture));
			_image.scaleX += 1;
			_image.scaleY += 1.35;
			_window.addChild(_image);
			
			/* Рамка окна */
			_image = new Image(Resource.textureAtlas.getTexture(_fileXML.Border));
			_window.addChild(_image);
			
			/* Добавляем окно на сцену*/
			addChild(_window);
			
			/* Маска окна */
			clipMask(_window, 0, 0, Constants.MK_WINDOW_WIDTH, Constants.MK_WINDOW_HEIGHT);
		}
		
		private function clipMask(_sprite:Sprite, _x:int, _y:int, _width:int, _height:int):void
		{
			_sprite.clipRect = new Rectangle(_x, _y, _width, _height);
		}
		
		private function createButtonsPanelFromXML():void
		{
			var n:int = _fileXML.Button.length();
			for (var m:int = 0; m < n; m++)
			{
				_button = new Button(Resource.textureAtlas.getTexture(_fileXML.Button[m].Texture));
				_button.name = _fileXML.Button[m].Name;
				if (Resource.languageRus == true)
				{
					_button.text = _fileXML.Button[m].TextRus;
				}
				else 
				{
					_button.text = _fileXML.Button[m].TextEng;
				}
				_button.fontName = _fileXML.Button[m].FontName;
				_button.fontColor = _fileXML.Button[m].FontColor;
				_button.fontSize = _fileXML.Button[m].FontSize;
				_button.x = _fileXML.Button[m].PosX;
				_button.y = _fileXML.Button[m].PosY;
				addChild(_button);
			}
		}
		
		
	}

}