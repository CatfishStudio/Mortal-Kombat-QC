package mkquest
{
	import flash.display3D.Context3DRenderMode;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.geom.Rectangle;
	
	import starling.core.Starling;
	import starling.display.Stage;
	
	import mkquest.assets.Game;
	
	[SWF(width="860", height="730", frameRate="30", backgroundColor="#ffffff")]
	public class Main extends Sprite 
	{
		private var _starling:Starling;
		
		public function Main():void 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			initializationStarling();
		}
		
		private function initializationStarling():void
		{
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.addEventListener (Event.RESIZE, resizeListenerFlash);
			_starling = new Starling(Game, stage, null, null, Context3DRenderMode.SOFTWARE);
			_starling.antiAliasing = 1;
			_starling.start();
		}
		
		private function resizeListenerFlash(event:Event):void
		{
			Starling.current.viewPort = new Rectangle (0, 0, stage.stageWidth, stage.stageHeight);
			_starling.stage.stageWidth = 860;
			_starling.stage.stageHeight = 730;
		}
	}
	
}