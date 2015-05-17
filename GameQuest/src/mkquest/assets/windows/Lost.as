package mkquest.assets.windows 
{
	import flash.system.*;
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
	import mkquest.assets.sounds.MusicAndSound;
	
	public class Lost extends Sprite 
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
		
		
		public function Lost() 
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
			_quad.alpha = 0.1;
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
			
			_textField = new TextField(400, 200, "Вы проиграли! \nУ вас осталось " + String(Resource.user_continue - 1) + " из 9 жизней. \nВы можите выйти в меню и начать турнир заново. \nИли повторить попытку.", "Arial", 18, 0xFFFFFF, false);
			//_textField.hAlign = "left";
			_textField.x = 0;
			_textField.y = 10;
			addChild(_textField);
			
			
			bitmap = new TextureBorder();
			_image = new Image(Texture.fromBitmap(bitmap));
			addChild(_image);
			
			bitmap = new TextureButton();
			_button = new Button(Texture.fromBitmap(bitmap));
			_button.text = "Выйти в меню";
			_button.name = "exit";
			_button.fontColor = 0xFFFFFF;
			_button.x = 20;
			_button.y = 185;
			addChild(_button);
			
			_button = new Button(Texture.fromBitmap(bitmap));
			_button.text = "Повторить";
			_button.name = "repeat";
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
			
			if (_image != null) _image.dispose();
			_image = null;
			if (_button != null) _button.dispose();
			_button = null;
			if (_quad != null) _quad.dispose();
			_quad = null;
			if (_textField != null) _textField.dispose();
			_textField = null;
			
			super.dispose();
			System.gc();
			trace("[X] Удалено окно ПРОИГРЫША!");
		}
		
		private function onButtonsClick(event:Event):void 
		{
			MusicAndSound.PlaySound(MusicAndSound.Sound1);
			if (Button(event.target).name == "exit")
			{
				Resource.user_continue--;
				dispatchEvent(new Navigation(Navigation.CHANGE_SCREEN, true, { id: Constants.WINDOW_LOST_BACK_MENU } ));
			}
			else
			{
				Resource.user_continue--;
				dispatchEvent(new Navigation(Navigation.CHANGE_SCREEN, true, { id: Constants.WINDOW_LOST_BACK_STAIRS } ));
			}
		}
		
		
	}

}