package mkquest.assets.animation 
{
	import starling.events.Event;
	import starling.display.MovieClip;
	import starling.core.Starling;
	
	import mkquest.assets.statics.Constants;
	import mkquest.assets.statics.Resource;
	
	public class Spinner extends MovieClip 
	{
		
		public function Spinner(_x:int, _y:int) 
		{
			Resource.textureAtlas = Resource.getTextureAtlasEmbeddedAsset(Resource.AtlasSpritesSpinner, Resource.AtlasSpritesSpinnerXML);
			super(Resource.textureAtlas.getTextures("spinner_"), 10);
			x = _x;
			y = _y;
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			addEventListener(Event.REMOVED_FROM_STAGE, onRemoveFromStage);
		}
		
		private function onAddedToStage(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			name = Constants.SPINNER;
						
			loop = true;
			play();
			
			Starling.juggler.add(this);
		}
		
		private function onRemoveFromStage(e:Event):void 
		{
			removeEventListener(Event.REMOVED_FROM_STAGE, onRemoveFromStage);
			while (this.numFrames > 1)
			{
				this.removeFrameAt(0);
			}
			Starling.juggler.removeTweens(this);
			this.removeFromParent(true);
			stop();
		}
		
	}

}