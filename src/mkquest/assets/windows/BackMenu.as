package mkquest.assets.windows 
{
	import flash.display.Bitmap;
	
	import starling.display.Button;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.textures.Texture;
	import starling.display.Quad;
	
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
		private var _quad:Quad;
		
		public function BackMenu(sender:String) 
		{
			super();
			_sender = sender;
			x = Constants.GAME_WINDOW_WIDTH / 4;
			y = Constants.GAME_WINDOW_HEIGHT / 4;
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			addEventListener(Event.REMOVED_FROM_STAGE, onRemoveFromStage);
			addEventListener(Event.TRIGGERED, onButtonsClick);
		}
		
		private function onAddedToStage(e:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			name = Constants.WINDOW_BACK_MENU;
			
			
			_quad = new Quad(Constants.GAME_WINDOW_WIDTH, Constants.GAME_WINDOW_HEIGHT,  0x000000, true);
			_quad.alpha = 0.5;
			_quad.x = 0 - this.x;
			_quad.y = 0 - this.y;
			addChild(_quad);
			
			var bitmap:Bitmap = new TextureBackground();
			_image = new Image(Texture.fromBitmap(bitmap));
			//addChild(_image);
			
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
			
			bitmap = new TextureBorder();
			_image = new Image(Texture.fromBitmap(bitmap));
			addChild(_image);
			
			bitmap = new TextureButton();
			_button = new Button(Texture.fromBitmap(bitmap));
			_button.text = "Да";
			_button.name = "yes";
			_button.fontColor = 0xFFFFFF;
			_button.x = 20;
			_button.y = 185;
			addChild(_button);
			
			_button = new Button(Texture.fromBitmap(bitmap));
			_button.text = "Нет";
			_button.name = "no";
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
			trace("[X] Удалено окно BACK IN MENU");
		}
		
		private function onButtonsClick(event:Event):void 
		{
			if (Button(event.target).name == "yes")
			{
				if (_sender == Constants.MK_WINDOW_STAIRS) dispatchEvent(new Navigation(Navigation.CHANGE_SCREEN, true, { id: Constants.WINDOW_STAIRS_BACK_MENU } ));
				if (_sender == Constants.MK_WINDOW_LEVEL) dispatchEvent(new Navigation(Navigation.CHANGE_SCREEN, true, { id: Constants.WINDOW_LEVEL_BACK_MENU } ));
			}
			else
			{
				dispatchEvent(new Navigation(Navigation.CHANGE_SCREEN, true, { id: Constants.WINDOW_BACK_MENU_CLOSE } ));
			}
		
		}
		
		
	}

}