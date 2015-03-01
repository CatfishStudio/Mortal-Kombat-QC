package mkquest.assets.match3 
{
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.display.Image;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;
	
	public class Unit extends Sprite 
	{
		public var cellType:String = "CELL_TYPE_CLEAR";	// тип ячейки
		public var unitType:String = "CRYSTAL_TYPE_0";	// тип кристала			
		
		public var flagRemove:Boolean = false;
		public var posColumnI:int = 0;
		public var posRowJ:int = 0;
		
		private var _unitImage:Image;
		private var _textureAtlas:TextureAtlas;
		
		public function Unit(textureAtlas:TextureAtlas) 
		{
			_textureAtlas = textureAtlas;
			
			super();
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			addEventListener(Event.REMOVED, onRemoveStage);
		}
		
		private function onRemoveStage(e:Event):void 
		{
			super.dispose();
		}
		
		private function onAddedToStage(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		public function UnitShow():void
		{
			if (unitType == "HIT_0") {
				this.visible = false;
			}
			if (unitType == "HIT_1") {
				_unitImage = new Image(_textureAtlas.getTexture("hit_1.png"));
				this.addChild(_unitImage);
			}
			if (unitType == "HIT_2") {
				_unitImage = new Image(_textureAtlas.getTexture("hit_2.png"));
				this.addChild(_unitImage);
			}
			if (unitType == "HIT_3") {
				_unitImage = new Image(_textureAtlas.getTexture("hit_3.png"));
				this.addChild(_unitImage);
			}
			if (unitType == "HIT_4") {
				_unitImage = new Image(_textureAtlas.getTexture("hit_4.png"));
				this.addChild(_unitImage);
			}
			if (unitType == "HIT_5") {
				_unitImage = new Image(_textureAtlas.getTexture("hit_5.png"));
				this.addChild(_unitImage);
			}
		}
		
		
		public function UnitUpdate():void
		{
			this.removeChild(_unitImage);
			if (unitType == "HIT_0") {
				this.visible = false;
			}
			if (unitType == "HIT_1") {
				_unitImage = new Image(_textureAtlas.getTexture("hit_1.png"));
				this.addChild(_unitImage);
			}
			if (unitType == "HIT_2") {
				_unitImage = new Image(_textureAtlas.getTexture("hit_2.png"));
				this.addChild(_unitImage);
			}
			if (unitType == "HIT_3") {
				_unitImage = new Image(_textureAtlas.getTexture("hit_3.png"));
				this.addChild(_unitImage);
			}
			if (unitType == "HIT_4") {
				_unitImage = new Image(_textureAtlas.getTexture("hit_4.png"));
				this.addChild(_unitImage);
			}
			if (unitType == "HIT_5") {
				_unitImage = new Image(_textureAtlas.getTexture("hit_5.png"));
				this.addChild(_unitImage);
			}
		}
	}

}