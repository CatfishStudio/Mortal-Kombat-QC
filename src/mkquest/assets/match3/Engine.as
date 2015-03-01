package mkquest.assets.match3 
{
	import flash.utils.ByteArray;
	
	import starling.display.Sprite;
	import starling.core.Starling;
	import starling.animation.Tween;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.textures.TextureAtlas;
	
	
	public class Engine 
	{
		/* Костанты */
		public static const COLUMNS:int = 6;
		public static const ROWS:int = 6;
		public static const CELL_WIDTH:int = 82;
		public static const CELL_HEIGHT:int = 82;
		
		
		/* Игровое поле (Level.as)*/
		public static var MatrixCell:Vector.<Vector.<Cell>>;
		/* Объекты игрового поля */
		public static var MatrixUnit:Vector.<Vector.<Unit>>;
		
		
		/* Генератор случайный число =================================================================== */
		public static function RandomIndex():int
		{
			var indexRandom:Number = Math.random() * 10;
			var index:int = Math.round(indexRandom);
			return index;
		}
		/* ============================================================================================ */
		
		/* Чтение XML файлов ========================================================================== */
		public static function getFileXML(classFileXML:Class):XML
		{
			var byteArray:ByteArray = new classFileXML();
			return new XML(byteArray.readUTFBytes(byteArray.length));
		}
		/* ============================================================================================ */
		
		/* Создание 2D массива тип Vector ============================================================== */
		public static function CreateCellVectorMatrix2D(_columns:uint, _rows:uint):Vector.<Vector.<Cell>>
		{
			var _matrixCell:Vector.<Vector.<Cell>> = new Vector.<Vector.<Cell>>();
			for (var i:uint = 0; i < _columns; i++) {
				var newRow:Vector.<Cell> = new Vector.<Cell>();
				for (var j:uint = 0; j < _rows; j++) {
					newRow.push(new Cell());
				}
				_matrixCell.push(newRow);
			}
			trace("... Объект CELL: Создани 2D массива тип Vector");
			return _matrixCell;
		}
		
		public static function CreateUnitVectorMatrix2D(_columns:uint, _rows:uint, _textureAtlas:TextureAtlas):Vector.<Vector.<Unit>>
		{
			var _matrixUnit:Vector.<Vector.<Unit>> = new Vector.<Vector.<Unit>>();
			for (var i:uint = 0; i < _columns; i++) {
				var newRow:Vector.<Unit> = new Vector.<Unit>();
				for (var j:uint = 0; j < _rows; j++) {
					newRow.push(new Unit(_textureAtlas));
				}
				_matrixUnit.push(newRow);
			}
			trace("... Объект UNIT: Создани 2D массива тип Vector");
			return _matrixUnit;
		}
		/* ============================================================================================ */
		
		
		/* Построение игрового поля и объектов игрового поля ========================================== */
		public static function BuildCellsAndUnits(_parentSprite:Sprite, _textureAtlas:TextureAtlas, _fileXML:XML):void
		{
			MatrixCell = CreateCellVectorMatrix2D(COLUMNS, ROWS);
			MatrixUnit = CreateUnitVectorMatrix2D(COLUMNS, ROWS, _textureAtlas);
			
			/* Создаем игровое поле (i - столбец; j - строка) 
			 * чтение данных из xml файла (Создаем игровое поле)
			 * */
			var index:int = 0;
			for (var iCell:uint = 0; iCell < COLUMNS; iCell++) {
				for (var jCell:uint = 0; jCell < ROWS; jCell++) {
					
					if (_fileXML.cell[index].cellType == "CELL_TYPE_CLEAR") {
						/* клетка */
						(MatrixCell[iCell][jCell] as Cell).x = 155 + (CELL_WIDTH * iCell);
						(MatrixCell[iCell][jCell] as Cell).y = 70 + (CELL_HEIGHT * jCell);
						(MatrixCell[iCell][jCell] as Cell).cellType = "CELL_TYPE_CLEAR";
						
						_parentSprite.addChild(MatrixCell[iCell][jCell]);
					}else {
						/* клетка */
						(MatrixCell[iCell][jCell] as Cell).x = 155 + (CELL_WIDTH * iCell);
						(MatrixCell[iCell][jCell] as Cell).y = 70 + (CELL_HEIGHT * jCell);
						(MatrixCell[iCell][jCell] as Cell).cellType = "CELL_TYPE_DROP";
						(MatrixCell[iCell][jCell] as Cell).visible = false;
					}
					index++;
				}
			}
			
			/* Размещаем объекты игрового поля (i - столбец; j - строка) */
			index = 0;
			for (var iUnit:uint = 0; iUnit < COLUMNS; iUnit++) {
				for (var jUnit:uint = 0; jUnit < ROWS; jUnit++) {
					if (_fileXML.cell[index].cellType != "CELL_TYPE_DROP" && _fileXML.cell[index].cellObject != "HIT_0") {
						/* объект */
						(MatrixUnit[iUnit][jUnit] as Unit).x = 155 + (CELL_WIDTH * iUnit);
						(MatrixUnit[iUnit][jUnit] as Unit).y = 70 + (CELL_HEIGHT * jUnit);
						(MatrixUnit[iUnit][jUnit] as Unit).posColumnI = iUnit;
						(MatrixUnit[iUnit][jUnit] as Unit).posRowJ = jUnit;
						(MatrixUnit[iUnit][jUnit] as Unit).unitType = _fileXML.cell[index].cellObject;
						(MatrixUnit[iUnit][jUnit] as Unit).cellType = "CELL_TYPE_CLEAR";
						(MatrixUnit[iUnit][jUnit] as Unit).UnitShow();
						/*события */
						//(MatrixUnit[iUnit][jUnit] as Unit).addEventListener(TouchEvent.TOUCH, onButtonTouch);
						
						_parentSprite.addChild(MatrixUnit[iUnit][jUnit]);
					}else {
						/* объект HIT_0 */
						(MatrixUnit[iUnit][jUnit] as Unit).x = 155 + (CELL_WIDTH * iUnit);
						(MatrixUnit[iUnit][jUnit] as Unit).y = 70 + (CELL_HEIGHT * jUnit);
						(MatrixUnit[iUnit][jUnit] as Unit).posColumnI = iUnit;
						(MatrixUnit[iUnit][jUnit] as Unit).posRowJ = jUnit;
						(MatrixUnit[iUnit][jUnit] as Unit).unitType = _fileXML.cell[index].cellObject; // HIT_0
						(MatrixUnit[iUnit][jUnit] as Unit).cellType = "CELL_TYPE_DROP";
						(MatrixUnit[iUnit][jUnit] as Unit).UnitShow();
					}
					index++;
				}
			}
			
			
			
			
			
			//trace(_fileXML.LevelNumber);
			
			
			trace("<> Построен: Игровое поле и объекты игрового поля");
		}
		/* ============================================================================================ */
		
		
		
		
	}

}