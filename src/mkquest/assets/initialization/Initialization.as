package mkquest.assets.initialization 
{
	import mkquest.assets.stairs.Enemy;
	
	public class Initialization 
	{
		/* Генератор случайный число */
		private static function randomIndex():int
		{
			var indexRandom:Number = Math.random() * 10;
			var index:int = Math.round(indexRandom);
			return index;
		}
		
		/* Генерация случайного индекса врага */
		private static function randomIndexEnemies(userFighterName:String, count:int):int
		{
			var index:int = randomIndex();
			var result:int = (index * count) * 0.1;
			if (result == count) result--;
			return result;
		}
		
		
		/* Инициализация списка врагов 
		 * (Используется в классе "Fighters" функция "showCharacteristics" 
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
			trace(n);
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
				ai_enemies.push(matrix[index]);
				matrix.splice(index, 1);
			}
			
			return ai_enemies;
		}
		
		
		
		
		
	}

}