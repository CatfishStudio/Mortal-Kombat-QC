package mkquest.assets.windows 
{
	import flash.system.*;
	import flash.display.Bitmap;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.display.Button;
	import starling.display.Image;
	import starling.textures.Texture;
	
	import mkquest.assets.statics.Resource;
	import mkquest.assets.statics.Constants;
	import mkquest.assets.events.Navigation;
	import mkquest.assets.sounds.MusicAndSound;
	
	
	public class EndGame extends Sprite 
	{
		[Embed(source = '../media/textures/end_game.jpg')]
		public static var TextureBG:Class;
		[Embed(source = '../media/textures/button.png')]
		public static var TextureButton:Class;
		
		private var _image:Image;
		private var _button:Button;
		
		public function EndGame() 
		{
			super();
			x = (Constants.GAME_WINDOW_WIDTH - Constants.MK_WINDOW_WIDTH) / 2;
			y = (Constants.GAME_WINDOW_HEIGHT - Constants.MK_WINDOW_HEIGHT) / 2;
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			addEventListener(Event.REMOVED_FROM_STAGE, onRemoveFromStage);
			addEventListener(Event.TRIGGERED, onButtonsClick);
		}
		
		
		private function onAddedToStage(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			name = Constants.WINDOW_END_GAME;
			
			var bitmap:Bitmap = new TextureBG();
			_image = new Image(Texture.fromBitmap(bitmap));
			addChild(_image);
			
			bitmap = new TextureButton();
			_button = new Button(Texture.fromBitmap(bitmap));
			_button.text = "Закрыть";
			_button.name = Constants.WINDOW_END_GAME_CLOSE;
			_button.fontColor = 0xFFFFFF;
			_button.x = (Constants.MK_WINDOW_WIDTH / 2) - 85;
			_button.y = Constants.MK_WINDOW_HEIGHT - 80;
			addChild(_button);
		}
		
		private function onRemoveFromStage(e:Event):void 
		{
			removeEventListener(Event.REMOVED_FROM_STAGE, onRemoveFromStage);
			
			if (_image != null) _image.dispose();
			_image = null;
			if (_button != null) _button.dispose();
			_button = null;
			
			super.dispose();
			System.gc();
			trace("[X] Удалено окно END GAME");
		}
		
		private function onButtonsClick(event:Event):void 
		{
			MusicAndSound.PlaySound(MusicAndSound.Sound1);
			if (Button(event.target).name == Constants.WINDOW_END_GAME_CLOSE)
			{
				dispatchEvent(new Navigation(Navigation.CHANGE_SCREEN, true, { id: Constants.WINDOW_END_GAME_CLOSE } ));
			}
		}
		
	}

}