package LevelEditor 
{
	import fl.controls.Button;
	import fl.controls.TextInput;
	import fl.controls.ComboBox;
	import fl.controls.Label;
	import fl.data.DataProvider; 
	import fl.events.ComponentEvent;
	import flash.events.ProgressEvent;
	import flash.filesystem.FileStream;
	import flash.net.FileFilter;
	import flash.xml.XMLDocument;
	
	import flash.display.Sprite;
	import flash.display.Bitmap;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.MouseEvent;
	import flash.events.SecurityErrorEvent;
	import flash.ui.Mouse;
	import flash.ui.MouseCursor;
	import flash.events.MouseEvent;
	import flash.net.FileReference;
	import flash.net.URLLoader;
	import flash.net.navigateToURL; 
	import flash.net.Responder;
	import flash.net.URLRequest;
	import flash.utils.ByteArray;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	
	import LevelEditor.Resource;
	
	public class Editor extends Sprite 
	{
		private var _file: File;
		private var _button1:Button = new Button();	// открыть файл
		private var _button2:Button = new Button();	// сохранить файл
		private var _button3:Button = new Button();	// очистить
		
		private var _label1:Label = new Label();
		private var _textBox1:TextInput = new TextInput();	//номер уровня <LevelNumber>
		private var _label2:Label = new Label();
		private var _comboBox1:ComboBox = new ComboBox();	// тип уровня <LevelType>
		
		
		private var _loaderXML:URLLoader; // для загрузки XML
		private var _urlReq:URLRequest;
		private var _xml:XML;
		
		public function Editor() 
		{
			super();
			this.addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			/* Кнопки */
			_button1.label = "Открыть";
			_button1.x = 10; _button1.y = 10;
			_button1.addEventListener(MouseEvent.CLICK, onButton1MouseClick);
			this.addChild(_button1);
			_button2.label = "Сохранить";
			_button2.x = 120; _button2.y = 10;
			_button2.addEventListener(MouseEvent.CLICK, onButton2MouseClick);
			this.addChild(_button2);
			_button3.label = "Очистить";
			_button3.x = 230; _button3.y = 10;
			_button3.addEventListener(MouseEvent.CLICK, onButton3MouseClick);
			this.addChild(_button3);
			
			/* Метка */
			_label1.text = "Номер уровня:";
			_label1.x = 20; _label1.y = 50;
			this.addChild(_label1);
			/* Номер уровня */
			_textBox1.text = "0";
			_textBox1.x = 20; _textBox1.y = 70;
			_textBox1.width = 200;
			this.addChild(_textBox1);
			
			/* Метка */
			_label2.text = "Тип уровня:";
			_label2.x = 20; _label2.y = 100;
			this.addChild(_label2);
			/* Тип уровня */
			_comboBox1.x = 20; _comboBox1.y = 120;
			_comboBox1.dropdownWidth = 210; 
			_comboBox1.width = 200;  
			_comboBox1.selectedIndex = 0;
			_comboBox1.dataProvider = new DataProvider(Resource.LevelType); 
			_comboBox1.addEventListener(Event.CHANGE, changeHandlerComboBox1); 
			this.addChild(_comboBox1);
			
			/* ИГРОВОЕ ПОЛЕ */
			Resource.MatrixCell =  Resource.CreateVectorMatrix2D(Resource.COLUMNS, Resource.ROWS);
			showField(Resource.COLUMNS, Resource.ROWS);
			
			/* ПАНЕЛЬ ОБЪЕКТОВ */
			this.addChild(new PanelObjects());
			
			/* ЗНАЧЕНИЯ ПО УМОЛЧАНИЮ */
			Resource.Level = "";
			Resource.Type = "";
		}
		
		private function changeHandlerComboBox1(e:Event):void 
		{
			_comboBox1.text = ComboBox(e.target).selectedItem.label;
		}
		
		/*Открытие файла ---------------------------------------------------*/
		private function onButton1MouseClick(e:MouseEvent):void 
		{
			var fileFiltres:Array = [];
			fileFiltres.push(new FileFilter("Файл уровня в XML формате", "*.xml"));
			fileFiltres.push(new FileFilter("Все файлы", "*.*"));
			_file = File.desktopDirectory;
			_file.browseForOpen("Открыть файл", fileFiltres);
			_file.addEventListener(Event.SELECT, openFileEventHandler);
		}
		
		private function openFileEventHandler(e:Event):void 
		{
			trace("Open file name: " + _file.name);
			trace("Open file path: " + _file.nativePath);
			
			var stream:FileStream = new FileStream();
			stream.addEventListener(ProgressEvent.PROGRESS, progressHandler);
			stream.addEventListener(Event.COMPLETE, completeHandler);
			stream.openAsync(e.target as File, FileMode.READ);
		}
		
		private function progressHandler(e:ProgressEvent):void 
		{
			var stream:FileStream = e.target as FileStream;
			if (stream.bytesAvailable) {
				//trace(stream.readUTFBytes(stream.bytesAvailable).toString());
				//trace(stream.readUTF(stream.bytesAvailable).toString());
				//trace(stream.readMultiByte(stream.bytesAvailable, "iso-8859-1"));
			}
		}
		
		private function completeHandler(e:Event):void 
		{
			_urlReq = new URLRequest(_file.nativePath);
			_loaderXML = new URLLoader(_urlReq);
			_loaderXML.addEventListener(Event.COMPLETE, xmlLoadComplete);
			_loaderXML.addEventListener(SecurityErrorEvent.SECURITY_ERROR, securityError);
			_loaderXML.addEventListener(IOErrorEvent.IO_ERROR, ioError);
			e.target.close();
			
		}
		
		/* чтение данных из XML файла */
		private function xmlLoadComplete(e:Event):void 
		{
			_loaderXML.removeEventListener(Event.COMPLETE, xmlLoadComplete);
			
			_xml = new XML(e.target.data);
			Resource.Level = _xml.LevelNumber; 
			_textBox1.text = Resource.Level;
			Resource.Type = _xml.LevelType;
			for (var iCox1:uint = 0; iCox1 < _comboBox1.length; iCox1++) {
				if(_comboBox1.getItemAt(iCox1).data == Resource.LevelType) _comboBox1.selectedIndex = iCox1;
			}
			
			/* i - столбец; j - строка */
			for (var index:int = 0; index < Resource.COLUMNS * Resource.ROWS; index++) {
				var col:int = _xml.cell[index].cellColumn; /* столбец */
				var row:int = _xml.cell[index].cellRow; /* строка */
				(Resource.MatrixCell[col][row] as FieldCell).cellType = _xml.cell[index].cellType;
				(Resource.MatrixCell[col][row] as FieldCell).cellObject = _xml.cell[index].cellObject;
				if (_xml.cell[index].cellType != "CELL_TYPE_DROP") Resource.SelectObject = _xml.cell[index].cellObject;
				else Resource.SelectObject = _xml.cell[index].cellType;
				(Resource.MatrixCell[col][row] as FieldCell).SetObject();
			}
			
			trace("File: " + _file.name + " open comlpite!");
		}
		
		private function securityError(e:SecurityErrorEvent):void 
		{
			trace("Ошибка доступа!");
		}
		
		private function ioError(e:IOErrorEvent):void 
		{
			trace("Ошибка загрузки!");
		}
		/*-----------------------------------------*/
		
		/*Сохранить файл*/
		private function onButton2MouseClick(e:MouseEvent):void 
		{
			_file = File.desktopDirectory;
			_file.browseForSave("Сохранить файл");
			_file.addEventListener(Event.SELECT, saveFileEventHandler);
		}
		
		private function saveFileEventHandler(e:Event):void 
		{
			trace("File name: " + _file.name);
			trace("File path: " + _file.nativePath);
			
			Resource.Level = _textBox1.text;
			Resource.Type = _comboBox1.selectedItem.data;
			
			var bytes:ByteArray = new ByteArray();
			
			bytes.writeMultiByte("<?xml ", "iso-8859-1");
			bytes.writeMultiByte("version=\"1.0\" encoding=\"UTF-8\"", "iso-8859-1");
			bytes.writeMultiByte("?>\n", "iso-8859-1");
			
			bytes.writeMultiByte("<Level>\n", "iso-8859-1");
			
				bytes.writeMultiByte("<LevelNumber>", "iso-8859-1");
				bytes.writeMultiByte(Resource.Level, "iso-8859-1");
				bytes.writeMultiByte("</LevelNumber>\n", "iso-8859-1");
				bytes.writeMultiByte("<LevelType>", "iso-8859-1");
				bytes.writeMultiByte(Resource.Type, "iso-8859-1");
				bytes.writeMultiByte("</LevelType>\n", "iso-8859-1");
				
				/* i - столбец; j - строка */
				for (var i:uint = 0; i < Resource.COLUMNS; i++) {
					for (var j:uint = 0; j < Resource.ROWS; j++) {
						bytes.writeMultiByte("<cell>\n", "iso-8859-1");
							bytes.writeMultiByte("<cellType>", "iso-8859-1");
							bytes.writeMultiByte((Resource.MatrixCell[i][j] as FieldCell).cellType, "iso-8859-1");
							bytes.writeMultiByte("</cellType>\n", "iso-8859-1");
							bytes.writeMultiByte("<cellObject>", "iso-8859-1");
							bytes.writeMultiByte((Resource.MatrixCell[i][j] as FieldCell).cellObject, "iso-8859-1");
							bytes.writeMultiByte("</cellObject>\n", "iso-8859-1");
							bytes.writeMultiByte("<cellColumn>", "iso-8859-1");
							bytes.writeMultiByte(i.toString(), "iso-8859-1");
							bytes.writeMultiByte("</cellColumn>\n", "iso-8859-1");
							bytes.writeMultiByte("<cellRow>", "iso-8859-1");
							bytes.writeMultiByte(j.toString(), "iso-8859-1");
							bytes.writeMultiByte("</cellRow>\n", "iso-8859-1");
						bytes.writeMultiByte("</cell>\n", "iso-8859-1");
					}
				}
			bytes.writeMultiByte("</Level>", "iso-8859-1");
			
			var stream:FileStream = new FileStream();
			stream.open(_file, FileMode.WRITE);
			stream.writeBytes(bytes);
			stream.close();
			trace("File: " + _file.name + " save comlpite!");
		}
		/*-----------------------------------------*/
		
		/* Очистка */
		private function onButton3MouseClick(e:MouseEvent):void 
		{
			dispatchEvent(new Event(Event.CLEAR));
		}
		
		/* Отобразить игровое поле */
		private function showField(_columns:uint, _rows:uint):void
		{
			/* i - столбец; j - строка */
			for (var i:uint = 0; i < _columns; i++) {
				for (var j:uint = 0; j < _rows; j++) {
					(Resource.MatrixCell[i][j] as FieldCell).x = 300 + (80 * i);
					(Resource.MatrixCell[i][j] as FieldCell).y = 50 + (80 * j);
					this.addChild(Resource.MatrixCell[i][j]);
				}
			}
		}
	}

}