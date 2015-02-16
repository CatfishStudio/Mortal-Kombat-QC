package mkquest.assets.stairs 
{
	import starling.core.Starling;
	import starling.animation.Tween;
	import starling.animation.Transitions;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	
	import mkquest.assets.xml.FileXML;
	import mkquest.assets.events.Navigation;
	import mkquest.assets.statics.Constants;
	import mkquest.assets.statics.Resource;
	
	public class Stairs extends Sprite
	{
		[Embed(source = 'Stairs.xml', mimeType='application/octet-stream')]
		private var ClassFileXML:Class;
		private var _fileXML:XML = FileXML.getFileXML(ClassFileXML);
		
		private var _tween:Tween;
		private var _xStart:int;
		private var _yStart:int;
		private var _xEnd:int;
		private var _yEnd:int;
		
		private var _image:Image;

		public function Stairs() 
		{
			super();
			this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			this.addEventListener(Event.REMOVED, onRemoveStage);
		}
		
		private function onAddedToStage(e:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			
			width = Constants.MK_WINDOW_WIDTH;
			height = Constants.MK_WINDOW_HEIGHT;
			name = Constants.MK_WINDOW_STAIRS;
			
			createStairsFromXML();
			
			animation();
		}
		
		private function createStairsFromXML():void
		{
			_image = new Image(Resource.textureAtlas.getTexture(_fileXML.Background));
			_image.scaleX += 1;
			_image.scaleY += 1.35;
			addChild(_image);
			
			
			_image = new Image(Resource.textureAtlas.getTexture(_fileXML.Border));
			addChild(_image);
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
		
		private function onRemoveStage(e:Event):void
		{
			Starling.juggler.remove(_tween);
			_tween = null;
			_image.dispose();
			_image = null;
			
			while (this.numChildren)
			{
				this.removeChildAt(0, true);
			}
			this.removeFromParent(true);
		}
	}

}