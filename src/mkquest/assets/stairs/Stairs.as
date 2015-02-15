package mkquest.assets.stairs 
{
	import starling.core.Starling;
	import starling.animation.Tween;
	import starling.animation.Transitions;
	import starling.display.Sprite;
	import starling.events.Event;
	
	import mkquest.assets.xml.FileXML;
	import mkquest.assets.events.Navigation;
	import mkquest.assets.statics.Constants;
	import mkquest.assets.statics.Resource;
	
	public class Stairs extends Sprite
	{
		[Embed(source = 'Stair.xml', mimeType='application/octet-stream')]
		private var ClassFileXML:Class;
		private var _fileXML:XML = FileXML.getFileXML(ClassFileXML);
		
		private var _tween:Tween;
		private var _xStart:int;
		private var _yStart:int;
		private var _xEnd:int;
		private var _yEnd:int;

		public function Stairs() 
		{
			super();
			this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			this.addEventListener(Event.REMOVED, onRemoveStage);
		}
		
		private function onRemoveStage(e:Event):void
		{
			Starling.juggler.remove(_tween);
		}

		private function onAddedToStage(e:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			this.x = _xStart; 
			this.y = _yStart;

			animation();
		}

		private function animation():void
		{
			_tween = new Tween(this, 1.0);

			if (this.x == _xStart && this.y == _yStart) 
			{
				_tween.moveTo(_xEnd, _yEnd);
			}
			if (this.x == _xEnd && this.y == _yEnd)
			{
				_tween.moveTo(_xStart, _yStart);
			}

			_tween.onComplete = animation;
			Starling.juggler.add(_tween);
		}
		
		
	}

}