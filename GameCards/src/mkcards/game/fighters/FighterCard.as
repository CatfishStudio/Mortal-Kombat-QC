package mkcards.game.fighters 
{
	import starling.display.Sprite;
	import starling.text.TextField;
	
	public class FighterCard extends Sprite 
	{
		private var _textField:TextField;
		private var _damage:int;
		private var _protection:int;
		private var _life:int;
		private var _mana:int;
		private var _price:int;
		private var _index:int;
		
		
		public function FighterCard() 
		{
			super();
			
		}
	
		public function get Price():int
		{
			return _price;
		}
		
		public function set Price(value:int):void
		{
			_price = value;
		}
		
		public function get Index():int
		{
			return _index;
		}
		
		public function set Index(value:int):void
		{
			_index = value;
		}
		
		public function specifications(damage:int, protection:int, life:int, mana:int):void
		{
			_damage = damage;
			_protection = protection;
			_life = life;
			_mana = mana;
			
			_textField = new TextField(100, 100, damage.toString(), "Aria", 27, 0xffffff, false);
			_textField.hAlign = "left";
			_textField.x = 5;
			_textField.y = 200;
			addChild(_textField);
			
			_textField = new TextField(100, 100, protection.toString(), "Aria", 27, 0xffffff, false);
			_textField.hAlign = "left";
			_textField.x = 5;
			_textField.y = 5;
			addChild(_textField);
			
			_textField = new TextField(100, 100, life.toString(), "Aria", 27, 0xffffff, false);
			_textField.hAlign = "left";
			_textField.x = 165;
			_textField.y = 200;
			addChild(_textField);
			
			_textField = new TextField(100, 100, mana.toString(), "Aria", 27, 0xffffff, false);
			_textField.hAlign = "left";
			_textField.x = 165;
			_textField.y = 5;
			addChild(_textField);
		}
	}

}