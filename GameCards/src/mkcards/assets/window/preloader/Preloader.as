package mkcards.assets.window.preloader 
{
	import flash.system.*;
	
	import starling.display.Sprite;
	import starling.events.Event;
	
	import mkcards.assets.animation.Spinner;
	import mkcards.assets.statics.Constants;
	import mkcards.assets.statics.Resource;
	
	public class Preloader extends Sprite 
	{
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
		}
		
		private function onRemoveFromStage(e:Event):void 
		{
			removeEventListener(Event.REMOVED_FROM_STAGE, onRemoveFromStage);
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