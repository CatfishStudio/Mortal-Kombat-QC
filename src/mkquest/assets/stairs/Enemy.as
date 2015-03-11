package mkquest.assets.stairs 
{
	public class Enemy 
	{
		private var _ai_name:String;		// Имя бойца ИИ
		private var _ai_hit_1:int = 0;		// Удар ногой
		private var _ai_hit_2:int = 0;		// Удар рукой
		private var _ai_hit_3:int = 0;		// Блок
		private var _ai_hit_4:int = 0;		// Апперкот
		private var _ai_hit_5:int = 0;		// С разворота
		private var _ai_life:int = 200;		// количество жизни
		
		public function Enemy() 
		{
			super();
		}
		
		public function get aiName():String
		{
			return _ai_name;
		}

		public function set aiName(value:String):void
		{
			_ai_name = value;
		}
		
		public function get aiHit1():int
		{
			return _ai_hit_1;
		}

		public function set aiHit1(value:int):void
		{
			_ai_hit_1 = value;
		}
		
		public function get aiHit2():int
		{
			return _ai_hit_2;
		}

		public function set aiHit2(value:int):void
		{
			_ai_hit_2 = value;
		}
		
		public function get aiHit3():int
		{
			return _ai_hit_3;
		}

		public function set aiHit3(value:int):void
		{
			_ai_hit_3 = value;
		}
		
		public function get aiHit4():int
		{
			return _ai_hit_4;
		}

		public function set aiHit4(value:int):void
		{
			_ai_hit_4 = value;
		}
		
		public function get aiHit5():int
		{
			return _ai_hit_5;
		}

		public function set aiHit5(value:int):void
		{
			_ai_hit_5 = value;
		}
		
		public function get aiLife():int
		{
			return _ai_life;
		}

		public function set aiLife(value:int):void
		{
			_ai_life = value;
		}
	}

}