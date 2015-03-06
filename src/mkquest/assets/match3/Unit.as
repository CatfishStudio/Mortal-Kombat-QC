package mkquest.assets.match3 
{
	import flash.ui.Mouse;
	import flash.ui.MouseCursor;
	
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.display.Image;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	
	public class Unit extends Sprite 
	{
		public var cellType:String = "CELL_TYPE_CLEAR";	// тип Cell
		public var unitType:String = "HIT_0";			// тип Unit			
		
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
			addEventListener(Event.REMOVED_FROM_STAGE, onRemoveStage);
			addEventListener(TouchEvent.TOUCH, onUnitTouch);
		}
		
		private function onRemoveStage(e:Event):void 
		{
			super.dispose();
		}
		
		private function onAddedToStage(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		
		private static function onUnitTouch(e:TouchEvent):void 
		{
			var touch:Touch = e.getTouch(Match3.field.stage);
			if (touch)
			{
				if (touch.phase == TouchPhase.BEGAN)
				{
					Mouse.cursor = MouseCursor.BUTTON;
					
					Match3.field.dispatchEvent(new Events(Events.MATCH_3_EVENTS, true, { id: Match3.ON_UNIT_CLICK })); // СОБЫТИЕ 
					
					if (Match3.fieldBlocked == false) // Игровое поле разблокировано
					{	
						if (Match3.unit1 == null)
						{
							Match3.unit1 = (e.currentTarget as Unit);
							Match3.CellColorEdit(Match3.unit1.posColumnI, Match3.unit1.posRowJ);
						}
						else 
						{
							if ((e.currentTarget as Unit) != Match3.unit1) 
							{
								Match3.fieldBlocked = true;
								Match3.unit2 = (e.currentTarget as Unit);
								Match3.CellColorEdit(Match3.unit2.posColumnI, Match3.unit2.posRowJ);
								if (Match3.unit2.posColumnI > (Match3.unit1.posColumnI - 2) && Match3.unit2.posColumnI < (Match3.unit1.posColumnI + 2) && Match3.unit2.posRowJ > (Match3.unit1.posRowJ - 2) && Match3.unit2.posRowJ < (Match3.unit1.posRowJ + 2) && (Match3.unit2.posColumnI == Match3.unit1.posColumnI || Match3.unit2.posRowJ == Match3.unit1.posRowJ))
								{
									Match3.ExchangeUnits(Match3.unit1.posColumnI, Match3.unit1.posRowJ, Match3.unit2.posColumnI, Match3.unit2.posRowJ);
									Match3.field.dispatchEvent(new Events(Events.MATCH_3_EVENTS, true, { id: Match3.ON_USER_MOVE } )); // СОБЫТИЕ
								}
								else
								{
									//if (Match3.modeAI == false) Match3.RecoveryField();
									//else Match3.RecoveryFieldAI();
									Match3.RecoveryField();
								}
							}
							else
							{
								if (Match3.modeAI == false) Match3.RecoveryField();
								else Match3.RecoveryFieldAI();
							}
						}
					}
				}
				else if (touch.phase == TouchPhase.ENDED)
				{
					Mouse.cursor = MouseCursor.AUTO;
				}
				else if (touch.phase == TouchPhase.HOVER)
				{
					Mouse.cursor = MouseCursor.AUTO;
				}
				else if (touch.phase == TouchPhase.MOVED)
				{
					Mouse.cursor = MouseCursor.BUTTON;
				}
			}
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