package mkquest.assets.windows 
{
	import flash.display.Bitmap;
	
	import starling.display.Button;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.textures.Texture;
	
	import mkquest.assets.statics.Resource;
	import mkquest.assets.statics.Constants;
	import mkquest.assets.events.Navigation;
	
	public class BackMenu extends Sprite 
	{
		[Embed(source = '../media/textures/window_background.png')]
		public static var TextureBackground:Class;
		[Embed(source = '../media/textures/window_border.png')]
		public static var TextureBorder:Class;
		[Embed(source = '../media/textures/button.png')]
		public static var TextureButton:Class;
		
		private var _sender:String;
		private var _image:Image;
		private var _button:Button;
		
		public function BackMenu(sender:String) 
		{
			super();
			_sender = sender;
			x = Constants.GAME_WINDOW_WIDTH / 4;
			y = Constants.GAME_WINDOW_HEIGHT / 4;
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			addEventListener(Event.REMOVED, onRemoveStage);
			addEventListener(Event.TRIGGERED, onButtonsClick);
		}
		
		private function onAddedToStage(e:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			name = Constants.WINDOW_BACK_MENU;
			
			
			var bitmap:Bitmap = new TextureBackground();
			_image = new Image(Texture.fromBitmap(bitmap));
			addChild(_image);
			
			bitmap = new TextureBorder();
			_image = new Image(Texture.fromBitmap(bitmap));
			addChild(_image);
			
			bitmap = new TextureButton();
			_button = new Button(Texture.fromBitmap(bitmap), "Да");
			_button.name = "yes";
			_button.x = 10;
			_button.y = 185;
			addChild(_button);
			
			_button = new Button(Texture.fromBitmap(bitmap), "Нет");
			_button.name = "no";
			_button.x = 200;
			_button.y = 185;
			addChild(_button);
			
			bitmap = null;
			_image.dispose();
			_image = null;
		}
		
		private function onRemoveStage(e:Event):void
		{
			//super.dispose();
			trace("[X] Удалено окно BACK IN MENU");
		}
		
		private function onButtonsClick(event:Event):void 
		{
			if (Button(event.target).name == "yes")
			{
				trace(_sender);
				if (_sender == Constants.MK_WINDOW_STAIRS) dispatchEvent(new Navigation(Navigation.CHANGE_SCREEN, true, { id: Constants.BUTTON_STAIRS_BACK_IN_MENU } ));
				this.parent.removeChild(this);
				//this.removeFromParent(true);
			}
			else
			{
				this.parent.removeChild(this);
			}
		
		}
		
		
	}

}