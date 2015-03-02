package mkquest.assets.match3 
{
	import flash.utils.ByteArray;
	import flash.ui.Mouse;
	import flash.ui.MouseCursor;
	
	import starling.display.Sprite;
	import starling.core.Starling;
	import starling.animation.Tween;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.textures.TextureAtlas;
	
	public class Match3 
	{
		/* Костанты */
		public static const COLUMNS:int = 6;
		public static const ROWS:int = 6;
		public static const CELL_WIDTH:int = 82;
		public static const CELL_HEIGHT:int = 82;
		
		/* Игровое поле */
		public static var field:Sprite;
		public static var fieldTextureAtlas:TextureAtlas;
		public static var fieldBlocked:Boolean = false;
		public static var unit1:Unit = null;
		public static var unit2:Unit = null;
		
		/* Массив: Игровое поле (Level.as)*/
		public static var MatrixCell:Vector.<Vector.<Cell>>;
		/* Массив: Объекты игрового поля */
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
		public static function CreateCellVectorMatrix2D(columns:int, rows:int):Vector.<Vector.<Cell>>
		{
			var _matrixCell:Vector.<Vector.<Cell>> = new Vector.<Vector.<Cell>>();
			for (var i:int = 0; i < columns; i++) {
				var newRow:Vector.<Cell> = new Vector.<Cell>();
				for (var j:int = 0; j < rows; j++) {
					newRow.push(new Cell());
				}
				_matrixCell.push(newRow);
			}
			trace("... Объект CELL: Создани 2D массива тип Vector");
			return _matrixCell;
		}
		
		public static function CreateUnitVectorMatrix2D(columns:int, rows:int, textureAtlas:TextureAtlas):Vector.<Vector.<Unit>>
		{
			var _matrixUnit:Vector.<Vector.<Unit>> = new Vector.<Vector.<Unit>>();
			for (var i:int = 0; i < columns; i++) {
				var newRow:Vector.<Unit> = new Vector.<Unit>();
				for (var j:int = 0; j < rows; j++) {
					newRow.push(new Unit(textureAtlas));
				}
				_matrixUnit.push(newRow);
			}
			trace("... Объект UNIT: Создани 2D массива тип Vector");
			return _matrixUnit;
		}
		/* ============================================================================================ */
		
		
		/* Построение игрового поля и объектов игрового поля ========================================== */
		public static function BuildCellsAndUnits(parentSprite:Sprite, textureAtlas:TextureAtlas, fileXML:XML):void
		{
			field = parentSprite;
			fieldTextureAtlas = textureAtlas;
			
			MatrixCell = CreateCellVectorMatrix2D(COLUMNS, ROWS);
			MatrixUnit = CreateUnitVectorMatrix2D(COLUMNS, ROWS, fieldTextureAtlas);
			
			/* Создаем игровое поле (i - столбец; j - строка) 
			 * чтение данных из xml файла (Создаем игровое поле)
			 * */
			var index:int = 0;
			for (var iCell:int = 0; iCell < COLUMNS; iCell++) {
				for (var jCell:int = 0; jCell < ROWS; jCell++) {
					
					if (fileXML.cell[index].cellType == "CELL_TYPE_CLEAR") {
						/* клетка */
						(MatrixCell[iCell][jCell] as Cell).x = 155 + (CELL_WIDTH * iCell);
						(MatrixCell[iCell][jCell] as Cell).y = 70 + (CELL_HEIGHT * jCell);
						(MatrixCell[iCell][jCell] as Cell).cellType = "CELL_TYPE_CLEAR";
						
						field.addChild(MatrixCell[iCell][jCell]);
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
					if (fileXML.cell[index].cellType != "CELL_TYPE_DROP" && fileXML.cell[index].cellObject != "HIT_0") {
						/* объект */
						(MatrixUnit[iUnit][jUnit] as Unit).x = 155 + (CELL_WIDTH * iUnit);
						(MatrixUnit[iUnit][jUnit] as Unit).y = 70 + (CELL_HEIGHT * jUnit);
						(MatrixUnit[iUnit][jUnit] as Unit).posColumnI = iUnit;
						(MatrixUnit[iUnit][jUnit] as Unit).posRowJ = jUnit;
						(MatrixUnit[iUnit][jUnit] as Unit).unitType = fileXML.cell[index].cellObject;
						(MatrixUnit[iUnit][jUnit] as Unit).cellType = "CELL_TYPE_CLEAR";
						(MatrixUnit[iUnit][jUnit] as Unit).UnitShow();
						/*события */
						(MatrixUnit[iUnit][jUnit] as Unit).addEventListener(TouchEvent.TOUCH, onButtonTouch);
						
						field.addChild(MatrixUnit[iUnit][jUnit]);
					}else {
						/* объект HIT_0 */
						(MatrixUnit[iUnit][jUnit] as Unit).x = 155 + (CELL_WIDTH * iUnit);
						(MatrixUnit[iUnit][jUnit] as Unit).y = 70 + (CELL_HEIGHT * jUnit);
						(MatrixUnit[iUnit][jUnit] as Unit).posColumnI = iUnit;
						(MatrixUnit[iUnit][jUnit] as Unit).posRowJ = jUnit;
						(MatrixUnit[iUnit][jUnit] as Unit).unitType = fileXML.cell[index].cellObject; // HIT_0
						(MatrixUnit[iUnit][jUnit] as Unit).cellType = "CELL_TYPE_DROP";
						(MatrixUnit[iUnit][jUnit] as Unit).UnitShow();
					}
					index++;
				}
			}
			
			field.dispatchEvent(new Events(Events.MATCH_3_EVENTS, true, { id: "Complite_Build_Cells_And_Units" })); // СОБЫТИЕ
			trace("<> Построен: Игровое поле и объекты игрового поля");
		}
		
		static private function onButtonTouch(e:TouchEvent):void 
		{
			var touch:Touch = e.getTouch(field.stage);
			if (touch)
			{
				if (touch.phase == TouchPhase.BEGAN)
				{
					Mouse.cursor = MouseCursor.BUTTON;
					
					field.dispatchEvent(new Events(Events.MATCH_3_EVENTS, true, { id: "Unit_Click" })); // СОБЫТИЕ
					
					if (fieldBlocked == false) // Игровое поле разблокировано
					{	
						if (unit1 == null) unit1 = (e.currentTarget as Unit);
						else 
						{
							if ((e.currentTarget as Unit) != unit1) 
							{
								fieldBlocked = true;
								unit2 = (e.currentTarget as Unit);
								if(unit2.posColumnI > (unit1.posColumnI - 2) && unit2.posColumnI < (unit1.posColumnI + 2) && unit2.posRowJ > (unit1.posRowJ - 2) && unit2.posRowJ < (unit1.posRowJ + 2) && (unit2.posColumnI == unit1.posColumnI || unit2.posRowJ == unit1.posRowJ))
									ExchangeUnit(unit1.posColumnI, unit1.posRowJ, unit2.posColumnI, unit2.posRowJ);
								//else RecoveryField();
							}//else RecoveryField();
						}
					}
				}
				else if (touch.phase == TouchPhase.ENDED)
				{
					Mouse.cursor = MouseCursor.AUTO;
				}
				else if (touch.phase == TouchPhase.HOVER)
				{
					Mouse.cursor = MouseCursor.AUTO;
				}
				else if (touch.phase == TouchPhase.MOVED)
				{
					Mouse.cursor = MouseCursor.BUTTON;
				}
			}
		}
		/* ============================================================================================ */
		
		/* Обмен местами в массиве выбранных пользователем  объектов ===================================*/
		public static function ExchangeUnit(columnUnit1:int, rowUnit1:int, columnUnit2:int, rowUnit2:int):void
		{
			var unitMove:Unit = new Unit(fieldTextureAtlas);
			unitMove = MatrixUnit[columnUnit1][rowUnit1];
			MatrixUnit[columnUnit1][rowUnit1] = MatrixUnit[columnUnit2][rowUnit2];
			MatrixUnit[columnUnit2][rowUnit2] = unitMove;
			(MatrixUnit[columnUnit1][rowUnit1] as Unit).posColumnI = columnUnit1;
			(MatrixUnit[columnUnit1][rowUnit1] as Unit).posRowJ = rowUnit1;
			(MatrixUnit[columnUnit2][rowUnit2] as Unit).posColumnI = columnUnit2;
			(MatrixUnit[columnUnit2][rowUnit2] as Unit).posRowJ = rowUnit2;
			
			var tweenUnit1:Tween = new Tween((MatrixUnit[columnUnit1][rowUnit1] as Unit), 0.5);
			var tweenUnit2:Tween = new Tween((MatrixUnit[columnUnit2][rowUnit2] as Unit), 0.5);
			var unit1Complite:Boolean = false;
			var unit2Complite:Boolean = false;
			
			tweenUnit1.moveTo((MatrixUnit[columnUnit2][rowUnit2] as Unit).x, (MatrixUnit[columnUnit2][rowUnit2] as Unit).y);
			tweenUnit1.onComplete = function():void 
			{ 
				unit1Complite = true; 
				//if (unit1Complite && unit2Complite) level.CheckField(false);
				Starling.juggler.removeTweens(tweenUnit1);
				tweenUnit1 = null;
			};
			Starling.juggler.add(tweenUnit1);
			
			tweenUnit2.moveTo((MatrixUnit[columnUnit1][rowUnit1] as Unit).x, (MatrixUnit[columnUnit1][rowUnit1] as Unit).y);
			tweenUnit2.onComplete = function():void 
			{ 
				unit2Complite = true; 
				//if (unit1Complite && unit2Complite) level.CheckField(false);
				Starling.juggler.removeTweens(tweenUnit2);
				tweenUnit2 = null;
			};
			Starling.juggler.add(tweenUnit2);
		}
		
		public static function BackExchangeCrystals(columnUnit1:int, rowUnit1:int, columnUnit2:int, rowUnit2:int):void
		{
			var unitMove:Unit = new Unit(fieldTextureAtlas);
			unitMove = MatrixUnit[columnUnit1][rowUnit1];
			MatrixUnit[columnUnit1][rowUnit1] = MatrixUnit[columnUnit2][rowUnit2];
			MatrixUnit[columnUnit2][rowUnit2] = unitMove;
			(MatrixUnit[columnUnit1][rowUnit1] as Unit).posColumnI = columnUnit1;
			(MatrixUnit[columnUnit1][rowUnit1] as Unit).posRowJ = rowUnit1;
			(MatrixUnit[columnUnit2][rowUnit2] as Unit).posColumnI = columnUnit2;
			(MatrixUnit[columnUnit2][rowUnit2] as Unit).posRowJ = rowUnit2;
			
			var tweenUnit1:Tween = new Tween((MatrixUnit[columnUnit1][rowUnit1] as Unit), 0.5);
			var tweenUnit2:Tween = new Tween((MatrixUnit[columnUnit2][rowUnit2] as Unit), 0.5);
			var unit1Complite:Boolean = false;
			var unit2Complite:Boolean = false;
			
			tweenUnit1.moveTo((MatrixUnit[columnUnit2][rowUnit2] as Unit).x, (MatrixUnit[columnUnit2][rowUnit2] as Unit).y);
			tweenUnit1.onComplete = function():void 
			{ 
				unit1Complite = true; 
				//if (unit1Complite && unit2Complite) level.RecoveryField();
				Starling.juggler.removeTweens(tweenUnit1);
				tweenUnit1 = null;
			};
			Starling.juggler.add(tweenUnit1);
			
			tweenUnit2.moveTo((MatrixUnit[columnUnit1][rowUnit1] as Unit).x, (MatrixUnit[columnUnit1][rowUnit1] as Unit).y);
			tweenUnit2.onComplete = function():void 
			{ 
				unit2Complite = true; 
				//if (unit1Complite && unit2Complite) level.RecoveryField();
				Starling.juggler.removeTweens(tweenUnit1);
				tweenUnit1 = null;
			};
			Starling.juggler.add(tweenUnit2);
		}
		/* ============================================================================================ */
		
		
		
		
	}

}