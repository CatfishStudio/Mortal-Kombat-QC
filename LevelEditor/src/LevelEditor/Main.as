package LevelEditor
{
	import flash.display.Sprite;
	import flash.events.Event;
	import LevelEditor.Editor;
	
	public class Main extends Sprite 
	{
		private var _editor:Editor;
		
		public function Main():void 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			showEditor();
		}
		
		private function showEditor():void
		{
			_editor = new Editor();
			_editor.addEventListener(Event.CLEAR, onCrearHandler);
			this.addChild(_editor);
		}
		
		private function onCrearHandler(e:Event):void 
		{
			this.removeChild(_editor); 
			showEditor();
		}
	}
	
}