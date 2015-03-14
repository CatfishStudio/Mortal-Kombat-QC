package mkquest.assets.windows 
{
	import flash.display.Bitmap;
	
	import starling.display.Button;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.textures.Texture;
	import starling.display.Quad;
	import starling.text.TextField;
	
	import mkquest.assets.statics.Resource;
	import mkquest.assets.statics.Constants;
	import mkquest.assets.events.Navigation;
	import mkquest.assets.animation.Dragon;
	
	public class Victory extends Sprite 
	{
		[Embed(source = '../media/textures/window_background.png')]
		public static var TextureBackground:Class;
		[Embed(source = '../media/textures/window_border.png')]
		public static var TextureBorder:Class;
		[Embed(source = '../media/textures/button.png')]
		public static var TextureButton:Class;
		
		private var _image:Image;
		private var _button:Button;
		private var _quad:Quad;
		private var _dragon:Dragon;
		private var _textField:TextField;
		
		public function Victory() 
		{
			super();
			x = Constants.GAME_WINDOW_WIDTH / 3.8;
			y = Constants.GAME_WINDOW_HEIGHT / 4;
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			addEventListener(Event.REMOVED_FROM_STAGE, onRemoveFromStage);
			addEventListener(Event.TRIGGERED, onButtonsClick);
		}
		
		private function onAddedToStage(e:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			name = Constants.WINDOW_LOST;
			
			
			_quad = new Quad(Constants.GAME_WINDOW_WIDTH, Constants.GAME_WINDOW_HEIGHT,  0x000000, true);
			_quad.alpha = 0.5;
			_quad.x = 0 - this.x;
			_quad.y = 0 - this.y;
			addChild(_quad);
			
			
			var bitmap:Bitmap = new TextureBackground();
			_image = new Image(Texture.fromBitmap(bitmap));
			addChild(_image);
			
			_dragon = new Dragon(0, 0, "drugon_left_");
			addChild(_dragon);
			_dragon = new Dragon(320, 0, "drugon_right_");
			addChild(_dragon);
			
			_textField = new TextField(400, 200, "Вы победили! \nОчки за битву " + Resource.totalPointsPlayerLevel.toString(), "Arial", 18, 0xFFFFFF, false);
			//_textField.hAlign = "left";
			_textField.x = 0;
			_textField.y = 10;
			addChild(_textField);
			
			
			bitmap = new TextureBorder();
			_image = new Image(Texture.fromBitmap(bitmap));
			addChild(_image);
			
			bitmap = new TextureButton();
			_button = new Button(Texture.fromBitmap(bitmap));
			_button.text = "Рассказать";
			_button.name = "post";
			_button.fontColor = 0xFFFFFF;
			_button.x = 20;
			_button.y = 185;
			addChild(_button);
			
			_button = new Button(Texture.fromBitmap(bitmap));
			_button.text = "Продолжить";
			_button.name = "next";
			_button.fontColor = 0xFFFFFF;
			_button.x = 200;
			_button.y = 185;
			addChild(_button);
			
			bitmap = null;
			_image.dispose();
			_image = null;
		}
		
		
		private function onRemoveFromStage(e:Event):void
		{
			removeEventListener(Event.REMOVED_FROM_STAGE, onRemoveFromStage);
			super.dispose();
			trace("[X] Удалено окно ПРОИГРЫША!");
		}
		
		private function onButtonsClick(event:Event):void 
		{
			if (Button(event.target).name == "post")
			{
				dispatchEvent(new Navigation(Navigation.CHANGE_SCREEN, true, { id: Constants.WINDOW_VICTORY_POST } ));
			}
			if (Button(event.target).name == "next")
			{
				Resource.tournamentProgress--;
				Resource.experiencePoints++;
				Resource.totalPointsPlayerTournament += Resource.totalPointsPlayerLevel;
				dispatchEvent(new Navigation(Navigation.CHANGE_SCREEN, true, { id: Constants.WINDOW_VICTORY_NEXT } ));
			}
		}
		
	}

}