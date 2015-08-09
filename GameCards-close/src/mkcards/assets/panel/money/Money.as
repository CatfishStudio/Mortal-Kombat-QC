package mkcards.assets.panel.money 
{
	import flash.system.*;
	import starling.text.BitmapFont;
	
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.text.TextField;
	import starling.textures.Texture;
	
	import mkcards.assets.animation.Coin;
	import mkcards.assets.statics.Constants;
	import mkcards.assets.statics.Resource;
	
	public class Money extends Sprite 
	{
		private var _textField:TextField;
		private var _coin:Coin;
		public var price:String;
		
		private var _textureFont:Texture = Texture.fromEmbeddedAsset(Resource.FontTexture);
		private	var _xmlFont:XML = XML(new Resource.FontXml());
		
		public function Money(_x:int, _y:int, _price:String) 
		{
			super();
			x = _x;
			y = _y;
			price = _price;
			width = Constants.GAME_WINDOW_WIDTH;
			height = Constants.GAME_WINDOW_HEIGHT;
			name = Constants.PANEL_MONEY;
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			addEventListener(Event.REMOVED_FROM_STAGE, onRemoveFromStage);
		}
		
		private function onAddedToStage(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			
			TextField.registerBitmapFont(new BitmapFont(_textureFont, _xmlFont), "Font01");
			
			_coin = new Coin(0, 0);
			_coin.scaleX -= 0.5;
			_coin.scaleY -= 0.5;
			addChild(_coin);
			
			_textField = new TextField(100, 50, price, "Arial", 18, 0xFFFFFF, false);
			_textField.hAlign = "center";
			_textField.fontName = "Font01";
			_textField.x = 10;
			_textField.y = -5;
			addChild(_textField);
			
			if (_coin) _coin.dispose()
			_coin = null;
		}
		
		private function onRemoveFromStage(e:Event):void 
		{
			removeEventListener(Event.REMOVED_FROM_STAGE, onRemoveFromStage);
			
			if (_textField) _textField.dispose();
			_textField = null;
			
			if (_coin) _coin.dispose()
			_coin = null;
			
			while (this.numChildren)
			{
				this.removeChildren(0, -1, true);
			}
			this.removeFromParent(true);
			super.dispose();
			System.gc();
			trace("[X] onRemoveFromStage: " + this.name);
		}
		
		public function setMoney(_price:String):void
		{
			price = _price;
			_textField.text = price;
		}
	}

}