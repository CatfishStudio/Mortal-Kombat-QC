package LevelEditor 
{
	import flash.display.Sprite;
	import flash.display.Bitmap;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.ui.Mouse;
	import flash.ui.MouseCursor;
	import flash.events.MouseEvent;
	
	import LevelEditor.Resource;
	
	import fl.controls.Label;
	
	public class PanelObjects extends Sprite 
	{
		private var _label1:Label = new Label();
		private var _sCursor:Sprite = new Sprite();
		private var _cellClear:Sprite = new Sprite();
		private var _cellDrop:Sprite = new Sprite();
		private var _hit1:Sprite = new Sprite();
		private var _hit2:Sprite = new Sprite();
		private var _hit3:Sprite = new Sprite();
		private var _hit4:Sprite = new Sprite();
		private var _hit5:Sprite = new Sprite();
		
		public function PanelObjects() 
		{
			super();
			this.addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			/* Загрузка картинок юнитов */
			Resource.Hit1 = new Bitmap(Resource.AtlasGetBitmap(Resource.Hits, 400, 80, 80, 80, true, 0x000000000000, 0, 0, 80, 80, 0, 0).bitmapData);
			Resource.Hit2 = new Bitmap(Resource.AtlasGetBitmap(Resource.Hits, 400, 80, 80, 80, true, 0x000000000000, 80, 0, 80, 80, 0, 0).bitmapData);
			Resource.Hit3 = new Bitmap(Resource.AtlasGetBitmap(Resource.Hits, 400, 80, 80, 80, true, 0x000000000000, 160, 0, 80, 80, 0, 0).bitmapData);
			Resource.Hit4 = new Bitmap(Resource.AtlasGetBitmap(Resource.Hits, 400, 80, 80, 80, true, 0x000000000000, 240, 0, 80, 80, 0, 0).bitmapData);
			Resource.Hit5 = new Bitmap(Resource.AtlasGetBitmap(Resource.Hits, 400, 80, 80, 80, true, 0x000000000000, 320, 0, 80, 80, 0, 0).bitmapData);
			
			/* объекты ----------------------------*/
			/* Метка */
			_label1.text = "Объекты:";
			_label1.x = 20; _label1.y = 200;
			this.addChild(_label1);
			
			/* Курсор */
			_sCursor.addChild(Resource.Cursor);
			_sCursor.name = "sCursor";
			_sCursor.x = 20; _sCursor.y = 220;
			_sCursor.addEventListener(MouseEvent.CLICK, onMouseClick);
			_sCursor.addEventListener(MouseEvent.MOUSE_OUT, onMouseOut);
			_sCursor.addEventListener(MouseEvent.MOUSE_OVER, onMouseOver);
			this.addChild(_sCursor);
			
			/* пустая ячейка */
			_cellClear.addChild(Resource.CellClear);
			_cellClear.name = "cellClear";
			_cellClear.x = 120; _cellClear.y = 220;
			_cellClear.addEventListener(MouseEvent.CLICK, onMouseClick);
			_cellClear.addEventListener(MouseEvent.MOUSE_OUT, onMouseOut);
			_cellClear.addEventListener(MouseEvent.MOUSE_OVER, onMouseOver);
			this.addChild(_cellClear);
			
			/* удаленная ячейка */
			_cellDrop.addChild(Resource.CellDrop);
			_cellDrop.name = "cellDrop";
			_cellDrop.x = 220; _cellDrop.y = 220;
			_cellDrop.addEventListener(MouseEvent.CLICK, onMouseClick);
			_cellDrop.addEventListener(MouseEvent.MOUSE_OUT, onMouseOut);
			_cellDrop.addEventListener(MouseEvent.MOUSE_OVER, onMouseOver);
			this.addChild(_cellDrop);
			
			/* Удары */
			_hit1.addChild(Resource.Hit1);
			_hit1.name = "hit1";
			_hit1.x = 20; _hit1.y = 300;
			_hit1.addEventListener(MouseEvent.CLICK, onMouseClick);
			_hit1.addEventListener(MouseEvent.MOUSE_OUT, onMouseOut);
			_hit1.addEventListener(MouseEvent.MOUSE_OVER, onMouseOver);
			this.addChild(_hit1);
			
			_hit2.addChild(Resource.Hit2);
			_hit2.name = "hit2";
			_hit2.x = 110; _hit2.y = 300;
			_hit2.addEventListener(MouseEvent.CLICK, onMouseClick);
			_hit2.addEventListener(MouseEvent.MOUSE_OUT, onMouseOut);
			_hit2.addEventListener(MouseEvent.MOUSE_OVER, onMouseOver);
			this.addChild(_hit2);
			
			_hit3.addChild(Resource.Hit3);
			_hit3.name = "hit3";
			_hit3.x = 200; _hit3.y = 300;
			_hit3.addEventListener(MouseEvent.CLICK, onMouseClick);
			_hit3.addEventListener(MouseEvent.MOUSE_OUT, onMouseOut);
			_hit3.addEventListener(MouseEvent.MOUSE_OVER, onMouseOver);
			this.addChild(_hit3);
			
			_hit4.addChild(Resource.Hit4);
			_hit4.name = "hit4";
			_hit4.x = 20; _hit4.y = 400;
			_hit4.addEventListener(MouseEvent.CLICK, onMouseClick);
			_hit4.addEventListener(MouseEvent.MOUSE_OUT, onMouseOut);
			_hit4.addEventListener(MouseEvent.MOUSE_OVER, onMouseOver);
			this.addChild(_hit4);
			
			_hit5.addChild(Resource.Hit5);
			_hit5.name = "hit5";
			_hit5.x = 110; _hit5.y = 400;
			_hit5.addEventListener(MouseEvent.CLICK, onMouseClick);
			_hit5.addEventListener(MouseEvent.MOUSE_OUT, onMouseOut);
			_hit5.addEventListener(MouseEvent.MOUSE_OVER, onMouseOver);
			this.addChild(_hit5);
			
		}
		
		private function onMouseClick(e:MouseEvent):void 
		{
			if (e.target.name == "sCursor")	Resource.SelectObject = "SELECT_NO_OBJECT";
			if (e.target.name == "cellClear")	Resource.SelectObject = "CELL_TYPE_CLEAR";
			if (e.target.name == "cellDrop")	Resource.SelectObject = "CELL_TYPE_DROP";
			if (e.target.name == "hit1")	Resource.SelectObject = "HIT_1";
			if (e.target.name == "hit2")	Resource.SelectObject = "HIT_2";
			if (e.target.name == "hit3")	Resource.SelectObject = "HIT_3";
			if (e.target.name == "hit4")	Resource.SelectObject = "HIT_4";
			if (e.target.name == "hit5")	Resource.SelectObject = "HIT_5";
		}
		
		
		/* Общие события мыши */
		private function onMouseOver(e:MouseEvent):void 
		{
			Mouse.cursor = MouseCursor.BUTTON;
		}
		
		private function onMouseOut(e:MouseEvent):void 
		{
			Mouse.cursor = MouseCursor.AUTO;
		}
	}

}