package mkcards.game.fighters 
{
	import starling.display.Sprite;
	import starling.text.TextField;
	
	import mkcards.game.cards.Card;
	
	public class FighterCard extends Sprite 
	{
		private var _textField:TextField;
		private var _damage:int;			// Урон
		private var _protection:int;		// Защита
		private var _life:int;				// Жизнь
		private var _mana:int;				// Мана
		private var _price:int;				// Цена
		private var _index:int;				// индекс
		private var _cards:Vector.<Card> = new Vector.<Card>();	// колода карт (Name, View, Type, Skill, Damage, Protection, Life, Action, Mana, Price)
		
		public function FighterCard() 
		{
			super();
		}
		
		public function get Cards():Vector.<Card>
		{
			return _cards;
		}
		
		public function set Cards(value:Vector.<Card>):void
		{
			_cards = value;
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