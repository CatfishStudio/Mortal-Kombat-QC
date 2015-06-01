package mkcards.assets.animation 
{
	import flash.system.*;
	//import flash.utils.ByteArray;
	
	import starling.events.Event;
	import starling.display.MovieClip;
	import starling.core.Starling;
	import starling.events.EventDispatcher;
	
	import mkcards.assets.statics.Constants;
	import mkcards.assets.statics.Resource;
	
	public class Spinner extends MovieClip 
	{
		public function Spinner(_x:int, _y:int) 
		{
			Resource.setTextureAtlasEmbeddedAsset(Resource.AtlasSpinner, Resource.AtlasSpinnerXML);
			super(Resource.textureAtlasAnimation.getTextures("spinner_"), 12);
			x = _x;
			y = _y;
			name = Constants.ANIMATION_SPINNER;
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			addEventListener(Event.REMOVED_FROM_STAGE, onRemoveFromStage);
		}
		
		
		private function onAddedToStage(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
						
			loop = true;
			play();
			
			Starling.juggler.add(this);
		}
		
		private function onRemoveFromStage(e:Event):void 
		{
			removeEventListener(Event.REMOVED_FROM_STAGE, onRemoveFromStage);
			
			stop();
			Starling.juggler.removeTweens(this);
			
			Resource.disposeTextureAtlasAnimation(); // очистка атласа
			
			while (this.numFrames > 1)
			{
				this.removeFrameAt(0);
			}
			this.removeFromParent(true);
			super.dispose();
			System.gc();
			trace("[X] onRemoveFromStage: " + this.name);
		}
		
	}

}