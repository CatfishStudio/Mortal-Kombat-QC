package mkquest.assets.initialization 
{
	import mkquest.assets.xml.FileXML;
	import mkquest.assets.stairs.Enemy;
	import mkquest.assets.levels.Levels;
	import mkquest.assets.statics.Resource;
	
	public class Initialization 
	{
		/* Генератор случайный число =========================================================================== */
		private static function randomIndex():int
		{
			var indexRandom:Number = Math.random() * 10;
			var index:int = Math.round(indexRandom);
			return index;
		}
		/* =======================================================================================================*/
		
		/* =======================================================================================================
		 * 
		 * Инициализация списка врагов 
		 * (Используется в классе "Fighters" функция "showCharacteristics")
		 * 
		 * */
		public static function initEnemies(fileXML:XML, userFighterName:String):Vector.<Enemy>
		{
			var matrix:Vector.<Enemy> = new Vector.<Enemy>();
			var enemy:Enemy;
			
			var n:int = fileXML.Fighter.length();
			for (var i:int = 0; i < n; i++)
			{
				if (fileXML.Fighter[i].Name != userFighterName)
				{
					enemy = new Enemy();
					enemy.aiName = fileXML.Fighter[i].Name;
					enemy.aiHit1 = fileXML.Fighter[i].CharacterHit1;
					enemy.aiHit2 = fileXML.Fighter[i].CharacterHit2;
					enemy.aiHit3 = fileXML.Fighter[i].CharacterHit3;
					enemy.aiHit4 = fileXML.Fighter[i].CharacterHit4;
					enemy.aiHit5 = fileXML.Fighter[i].CharacterHit5;
					matrix.push(enemy);
				}
			}
			
			var ai_enemies:Vector.<Enemy> = new Vector.<Enemy>();
			
			n = fileXML.SuperFighter.length();
			for (var j:int = 0; j < n; j++)
			{
				enemy = new Enemy();
				enemy.aiName = fileXML.SuperFighter[j].Name;
				enemy.aiHit1 = fileXML.SuperFighter[j].CharacterHit1;
				enemy.aiHit2 = fileXML.SuperFighter[j].CharacterHit2;
				enemy.aiHit3 = fileXML.SuperFighter[j].CharacterHit3;
				enemy.aiHit4 = fileXML.SuperFighter[j].CharacterHit4;
				enemy.aiHit5 = fileXML.SuperFighter[j].CharacterHit5;
				ai_enemies.push(enemy);
			}
			
			var index:int;
			n = matrix.length;
			for (var k:int = n; k > 0; k--)
			{
				index = randomIndexEnemies(userFighterName, k);
				matrix[index].aiLife += 50 * (k - 1);
				ai_enemies.push(matrix[index]);
				trace("... Имя врага: " + matrix[index].aiName + " Жизнь: " + matrix[index].aiLife.toString());
				matrix.splice(index, 1);
			}
			
			trace("<- Инициализация врагов: класс Fighters функция showCharacteristics");
			return ai_enemies;
		}
		
		/* Генерация случайного индекса врага */
		private static function randomIndexEnemies(userFighterName:String, count:int):int
		{
			var index:int = randomIndex();
			var result:int = (index * count) * 0.1;
			if (result == count) result--;
			return result;
		}
		/* =======================================================================================================*/
		
		
		
		/* =======================================================================================================
		 * 
		 * Инициализация прокачки ИИ в соответствии с уровнем
		 * (Используется в классе "Fighters" функция "showCharacteristics") 
		 * 
		 * */
		public static function initEnemiesCharacteristics(matrix:Vector.<Enemy>):void
		{
			var index:int = 0;
			var experiencePoints:int = 0;
			
			var n:int = matrix.length-1;
			for (var i:int = n; i >= 0; i--)
			{
				experiencePoints = 13 - i;
				for (var j:int = 0; j < experiencePoints; j++)
				{
					index = randomIndexEnemiesCharacteristics();
					if (index == 1) matrix[i].aiHit1++;
					if (index == 2) matrix[i].aiHit2++;
					if (index == 3) matrix[i].aiHit3++;
					if (index == 4) matrix[i].aiHit4++;
					if (index == 5) matrix[i].aiHit5++;
				}
			}
			trace("<- Инициализация характеристик врагов: класс Fighters функция showCharacteristics");
		}
		
		/* Генерация случайного индекса врага */
		private static function randomIndexEnemiesCharacteristics():int
		{
			var index:int = randomIndex();
			if (index > 0 && index <= 2) return 1;
			if (index > 2 && index <= 4) return 2;
			if (index > 4 && index <= 6) return 3;
			if (index > 6 && index <= 8) return 4;
			if (index > 8 && index <= 10) return 5;
			return 1;
		}
		/* =======================================================================================================*/
		
		
		
		/* =======================================================================================================
		 *
		 * Инициализация уровней
		 * (Используется в классе "Game" функция "fighters") 
		 * 
		*/
		public static function initLevels(classFileXML:Class):Vector.<Levels>
		{
			var xmlFiles:Vector.<XML> = new Vector.<XML>();
			var backgroundsNames:Vector.<String> = new Vector.<String>();
			
			var fileXML:XML = FileXML.getFileXML(classFileXML);
			var n:int = fileXML.level.length();
			for (var i:int = 0; i < n; i++)
			{
				xmlFiles.push(getLevelFileXML(i + 1));
				backgroundsNames.push(fileXML.level[i].Background);
			}
			
			
			var vLevels:Vector.<Levels> = new Vector.<Levels>();
			var index:int;
			var objLevels:Levels;
			for (var j:int = n; j > 0; j--)
			{
				objLevels = new Levels();
				
				index = randomIndexLevels(j);
				objLevels.levelFileXML = xmlFiles[index];
				xmlFiles.splice(index, 1);
				
				index = randomIndexLevels(j);
				objLevels.backgroundFileTexture = backgroundsNames[index];
				backgroundsNames.splice(index, 1);
				
				vLevels.push(objLevels);
				trace("... Уровень: имя фона " + objLevels.backgroundFileTexture + " Файл xml номер: " + objLevels.levelFileXML.LevelNumber);
			}
			
			trace("<- Инициализация уровней: класс Game функция Level");
			return vLevels;
		}
		
		/* Получение xml файла соответствующего уровня */
		public static function getLevelFileXML(indexFile:int):XML
		{
			if (indexFile == 1) return FileXML.getFileXML(Resource.ClassXMLFileLevel1);
			if (indexFile == 2) return FileXML.getFileXML(Resource.ClassXMLFileLevel2);
			if (indexFile == 3) return FileXML.getFileXML(Resource.ClassXMLFileLevel3);
			if (indexFile == 4) return FileXML.getFileXML(Resource.ClassXMLFileLevel4);
			if (indexFile == 5) return FileXML.getFileXML(Resource.ClassXMLFileLevel5);
			if (indexFile == 6) return FileXML.getFileXML(Resource.ClassXMLFileLevel6);
			if (indexFile == 7) return FileXML.getFileXML(Resource.ClassXMLFileLevel7);
			if (indexFile == 8) return FileXML.getFileXML(Resource.ClassXMLFileLevel8);
			if (indexFile == 9) return FileXML.getFileXML(Resource.ClassXMLFileLevel9);
			if (indexFile == 10) return FileXML.getFileXML(Resource.ClassXMLFileLevel10);
			if (indexFile == 11) return FileXML.getFileXML(Resource.ClassXMLFileLevel11);
			if (indexFile == 12) return FileXML.getFileXML(Resource.ClassXMLFileLevel12);
			if (indexFile == 13) return FileXML.getFileXML(Resource.ClassXMLFileLevel13);
			return FileXML.getFileXML(Resource.ClassXMLFileLevel0);
		}
		
		/* Генерация случайного индекса врага */
		private static function randomIndexLevels(count:int):int
		{
			var index:int = randomIndex();
			var result:int = (index * count) * 0.1;
			if (result == count) result--;
			return result;
		}
		
		/* =======================================================================================================*/
		
	}

}