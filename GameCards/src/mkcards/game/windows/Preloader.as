package mkcards.game.windows 
{
	import flash.system.*;
	
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.text.TextField;
	
	import mkcards.game.animation.Spinner;
	import mkcards.game.statics.Constants;
	import mkcards.game.statics.Resource;
	
	public class Preloader extends Sprite 
	{
		private var _textField:TextField;
		
		public function Preloader() 
		{
			super();
			x = 0;
			y = 0;
			width = Constants.GAME_WINDOW_WIDTH;
			height = Constants.GAME_WINDOW_HEIGHT;
			name = Constants.WINDOW_PRELOADER;
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			addEventListener(Event.REMOVED_FROM_STAGE, onRemoveFromStage);
		}
		
		private function onAddedToStage(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			addChild(new Spinner((Constants.GAME_WINDOW_HEIGHT / 2) + 20, Constants.GAME_WINDOW_WIDTH / 2));
			
			_textField = new TextField(600, 200, "Загрузка... \n\nПожалуйста подождите пока не закончится загрузка данных с сервера. \n Если загрузка не заканчивается, попробуйте очистить кэш и обновить страницу.", "Arial", 16, 0xFF6F6F, false);
			_textField.hAlign = "center";
			_textField.x = Constants.GAME_WINDOW_HEIGHT / 5.5;
			_textField.y = Constants.GAME_WINDOW_WIDTH / 3.5;
			addChild(_textField);
		}
		
		private function onRemoveFromStage(e:Event):void 
		{
			removeEventListener(Event.REMOVED_FROM_STAGE, onRemoveFromStage);
			
			if (_textField) _textField.dispose();
			_textField = null;
			while (this.numChildren)
			{
				this.removeChildren(0, -1, true);
			}
			this.removeFromParent(true);
			super.dispose();
			System.gc();
			trace("[X] onRemoveFromStage: " + this.name);
		}
		
	}

}