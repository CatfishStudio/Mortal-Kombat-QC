package mkquest.assets.match3 
{
	import flash.system.*;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.display.Quad;
	
	public class Cell extends Sprite 
	{
		public var cellType:String = "CELL_TYPE_CLEAR";	// тип ячейки
		private var _cellBG:Quad;
		private var _cell:Quad;
		
		public function Cell() 
		{
			super();
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			addEventListener(Event.REMOVED, onRemoveStage);
		}
		
		private function onRemoveStage(e:Event):void 
		{
			_cell.dispose();
			_cell = null;
			_cellBG.dispose();
			_cellBG = null;
			super.dispose();
			System.gc();
		}
		
		private function onAddedToStage(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			
			if (cellType == "CELL_TYPE_EMPTY") this.visible = false;
			if (cellType == "CELL_TYPE_CLEAR") {
				_cellBG = new Quad(Match3.CELL_WIDTH, Match3.CELL_HEIGHT, 0x000000, true); //0x8000FF
				_cellBG.alpha = 0.4;
				this.addChild(_cellBG);
				_cell = new Quad(Match3.CELL_WIDTH, Match3.CELL_HEIGHT, 0x000000, true); // 0x8000FF
				_cell.width = 78; 
				_cell.height = 78;
				_cell.alpha = 0.6;
				this.addChild(_cell);
			}
		}
		
		public function setBackgroundColor(colorBG:uint):void
		{
			_cellBG.color = colorBG;
		}
		
		public function setBackgroundGradientColor(topColor:uint, bottomColor:uint, leftColor:uint, rightColor:uint):void
		{
			_cellBG.setVertexColor(0, topColor);
			_cellBG.setVertexColor(1, leftColor);
			_cellBG.setVertexColor(2, bottomColor);
			_cellBG.setVertexColor(3, rightColor);
		}
		
	}

}