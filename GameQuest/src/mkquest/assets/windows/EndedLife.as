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
	import mkquest.assets.sounds.MusicAndSound;
	
	public class EndedLife extends Sprite 
	{
		[Embed(source = '../media/textures/window_border.png')]
		public static var TextureBorder:Class;
		[Embed(source = '../media/textures/button.png')]
		public static var TextureButton:Class;
		
		private var _image:Image;
		private var _button:Button;
		private var _quad:Quad;
		private var _textField:TextField;
		
		public function EndedLife() 
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
			name = Constants.WINDOW_ENDED_LIFE;
			
			
			_quad = new Quad(Constants.GAME_WINDOW_WIDTH, Constants.GAME_WINDOW_HEIGHT,  0x000000, true);
			_quad.alpha = 0.5;
			_quad.x = 0 - this.x;
			_quad.y = 0 - this.y;
			addChild(_quad);
			
			
			_quad = new Quad(Constants.GAME_WINDOW_WIDTH, Constants.GAME_WINDOW_HEIGHT,  0x000000, true);
			_quad.alpha = 0.9;
			_quad.setVertexColor(0, 0x000000);
			_quad.setVertexColor(1, 0x220000);
			_quad.setVertexColor(2, 0x220000);
			_quad.setVertexColor(3, 0x000000);
			_quad.x = 0;
			_quad.y = 0;
			_quad.width = 400;
			_quad.height = 254;
			addChild(_quad);
			
			_textField = new TextField(400, 200, "У вас закончились жизни " + Resource.user_continue + " из 9. \nВы можите выйти в меню и начать турнир заново. \n\nИли пригласите в игру друга и получите в подарок жизнь.", "Arial", 18, 0xFFFFFF, false);
			//_textField.hAlign = "left";
			_textField.x = 0;
			_textField.y = 0;
			addChild(_textField);
			
			
			var bitmap:Bitmap = new TextureBorder();
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
			_button.text = "Позвать друга";
			_button.name = "friend";
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
			trace("[X] Удалено окно ENDED LIFE");
		}
		
		private function onButtonsClick(event:Event):void 
		{
			MusicAndSound.PlaySound(MusicAndSound.Sound1);
			if (Button(event.target).name == "exit")
			{
				dispatchEvent(new Navigation(Navigation.CHANGE_SCREEN, true, { id: Constants.WINDOW_ENDED_LIFE_STAIRS_BACK_MENU } ));
			}
			else
			{
				dispatchEvent(new Navigation(Navigation.CHANGE_SCREEN, true, { id: Constants.WINDOW_ENDED_LIFE_INVITE_FRIENDS } ));
			}
		}
		
		
		
	}

}