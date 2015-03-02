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
		public static var fieldBackupFileXML:XML;
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
		public static function BuildCellsAndUnits(parentSprite:Sprite, textureAtlas:TextureAtlas, fileXML:XML, backupFileXML:XML):void
		{
			field = parentSprite;
			fieldTextureAtlas = textureAtlas;
			fieldBackupFileXML = backupFileXML;
			
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
		
		private static function onButtonTouch(e:TouchEvent):void 
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
									ExchangeUnits(unit1.posColumnI, unit1.posRowJ, unit2.posColumnI, unit2.posRowJ);
								else RecoveryField();
							}else RecoveryField();
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
		public static function ExchangeUnits(columnUnit1:int, rowUnit1:int, columnUnit2:int, rowUnit2:int):void
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
				if (unit1Complite && unit2Complite) CheckField(false);
				Starling.juggler.removeTweens(tweenUnit1);
				tweenUnit1 = null;
			};
			Starling.juggler.add(tweenUnit1);
			
			tweenUnit2.moveTo((MatrixUnit[columnUnit1][rowUnit1] as Unit).x, (MatrixUnit[columnUnit1][rowUnit1] as Unit).y);
			tweenUnit2.onComplete = function():void 
			{ 
				unit2Complite = true; 
				if (unit1Complite && unit2Complite) CheckField(false);
				Starling.juggler.removeTweens(tweenUnit2);
				tweenUnit2 = null;
			};
			Starling.juggler.add(tweenUnit2);
		}
		
		public static function BackExchangeUnits(columnUnit1:int, rowUnit1:int, columnUnit2:int, rowUnit2:int):void
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
				if (unit1Complite && unit2Complite) RecoveryField();
				Starling.juggler.removeTweens(tweenUnit1);
				tweenUnit1 = null;
			};
			Starling.juggler.add(tweenUnit1);
			
			tweenUnit2.moveTo((MatrixUnit[columnUnit1][rowUnit1] as Unit).x, (MatrixUnit[columnUnit1][rowUnit1] as Unit).y);
			tweenUnit2.onComplete = function():void 
			{ 
				unit2Complite = true; 
				if (unit1Complite && unit2Complite) RecoveryField();
				Starling.juggler.removeTweens(tweenUnit1);
				tweenUnit1 = null;
			};
			Starling.juggler.add(tweenUnit2);
		}
		/* ============================================================================================ */
		
		
		/* Поиск групп после действия */
		public static function CheckField(afterDown:Boolean):void
		{
			if (CheckFieldFull()) {
				//if (afterDown == false) reduceAmountMoves(); // уменьшаем количество ходов
				SimplyRemove();
			}
			else {
				if (afterDown == false) BackExchangeUnits(unit1.posColumnI, unit1.posRowJ, unit2.posColumnI, unit2.posRowJ);
				else RecoveryField();
			}
		}
		
		/* Восстановление прежнего состояния */
		public static function RecoveryField():void
		{
			if (CheckCombinations())
			{
				unit1 = null; 
				unit2 = null; 
				fieldBlocked = false;
			}
		}
		
		
		/* Поиск групп после действия пользователя =====================================================*/
		/* Проверка строка (3-и и более в ряд) */
		public static function CheckRow(row:int):Boolean
		{
			var resultCheck:Boolean = false;
			/* просматриваем в строке (по столбцам) */
			for (var i:int = 0; i < COLUMNS; i++) 
			{
				if (i < COLUMNS - 2) 
				{
					if ((MatrixUnit[i][row] as Unit).unitType != "HIT_0") 
					{
						/* Группа из 3-х объектов */
						if (MatrixUnit[i][row].unitType == MatrixUnit[i + 1][row].unitType && MatrixUnit[i][row].unitType == MatrixUnit[i + 2][row].unitType) 
						{
							/*Отмечаем кристалы для удаления */
							resultCheck = true;
							(MatrixUnit[i][row] as Unit).flagRemove = true;
							(MatrixUnit[i+1][row] as Unit).flagRemove = true;
							(MatrixUnit[i+2][row] as Unit).flagRemove = true;
							(MatrixUnit[i][row] as Unit).alpha = 0.2;
							(MatrixUnit[i+1][row] as Unit).alpha = 0.2;
							(MatrixUnit[i+2][row] as Unit).alpha = 0.2;
						
							/* Группа из 4-х кристалов */
							if (i < COLUMNS - 3) 
							{
								if (MatrixUnit[i][row].unitType == MatrixUnit[i + 3][row].unitType) 
								{
									(MatrixUnit[i + 3][row] as Unit).flagRemove = true;
									(MatrixUnit[i + 3][row] as Unit).alpha = 0.2;
								
									/* Группа из 5-ти кристалов */
									if (i < COLUMNS - 4) 
									{
										if (MatrixUnit[i][row].unitType == MatrixUnit[i + 4][row].unitType) 
										{
											/*Отмечаем кристалы для модификации и удаления */
											(MatrixUnit[i + 4][row] as Unit).flagRemove = true;
											(MatrixUnit[i + 4][row] as Unit).alpha = 0.2;
										}
									}
								}
							}
						}
					}
				}else break;
			}
			return resultCheck;
		}
		
		/* Проверка колонки (3-и и более в ряд) */
		public static function CheckColumn(column:int):Boolean
		{
			var resultCheck:Boolean = false;
			/* просматриваем  в столбце (по строкам) */
			for (var j:int = 0; j < ROWS; j++) 
			{
				if (j < ROWS - 2) 
				{
					if ((MatrixUnit[column][j] as Unit).unitType != "HIT_0")
					{
						/* Группа из 3-х объектов */
						if (MatrixUnit[column][j].unitType == MatrixUnit[column][j + 1].unitType && MatrixUnit[column][j].unitType == MatrixUnit[column][j + 2].unitType) 
						{
							/*Отмечаем кристалы для удаления */
							resultCheck = true;
							(MatrixUnit[column][j] as Unit).flagRemove = true;
							(MatrixUnit[column][j+1] as Unit).flagRemove = true;
							(MatrixUnit[column][j+2] as Unit).flagRemove = true;
							(MatrixUnit[column][j] as Unit).alpha = 0.2;
							(MatrixUnit[column][j+1] as Unit).alpha = 0.2;
							(MatrixUnit[column][j+2] as Unit).alpha = 0.2;
						
							/* Группа из 4-х кристалов */
							if (j < ROWS - 3) 
							{
								if (MatrixUnit[column][j].unitType == MatrixUnit[column][j + 3].unitType) 
								{
									(MatrixUnit[column][j+3] as Unit).flagRemove = true;
									(MatrixUnit[column][j+3] as Unit).alpha = 0.2;
								
									/* Группа из 5-ти кристалов */
									if (j < ROWS - 4) 
									{
										if (MatrixUnit[column][j].unitType == MatrixUnit[column][j + 4].unitType) 
										{
											(MatrixUnit[column][j+4] as Unit).flagRemove = true;
											(MatrixUnit[column][j+4] as Unit).alpha = 0.2;
										}
									}
								}
							}
						}
					}
				}else break;
			}
			return resultCheck;
		}
		
		/* Общая проверка колонок и строк (3-и и более в ряд) */
		public static function CheckFieldFull():Boolean
		{
			var resultCheck:Boolean = false;
			/* i - столбец; j - строка */
			for (var i:int = 0; i < COLUMNS; i++) 
			{
				if (CheckColumn(i) == true) resultCheck = true;
				for (var j:int = 0; j < ROWS; j++) 
				{
					if (CheckRow(j) == true) resultCheck = true;
				}
			}
			return resultCheck;
		}
		/* ============================================================================================ */
		
		
		/* Удаление на поле всех отмеченных ячеек (Удаление, сортировка, добавление ====================*/
		public static function SimplyRemove():void
		{
			for (var i:int = 0; i < COLUMNS; i++) /* i - столбецы (обработка слева на право) */
			{ 
				var matrixUnits:Vector.<Unit> = new Vector.<Unit>(); // массив юнитов сохраняемых на поле
				var matrixEmpty:Vector.<Unit> = new Vector.<Unit>(); // массив пустот сохраняемых на поле
				var matrixAll:Vector.<Unit> = new Vector.<Unit>(); // массив всех эдементов игрового поля (после слияния и добавления)
				
				/* Удаление помеченных кристалов ---------------------------------------------------------------------------------*/
				for (var j1:int = ROWS - 1; j1 >= 0; j1--) 
				{
					/* Удаление */
					if ((MatrixUnit[i][j1] as Unit).flagRemove == true && (MatrixUnit[i][j1] as Unit).unitType != "HIT_0") 
					{
						/* анимация звёзд */
						//////////////////////level.addChild(new Flash((Resource.MatrixUnit[i][j1] as Unit).x - 50, (Resource.MatrixUnit[i][j1] as Unit).y - 30));
						//////////////////////level.StarsAnimation((Resource.MatrixUnit[i][j1] as Unit).x, (Resource.MatrixUnit[i][j1] as Unit).y);
						/* Увеличиваем количество собранных кристалов и очков */
						//////////////////////level.CollectAmountCrystalsAndScore((Resource.MatrixUnit[i][j1] as Unit).unitType);
						/* Удаление объект с поля */
						field.removeChild(MatrixUnit[i][j1]);
						/* Удаляем в главном массиве */
						MatrixUnit[i].pop(); // Удаляем из главного массива
					}
					else 
					{
						/* Проверка пустота или нет */
						if ((MatrixUnit[i][j1] as Unit).unitType == "HIT_0")
						{ 
							/* переносим пустоту в промежуточный массив */
							matrixEmpty.push((MatrixUnit[i][j1] as Unit));
							/* Удаляем в главном массиве */
							MatrixUnit[i].pop(); // Удаляем из массива
						}
						else 
						{ // не пустота
							/* Сохраняем удар в промежуточный массив */
							matrixUnits.push((MatrixUnit[i][j1] as Unit));
							/* Удаляем в главном массиве */
							MatrixUnit[i].pop(); // Удаляем из массива
						}
					}
				}
				/*---------------------------------------------------------------------------------------------------------------*/
				
				
				/* Слияние двух массивов и добавление новых объектов -------------------------------------------------------------*/
				var totalRows:int = matrixUnits.length + matrixEmpty.length;
				if (totalRows == ROWS) // слияние без добавлений ----------
				{ 
					for (var iTotal:int = ROWS - 1; iTotal >= 0; iTotal--) 
					{
						if (matrixEmpty.length > 0) // пустоты
						{ 
							if ((matrixEmpty[0] as Unit).posRowJ == iTotal) 
							{
								matrixAll.push(matrixEmpty[0]); // переносим
								matrixEmpty.shift(); // удаляем
							}
						}
						if (matrixUnits.length > 0) // объекты
						{ 
							if ((matrixUnits[0] as Unit).posRowJ == iTotal) 
							{
								matrixAll.push(matrixUnits[0]); // переносим
								matrixUnits.shift(); // удаляем
							}
						}
					}
				}
				else // слияние с добавлением -------------------------------------
				{ 
					for (var iAdd:int = ROWS - 1; iAdd >= 0; iAdd--) 
					{
						if (matrixEmpty.length > 0) // пустоты
						{ 
							if ((matrixEmpty[0] as Unit).posRowJ == iAdd) 
							{
								matrixAll.push(matrixEmpty[0]); // переносим
								matrixEmpty.shift(); // удаляем
							}
							else // в пустоте не найдено
							{ 
								if (matrixUnits.length > 0) // объекты
								{ 
									if ((matrixUnits[0] as Unit).posRowJ == iAdd) 
									{
										matrixAll.push(matrixUnits[0]); // переносим
										matrixUnits.shift(); // удаляем
									}
									else // переносим объект вниз
									{ 
										(matrixUnits[0] as Unit).posRowJ = iAdd; // изменяем индекс положения в строке
										matrixAll.push(matrixUnits[0]); // переносим
										AnimationMoveDown((matrixUnits[0] as Unit), (matrixUnits[0] as Unit).x, (70 + (50 * iAdd)));
										matrixUnits.shift(); // удаляем
									}
								}
								else // создаём новый объект
								{ 
									/* Добавление новых объектов в массив и на поле */
									var newUnit1:Unit = new Unit(fieldTextureAtlas);
									newUnit1.x = 165 + (50 * i);
									newUnit1.y = 0 + (50 * 0);	// начальная позиция для нового объекта
									newUnit1.posColumnI = i;
									newUnit1.posRowJ = iAdd;
									
									var type1:int = RandomIndex();
									if (type1 >= 0 && type1 < 2) newUnit1.unitType = "HIT_1";
									if (type1 >= 2 && type1 < 4) newUnit1.unitType = "HIT_2";
									if (type1 >= 4 && type1 < 6) newUnit1.unitType = "HIT_3";
									if (type1 >= 6 && type1 < 8) newUnit1.unitType = "HIT_4";
									if (type1 >= 8 && type1 <= 10) newUnit1.unitType = "HIT_5";
									
									/*события*/
									newUnit1.addEventListener(TouchEvent.TOUCH, onButtonTouch);
									newUnit1.cellType = "CELL_TYPE_CLEAR";
									newUnit1.UnitShow();
						
									matrixAll.push(newUnit1);
									field.addChild(newUnit1)
									AnimationMoveDown(newUnit1, newUnit1.x, (70 + (50 * iAdd)));
								}
							}
						}
						else // пустоты закончились
						{ 
							if (matrixUnits.length > 0) 
							{ // объекты
								if ((matrixUnits[0] as Unit).posRowJ == iAdd) 
								{
									matrixAll.push(matrixUnits[0]); // переносим
									matrixUnits.shift(); // удаляем
								}
								else // переносим объект вниз
								{ 
									(matrixUnits[0] as Unit).posRowJ = iAdd; // изменяем индекс положения в строке
									matrixAll.push(matrixUnits[0]); // переносим
									AnimationMoveDown((matrixUnits[0] as Unit), (matrixUnits[0] as Unit).x, (70 + (50 * iAdd)));
									matrixUnits.shift(); // удаляем
								}
							}
							else // создаём новый объект
							{ 
								/* Добавление новых объектов в массив и на поле */
								var newUnit2:Unit = new Unit(fieldTextureAtlas);
								newUnit2.x = 165 + (50 * i);
								newUnit2.y = 0 + (50 * 0);	// начальная позиция для нового объекта
								newUnit2.posColumnI = i;
								newUnit2.posRowJ = iAdd;
									
								var type2:int = RandomIndex();
								if (type2 >= 0 && type2 < 2) newUnit2.unitType = "HIT_1";
								if (type2 >= 2 && type2 < 4) newUnit2.unitType = "HIT_2";
								if (type2 >= 4 && type2 < 6) newUnit2.unitType = "HIT_3";
								if (type2 >= 6 && type2 < 8) newUnit2.unitType = "HIT_4";
								if (type2 >= 8 && type2 <= 10) newUnit2.unitType = "HIT_5";
						
								/*события*/
								newUnit2.addEventListener(TouchEvent.TOUCH, onButtonTouch);
								newUnit2.cellType = "CELL_TYPE_CLEAR";
								newUnit2.UnitShow();
						
								matrixAll.push(newUnit2);
								field.addChild(newUnit2)
								AnimationMoveDown(newUnit2, newUnit2.x, (70 + (50 * iAdd)));
							}
						}
					}
				}
				/*---------------------------------------------------------------------------------------------------------------*/
				
				
				/* Возвращаем объекты обратно в главный массив ------------------------------------------------------------------*/
				for (var j2:int = ROWS - 1; j2 >= 0; j2--) // 5-4-3-2-1-0
				{	
					MatrixUnit[i].push(matrixAll[j2]); 	// Переносим (добавляем) в массив
				}
			}
		}
		/* ============================================================================================ */
		
		/* Анимация спуска объектов ====================================================================*/
		private static var _totalAnimation:int = 0;
		public static function AnimationMoveDown(unit:Unit, xMove:int, yMove:int):void 
		{
			_totalAnimation++;
			var _tweenUnit:Tween = new Tween(unit, 0.5);
			_tweenUnit.moveTo(xMove, yMove);
			_tweenUnit.onUpdate = function():void {	};
			_tweenUnit.onComplete = function():void 
			{ 
				Starling.juggler.remove(_tweenUnit); 
				_totalAnimation--; 
				if (_totalAnimation == 0) CheckField(true);
			};
			Starling.juggler.add(_tweenUnit);
		}
		/* ============================================================================================ */
		
		
		/* Определение возможности хода и перестановка в случае отсутствия такой возможности ========== */
		public static function CheckCombinations():Boolean
		{
			/*	   0  1  2  3  4  5
			 * 	0:[0][0][0][0][1][0]
				1:[0][0][1][1][0][1]
				2:[0][0][0][0][1][0]
				3:[0][0][0][0][0][0]
				4:[0][0][0][0][0][0]
				5:[0][0][0][0][0][0]
			 * */
			// Проверка строк и колонок
			for (var iCol:int = 0; iCol < COLUMNS; iCol++) 
			{
				for (var iRow:int = 0; iRow < ROWS; iRow++) 
				{
					if ((MatrixUnit[iCol][iRow] as Unit).unitType != "HIT_0") 
					{
							// ПРОВЕРКА СТРОКИ ---------------------------------------------------------------------------------------------
							if (iRow == 0) 
							{
								//[1][1][X][1]
								if ((iCol + 3) < COLUMNS)
									if((MatrixUnit[iCol+2][iRow] as Unit).unitType != "HIT_0" && (MatrixUnit[iCol][iRow] as Unit).unitType != "HIT_0" && (MatrixUnit[iCol+1][iRow] as Unit).unitType != "HIT_0" && (MatrixUnit[iCol+3][iRow] as Unit).unitType != "HIT_0")
										if ((MatrixUnit[iCol][iRow] as Unit).unitType == (MatrixUnit[iCol + 1][iRow] as Unit).unitType && (MatrixUnit[iCol][iRow] as Unit).unitType == (MatrixUnit[iCol + 3][iRow] as Unit).unitType) { return true; }
								//[1][X][1][1]
								if ((iCol + 3) < COLUMNS)
									if((MatrixUnit[iCol+1][iRow] as Unit).unitType != "HIT_0" && (MatrixUnit[iCol][iRow] as Unit).unitType != "HIT_0" && (MatrixUnit[iCol+2][iRow] as Unit).unitType != "HIT_0" && (MatrixUnit[iCol+3][iRow] as Unit).unitType != "HIT_0")
										if ((MatrixUnit[iCol][iRow] as Unit).unitType == (MatrixUnit[iCol + 2][iRow] as Unit).unitType && (MatrixUnit[iCol][iRow] as Unit).unitType == (MatrixUnit[iCol + 3][iRow] as Unit).unitType) { return true; }
								//[0][1][X][1]
								//[0][0][1][0]
								if ((iCol + 2) < COLUMNS && (iRow + 1) < ROWS)
									if((MatrixUnit[iCol+1][iRow] as Unit).unitType != "HIT_0" && (MatrixUnit[iCol][iRow] as Unit).unitType != "HIT_0" && (MatrixUnit[iCol+1][iRow+1] as Unit).unitType != "HIT_0" && (MatrixUnit[iCol+2][iRow] as Unit).unitType != "HIT_0")
										if ((MatrixUnit[iCol][iRow] as Unit).unitType == (MatrixUnit[iCol + 1][iRow + 1] as Unit).unitType && (MatrixUnit[iCol][iRow] as Unit).unitType == (MatrixUnit[iCol + 2][iRow] as Unit).unitType) { return true; }
								//[0][1][1][X]
								//[0][0][0][1]
								if ((iCol + 2) < COLUMNS && (iRow + 1) < ROWS)
									if((MatrixUnit[iCol+2][iRow] as Unit).unitType != "HIT_0" && (MatrixUnit[iCol][iRow] as Unit).unitType != "HIT_0" && (MatrixUnit[iCol+1][iRow] as Unit).unitType != "HIT_0" && (MatrixUnit[iCol+2][iRow] as Unit).unitType != "HIT_0")
										if ((MatrixUnit[iCol][iRow] as Unit).unitType == (MatrixUnit[iCol + 1][iRow] as Unit).unitType && (MatrixUnit[iCol][iRow] as Unit).unitType == (MatrixUnit[iCol + 2][iRow + 1] as Unit).unitType) { return true; }
								//[0][X][1][1]
								//[0][1][0][0]
								if ((iCol + 2) < COLUMNS && (iRow + 1) < ROWS)
									if((MatrixUnit[iCol][iRow] as Unit).unitType != "HIT_0" && (MatrixUnit[iCol][iRow+1] as Unit).unitType != "HIT_0" && (MatrixUnit[iCol+1][iRow] as Unit).unitType != "HIT_0" && (MatrixUnit[iCol+2][iRow] as Unit).unitType != "HIT_0")
										if ((MatrixUnit[iCol][iRow + 1] as Unit).unitType == (MatrixUnit[iCol + 1][iRow] as Unit).unitType && (MatrixUnit[iCol][iRow + 1] as Unit).unitType == (MatrixUnit[iCol + 2][iRow] as Unit).unitType) { return true; }
							}else {
								//[1][1][X][1]
								if ((iCol + 3) < COLUMNS)
									if((MatrixUnit[iCol+2][iRow] as Unit).unitType != "HIT_0" && (MatrixUnit[iCol][iRow] as Unit).unitType != "HIT_0" && (MatrixUnit[iCol+1][iRow] as Unit).unitType != "HIT_0" && (MatrixUnit[iCol+3][iRow] as Unit).unitType != "HIT_0")
										if ((MatrixUnit[iCol][iRow] as Unit).unitType == (MatrixUnit[iCol + 1][iRow] as Unit).unitType && (MatrixUnit[iCol][iRow] as Unit).unitType == (MatrixUnit[iCol + 3][iRow] as Unit).unitType) { return true; }
								//[1][X][1][1]
								if ((iCol + 3) < COLUMNS)
									if((MatrixUnit[iCol+1][iRow] as Unit).unitType != "HIT_0" && (MatrixUnit[iCol][iRow] as Unit).unitType != "HIT_0" && (MatrixUnit[iCol+2][iRow] as Unit).unitType != "HIT_0" && (MatrixUnit[iCol+3][iRow] as Unit).unitType != "HIT_0")
										if ((MatrixUnit[iCol][iRow] as Unit).unitType == (MatrixUnit[iCol + 2][iRow] as Unit).unitType && (MatrixUnit[iCol][iRow] as Unit).unitType == (MatrixUnit[iCol + 3][iRow] as Unit).unitType) { return true; }
								//[0][1][1][X]
								//[0][0][0][1]
								if ((iCol + 2) < COLUMNS && (iRow + 1) < ROWS)
									if((MatrixUnit[iCol+2][iRow] as Unit).unitType != "HIT_0" && (MatrixUnit[iCol][iRow] as Unit).unitType != "HIT_0" && (MatrixUnit[iCol+1][iRow] as Unit).unitType != "HIT_0" && (MatrixUnit[iCol+2][iRow+1] as Unit).unitType != "HIT_0")
										if ((MatrixUnit[iCol][iRow] as Unit).unitType == (MatrixUnit[iCol + 1][iRow] as Unit).unitType && (MatrixUnit[iCol][iRow] as Unit).unitType == (MatrixUnit[iCol + 2][iRow + 1] as Unit).unitType) { return true; }
								//[0][0][0][1]
								//[0][1][1][X]
								if ((iCol + 2) < COLUMNS && (iRow - 1) >= 0)
									if((MatrixUnit[iCol+2][iRow] as Unit).unitType != "HIT_0" && (MatrixUnit[iCol][iRow] as Unit).unitType != "HIT_0" && (MatrixUnit[iCol+1][iRow] as Unit).unitType != "HIT_0" && (MatrixUnit[iCol+2][iRow-1] as Unit).unitType != "HIT_0")
										if ((MatrixUnit[iCol][iRow] as Unit).unitType == (MatrixUnit[iCol + 1][iRow] as Unit).unitType && (MatrixUnit[iCol][iRow] as Unit).unitType == (MatrixUnit[iCol + 2][iRow - 1] as Unit).unitType) { return true; }
								//[0][X][1][1]
								//[0][1][0][0]
								if ((iCol + 2) < COLUMNS && (iRow + 1) < ROWS)
									if((MatrixUnit[iCol][iRow] as Unit).unitType != "HIT_0" && (MatrixUnit[iCol][iRow+1] as Unit).unitType != "HIT_0" && (MatrixUnit[iCol+1][iRow] as Unit).unitType != "HIT_0" && (MatrixUnit[iCol+2][iRow] as Unit).unitType != "HIT_0")
										if ((MatrixUnit[iCol][iRow + 1] as Unit).unitType == (MatrixUnit[iCol + 1][iRow] as Unit).unitType && (MatrixUnit[iCol][iRow + 1] as Unit).unitType == (MatrixUnit[iCol + 2][iRow] as Unit).unitType) { return true; }
								//[0][1][0][0]
								//[0][X][1][1]
								if ((iCol + 2) < COLUMNS && (iRow + 1) < ROWS)
									if((MatrixUnit[iCol][iRow + 1] as Unit).unitType != "HIT_0" && (MatrixUnit[iCol][iRow] as Unit).unitType != "HIT_0" && (MatrixUnit[iCol+1][iRow+1] as Unit).unitType != "HIT_0" && (MatrixUnit[iCol+2][iRow+1] as Unit).unitType != "HIT_0")
										if ((MatrixUnit[iCol][iRow] as Unit).unitType == (MatrixUnit[iCol + 1][iRow + 1] as Unit).unitType && (MatrixUnit[iCol][iRow] as Unit).unitType == (MatrixUnit[iCol + 2][iRow + 1] as Unit).unitType) { return true; }
								//[0][0][1][0]
								//[0][1][X][1]
								if ((iCol + 2) < COLUMNS && (iRow - 1) >= 0)
									if((MatrixUnit[iCol + 1][iRow] as Unit).unitType != "HIT_0" && (MatrixUnit[iCol][iRow] as Unit).unitType != "HIT_0" && (MatrixUnit[iCol + 1][iRow - 1] as Unit).unitType != "HIT_0" && (MatrixUnit[iCol + 2][iRow] as Unit).unitType != "HIT_0")
										if ((MatrixUnit[iCol][iRow] as Unit).unitType == (MatrixUnit[iCol + 1][iRow - 1] as Unit).unitType && (MatrixUnit[iCol][iRow] as Unit).unitType == (MatrixUnit[iCol + 2][iRow] as Unit).unitType) { return true; }
								//[0][1][X][1]
								//[0][0][1][0]
								if ((iCol + 2) < COLUMNS && (iRow + 1) < ROWS)
									if((MatrixUnit[iCol + 1][iRow] as Unit).unitType != "HIT_0" && (MatrixUnit[iCol][iRow] as Unit).unitType != "HIT_0" && (MatrixUnit[iCol + 1][iRow + 1] as Unit).unitType != "HIT_0" && (MatrixUnit[iCol + 2][iRow] as Unit).unitType != "HIT_0")
										if ((MatrixUnit[iCol][iRow] as Unit).unitType == (MatrixUnit[iCol + 1][iRow + 1] as Unit).unitType && (MatrixUnit[iCol][iRow] as Unit).unitType == (MatrixUnit[iCol + 2][iRow] as Unit).unitType) { return true; }
							}
							
							// ПРОВЕРКА КОЛОНКИ -----------------------------------------------------------------------------------------
							if (iCol == 0) {
								//[1]
								//[1]
								//[X]
								//[1]
								if ((iRow + 3) < ROWS)
									if((MatrixUnit[iCol][iRow + 2] as Unit).unitType != "HIT_0" && (MatrixUnit[iCol][iRow] as Unit).unitType != "HIT_0" && (MatrixUnit[iCol][iRow + 1] as Unit).unitType != "HIT_0" && (MatrixUnit[iCol][iRow + 3] as Unit).unitType != "HIT_0")
										if ((MatrixUnit[iCol][iRow] as Unit).unitType == (MatrixUnit[iCol][iRow + 1] as Unit).unitType && (MatrixUnit[iCol][iRow] as Unit).unitType == (MatrixUnit[iCol][iRow + 3] as Unit).unitType) { return true; }
								//[1]
								//[X]
								//[1]
								//[1]
								if ((iRow + 3) < ROWS)
									if((MatrixUnit[iCol][iRow + 1] as Unit).unitType != "HIT_0" && (MatrixUnit[iCol][iRow + 2] as Unit).unitType != "HIT_0" && (MatrixUnit[iCol][iRow] as Unit).unitType != "HIT_0" && (MatrixUnit[iCol][iRow + 3] as Unit).unitType != "HIT_0")
										if ((MatrixUnit[iCol][iRow] as Unit).unitType == (MatrixUnit[iCol][iRow + 2] as Unit).unitType && (MatrixUnit[iCol][iRow] as Unit).unitType == (MatrixUnit[iCol][iRow + 3] as Unit).unitType) { return true; }
								//[1][0]
								//[X][1]
								//[1][0]
								//[0][0]
								if ((iRow + 2) < ROWS && (iCol + 1) < COLUMNS)
									if((MatrixUnit[iCol][iRow + 1] as Unit).unitType != "HIT_0" && (MatrixUnit[iCol][iRow] as Unit).unitType != "HIT_0" && (MatrixUnit[iCol + 1][iRow + 1] as Unit).unitType != "HIT_0" && (MatrixUnit[iCol][iRow + 2] as Unit).unitType != "HIT_0")
										if ((MatrixUnit[iCol][iRow] as Unit).unitType == (MatrixUnit[iCol + 1][iRow + 1] as Unit).unitType && (MatrixUnit[iCol][iRow] as Unit).unitType == (MatrixUnit[iCol][iRow + 2] as Unit).unitType) { return true; }
								//[1][0]
								//[1][0]
								//[X][1]
								//[0][0]
								if ((iRow + 2) < ROWS && (iCol + 1) < COLUMNS)
									if((MatrixUnit[iCol][iRow + 2] as Unit).unitType != "HIT_0" && (MatrixUnit[iCol][iRow + 1] as Unit).unitType != "HIT_0" && (MatrixUnit[iCol][iRow] as Unit).unitType != "HIT_0" && (MatrixUnit[iCol + 1][iRow + 2] as Unit).unitType != "HIT_0")
										if ((MatrixUnit[iCol][iRow] as Unit).unitType == (MatrixUnit[iCol][iRow + 1] as Unit).unitType && (MatrixUnit[iCol][iRow] as Unit).unitType == (MatrixUnit[iCol + 1][iRow + 2] as Unit).unitType) { return true; }
								//[X][1]
								//[1][0]
								//[1][0]
								//[0][0]
								if ((iRow + 2) < ROWS && (iCol + 1) < COLUMNS)
									if((MatrixUnit[iCol][iRow] as Unit).unitType != "HIT_0" && (MatrixUnit[iCol + 1][iRow] as Unit).unitType != "HIT_0" && (MatrixUnit[iCol][iRow + 1] as Unit).unitType != "HIT_0" && (MatrixUnit[iCol][iRow + 2] as Unit).unitType != "HIT_0")
										if ((MatrixUnit[iCol + 1][iRow] as Unit).unitType == (MatrixUnit[iCol][iRow + 1] as Unit).unitType && (MatrixUnit[iCol + 1][iRow] as Unit).unitType == (MatrixUnit[iCol][iRow + 2] as Unit).unitType) { return true; }
							}else {
								//[1]
								//[1]
								//[X]
								//[1]
								if ((iRow + 3) < ROWS)
									if((MatrixUnit[iCol][iRow + 2] as Unit).unitType != "HIT_0" && (MatrixUnit[iCol][iRow] as Unit).unitType != "HIT_0" && (MatrixUnit[iCol][iRow + 1] as Unit).unitType != "HIT_0" && (MatrixUnit[iCol][iRow + 3] as Unit).unitType != "HIT_0")
										if ((MatrixUnit[iCol][iRow] as Unit).unitType == (MatrixUnit[iCol][iRow + 1] as Unit).unitType && (MatrixUnit[iCol][iRow] as Unit).unitType == (MatrixUnit[iCol][iRow + 3] as Unit).unitType) { return true; }
								//[1]
								//[X]
								//[1]
								//[1]
								if ((iRow + 3) < ROWS)
									if((MatrixUnit[iCol][iRow + 1] as Unit).unitType != "HIT_0" && (MatrixUnit[iCol][iRow + 2] as Unit).unitType != "HIT_0" && (MatrixUnit[iCol][iRow] as Unit).unitType != "HIT_0" && (MatrixUnit[iCol][iRow + 3] as Unit).unitType != "HIT_0")
										if ((MatrixUnit[iCol][iRow] as Unit).unitType == (MatrixUnit[iCol][iRow + 2] as Unit).unitType && (MatrixUnit[iCol][iRow] as Unit).unitType == (MatrixUnit[iCol][iRow + 3] as Unit).unitType) { return true; }
								//[1][0]
								//[X][1]
								//[1][0]
								//[0][0]
								if ((iRow + 2) < ROWS && (iCol + 1) < COLUMNS)
									if((MatrixUnit[iCol][iRow + 1] as Unit).unitType != "HIT_0" && (MatrixUnit[iCol + 1][iRow + 1] as Unit).unitType != "HIT_0" && (MatrixUnit[iCol][iRow] as Unit).unitType != "HIT_0" && (MatrixUnit[iCol][iRow + 2] as Unit).unitType != "HIT_0")
										if ((MatrixUnit[iCol][iRow] as Unit).unitType == (MatrixUnit[iCol + 1][iRow + 1] as Unit).unitType && (MatrixUnit[iCol][iRow] as Unit).unitType == (MatrixUnit[iCol][iRow + 2] as Unit).unitType) { return true; }
								//[0][1]
								//[1][X]
								//[0][1]
								//[0][0]
								if ((iRow + 2) < ROWS && (iCol - 1) >= 0)
									if((MatrixUnit[iCol][iRow + 1] as Unit).unitType != "HIT_0" && (MatrixUnit[iCol][iRow] as Unit).unitType != "HIT_0" && (MatrixUnit[iCol - 1][iRow + 1] as Unit).unitType != "HIT_0" && (MatrixUnit[iCol][iRow + 2] as Unit).unitType != "HIT_0")
										if ((MatrixUnit[iCol][iRow] as Unit).unitType == (MatrixUnit[iCol - 1][iRow + 1] as Unit).unitType && (MatrixUnit[iCol][iRow] as Unit).unitType == (MatrixUnit[iCol][iRow + 2] as Unit).unitType) { return true; }
								//[1][0]
								//[1][0]
								//[X][1]
								//[0][0]
								if ((iRow + 2) < ROWS && (iCol + 1) < COLUMNS)
									if((MatrixUnit[iCol][iRow + 2] as Unit).unitType != "HIT_0" && (MatrixUnit[iCol][iRow] as Unit).unitType != "HIT_0" && (MatrixUnit[iCol][iRow + 1] as Unit).unitType != "HIT_0" && (MatrixUnit[iCol + 1][iRow + 2] as Unit).unitType != "HIT_0")
										if ((MatrixUnit[iCol][iRow] as Unit).unitType == (MatrixUnit[iCol][iRow + 1] as Unit).unitType && (MatrixUnit[iCol][iRow] as Unit).unitType == (MatrixUnit[iCol + 1][iRow + 2] as Unit).unitType) { return true; }
								//[X][1]
								//[1][0]
								//[1][0]
								//[0][0]
								if ((iRow + 2) < ROWS && (iCol + 1) < COLUMNS)
									if((MatrixUnit[iCol][iRow] as Unit).unitType != "HIT_0" && (MatrixUnit[iCol + 1][iRow] as Unit).unitType != "HIT_0" && (MatrixUnit[iCol][iRow + 1] as Unit).unitType != "HIT_0" && (MatrixUnit[iCol][iRow + 2] as Unit).unitType != "HIT_0")
										if ((MatrixUnit[iCol + 1][iRow] as Unit).unitType == (MatrixUnit[iCol][iRow + 1] as Unit).unitType && (MatrixUnit[iCol + 1][iRow] as Unit).unitType == (MatrixUnit[iCol][iRow + 2] as Unit).unitType) { return true; }
								//[0][1]
								//[0][1]
								//[1][X]
								//[0][0]
								if ((iRow + 2) < ROWS && (iCol - 1) >= 0)
									if((MatrixUnit[iCol][iRow + 2] as Unit).unitType != "HIT_0" && (MatrixUnit[iCol][iRow] as Unit).unitType != "HIT_0" && (MatrixUnit[iCol][iRow + 1] as Unit).unitType != "HIT_0" && (MatrixUnit[iCol - 1][iRow + 2] as Unit).unitType != "HIT_0")
										if ((MatrixUnit[iCol][iRow] as Unit).unitType == (MatrixUnit[iCol][iRow + 1] as Unit).unitType && (MatrixUnit[iCol][iRow] as Unit).unitType == (MatrixUnit[iCol - 1][iRow + 2] as Unit).unitType) { return true; }
								//[1][X]
								//[0][1]
								//[0][1]
								//[0][0]
								if ((iRow + 2) < ROWS && (iCol - 1) >= 0)
									if((MatrixUnit[iCol][iRow] as Unit).unitType != "HIT_0" && (MatrixUnit[iCol - 1][iRow] as Unit).unitType != "HIT_0" && (MatrixUnit[iCol][iRow + 1] as Unit).unitType != "HIT_0" && (MatrixUnit[iCol][iRow + 2] as Unit).unitType != "HIT_0")
										if ((MatrixUnit[iCol - 1][iRow] as Unit).unitType == (MatrixUnit[iCol][iRow + 1] as Unit).unitType && (MatrixUnit[iCol - 1][iRow] as Unit).unitType == (MatrixUnit[iCol][iRow + 2] as Unit).unitType) {	return true; }
							}
					}
				}
			}
			
			// Если при проверке не было найдено возможных групп
			// выполняем обновление объектов игрового поля
			
			var indexCell:int = 0;
			for (var iC:int = 0; iC < COLUMNS; iC++) {
				for (var iR:int = 0; iR < ROWS; iR++) {
					if ((MatrixUnit[iC][iR] as Unit).unitType != "HIT_0") {
						var yPos:int = (MatrixUnit[iC][iR] as Unit).y;
						(MatrixUnit[iC][iR] as Unit).y = 0 + (50 * 0);	// начальная позиция спуска
						(MatrixUnit[iC][iR] as Unit).unitType = fieldBackupFileXML[0].cell[indexCell].cellObject;
						(MatrixUnit[iC][iR] as Unit).UnitUpdate();
						AnimationMoveDown((MatrixUnit[iC][iR] as Unit), (MatrixUnit[iC][iR] as Unit).x, yPos);
					}
					indexCell++;
				}
			}
			return false; // возможных комбинаций не было обнаружено (поле было обновлено и необходим спуск обновленных объектов level.AnimationMoveDown)
		}
		/* ============================================================================================ */
		
		
		
		
		
		
		
		
	}

}