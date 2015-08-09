package LevelEditor 
{
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.ui.Mouse;
	import flash.ui.MouseCursor;
	
	public class FieldCell extends Sprite 
	{
		private var _cell:Sprite = new Sprite();			// ячейка
		private var _object:Sprite = new Sprite();			// объект
		public var cellType:String = "CELL_TYPE_CLEAR";		// тип ячейки
		public var cellObject:String = "HIT_0";				// объект ячейки
			
		public function FieldCell() 
		{
			super();
			this.addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			this.addEventListener(MouseEvent.CLICK, onMouseClick);
			this.addEventListener(MouseEvent.MOUSE_OUT, onMouseOut);
			this.addEventListener(MouseEvent.MOUSE_OVER, onMouseOver);
			
			_cell.graphics.lineStyle(1, 0x000000, 1);
			_cell.graphics.beginFill(0x0080FF, 0.5);
			_cell.graphics.drawRect(0, 0, 80, 80);
			_cell.graphics.endFill();
			
			_cell.addChild(_object);
			this.addChild(_cell);
		}
		
		private function onMouseOver(e:MouseEvent):void 
		{
			Mouse.cursor = MouseCursor.BUTTON;
		}
		
		private function onMouseOut(e:MouseEvent):void 
		{
			Mouse.cursor = MouseCursor.AUTO;
		}
		
		private function onMouseClick(e:MouseEvent):void 
		{
			SetObject();
		}
		
		public function SetObject():void
		{
			if (Resource.SelectObject != "SELECT_NO_OBJECT") {
				if (Resource.SelectObject == "CELL_TYPE_CLEAR") {
					cellType = "CELL_TYPE_CLEAR";
					this.removeChild(_cell);
					_cell = new Sprite();
					_cell.graphics.lineStyle(1, 0x000000, 1);
					_cell.graphics.beginFill(0x0080FF, 0.5);
					_cell.graphics.drawRect(0, 0, 80, 80);
					_cell.graphics.endFill();
					_object = new Sprite();
					_cell.addChild(_object);
					this.addChild(_cell);
				}
				if (Resource.SelectObject == "CELL_TYPE_DROP") {
					cellType = "CELL_TYPE_DROP";
					this.removeChild(_cell);
					_cell = new Sprite();
					_cell.graphics.lineStyle(1, 0x000000, 1);
					_cell.graphics.beginFill(0xCC9733, 0.5);
					_cell.graphics.drawRect(0, 0, 80, 80);
					_cell.graphics.endFill();
					_object = new Sprite();
					_cell.addChild(_object);
					this.addChild(_cell);
				}
				if (Resource.SelectObject == "HIT_1" && cellType != "CELL_TYPE_DROP") {
					cellObject = "HIT_1";
					_object.addChild(new Bitmap(Resource.Hit1.bitmapData));
				}
				if (Resource.SelectObject == "HIT_2" && cellType != "CELL_TYPE_DROP") {
					cellObject = "HIT_2";
					_object.addChild(new Bitmap(Resource.Hit2.bitmapData));
				}
				if (Resource.SelectObject == "HIT_3" && cellType != "CELL_TYPE_DROP") {
					cellObject = "HIT_3";
					_object.addChild(new Bitmap(Resource.Hit3.bitmapData));
				}
				if (Resource.SelectObject == "HIT_4" && cellType != "CELL_TYPE_DROP") {
					cellObject = "HIT_4";
					_object.addChild(new Bitmap(Resource.Hit4.bitmapData));
				}
				if (Resource.SelectObject == "HIT_5" && cellType != "CELL_TYPE_DROP") {
					cellObject = "HIT_5";
					_object.addChild(new Bitmap(Resource.Hit5.bitmapData));
				}
			}
		}
	}

}