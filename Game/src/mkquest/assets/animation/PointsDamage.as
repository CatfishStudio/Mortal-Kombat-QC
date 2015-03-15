package mkquest.assets.animation 
{
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.text.TextField;
	import starling.core.Starling;
	import starling.animation.Tween;
	import starling.animation.Transitions;
	
	public class PointsDamage extends Sprite 
	{
		private var text:String;
		private var color:uint;
		private var _textField:TextField;
		private var _tween:Tween;
		private var _xEnd:int = 0;
		private var _yEnd:int = 0;
		
		public function PointsDamage(_x:int, _y:int, _text:String, _color:uint) 
		{
			super();
			x = _x;
			y = _y;
			text = _text;
			color = _color;
			_textField = new TextField(100, 100, _text, "Arial", 24, _color, false);
			_textField.y = -25;
			addChild(_textField);
			
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			//addEventListener(Event.REMOVED_FROM_STAGE, onRemoveFromStage);
		}
		
		private function onAddedToStage(e:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			
			_tween = new Tween(this, 1.0, Transitions.EASE_IN_OUT);
			_tween.moveTo(this.x, 10);
			_tween.onComplete = function():void { onComplete(); };
			Starling.juggler.add(_tween);
		}
		
		
		private function onComplete():void
		{
			Starling.juggler.remove(_tween);
			_tween = null;
			_textField = null;
			this.removeFromParent(true);
			
			super.dispose();
			trace("[X] Удалена анимация очки повреждения");
		}
		
		/*
		private function onRemoveFromStage(e:Event):void 
		{
			removeEventListener(Event.REMOVED_FROM_STAGE, onRemoveFromStage);
			
			Starling.juggler.remove(_tween);
			_tween = null;
			_textField = null;
			
			super.dispose();
			trace("[X] Удалена анимация очки повреждения");
		}
		*/
		
	}

}