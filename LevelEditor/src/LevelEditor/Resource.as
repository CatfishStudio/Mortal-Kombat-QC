package LevelEditor 
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import LevelEditor.FieldCell;
	
	public class Resource 
	{
		[Embed(source = '../../images/hits.png')]
		public static var HitsClass:Class;
		public static var Hits:Bitmap = new HitsClass();
		public static var Hit1:Bitmap;
		public static var Hit2:Bitmap;
		public static var Hit3:Bitmap;
		public static var Hit4:Bitmap;
		public static var Hit5:Bitmap;
		
		[Embed(source = '../../images/cursor.png')]
		public static var CursorImage:Class;
		public static var Cursor:Bitmap = new CursorImage();
		[Embed(source = '../../images/cell.png')]
		public static var CellClearImage:Class;
		public static var CellClear:Bitmap = new CellClearImage();
		[Embed(source = '../../images/drop.png')]
		public static var CellDropImage:Class;
		public static var CellDrop:Bitmap = new CellDropImage();
		
		/* Костанты */
		public static const COLUMNS:int = 6;
		public static const ROWS:int = 6;
		
		/* Тип уровня */
		public static var LevelType:Array = new Array( 
			{label:"All", data:"LEVEL_TYPE_ALL"},
			{label:"Tournament", data:"LEVEL_TYPE_TOURNAMENT"}, 
			{label:"Player sv Player", data:"LEVEL_TYPE_PVP"}
		); 
		
		/* Выбраный объект */
		public static var SelectObject:String = "SELECT_NO_OBJECT";
		
		/* Параметры редактируемого уровня */
		public static var Level:String;			// номер уровня
		public static var Type:String;			// тип уровня
			
		/* Массив: Игровое поле (тип Vector) */
		public static var MatrixCell:Vector.<Vector.<FieldCell>>;
		
		/* Создание 2D массива тип Array */
		public static function CreateArrayMatrix2D(_columns:uint, _rows:uint):Array
		{
			/* i - столбец; j - строка */
			var newArray:Array = [];
			var unitAdd:FieldCell = new FieldCell();
			for (var i:uint = 0; i < _columns; i++) {
				var newRow:Array = [];
				for (var j:uint = 0; j < _rows; j++) {
					newRow.push(unitAdd);
				}
				newArray.push(newRow);
			}
			return newArray;
		}
		
		/* Создание 2D массива тип Vector */
		public static function CreateVectorMatrix2D(_columns:uint, _rows:uint):Vector.<Vector.<FieldCell>>
		{
			var _matrixCell:Vector.<Vector.<FieldCell>> = new Vector.<Vector.<FieldCell>>();
			for (var i:uint = 0; i < _columns; i++) {
				var newRow:Vector.<FieldCell> = new Vector.<FieldCell>();
				for (var j:uint = 0; j < _rows; j++) {
					newRow.push(new FieldCell());
				}
				_matrixCell.push(newRow);
			}
			return _matrixCell;
		}
		
		public static function AtlasGetBitmap(_bitmap:Bitmap, _fullSizeWidth:int, _fullSizeHeight:int, _backSizeWidth:int,  _backSizeHeight:int,  _transparent:Boolean, _fillColor:uint, _rectX1:int, _rectY1:int, _rectX2:int, _rectY2:int, _ptX:int, _ptY:int):Bitmap
		{
			// полная картинка
			var imageBD:BitmapData = new BitmapData(_fullSizeWidth, _fullSizeHeight, _transparent, _fillColor);
			// размер выбраной картинки
			var canvasBD:BitmapData = new BitmapData(_backSizeWidth, _backSizeHeight, _transparent, _fillColor);
			//исходный размер
			var rect:Rectangle = new Rectangle(_rectX1, _rectY1, _rectX2, _rectY2);
			// начальная точка
			var pt:Point = new Point(_ptX, _ptY);  
			var bitmap:Bitmap;
			
			imageBD = _bitmap.bitmapData;
			canvasBD.copyPixels(imageBD, rect, pt);
			bitmap = new Bitmap(canvasBD);
			
			return bitmap;
		}
	}

}