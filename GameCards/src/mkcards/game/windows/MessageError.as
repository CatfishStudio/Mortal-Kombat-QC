package mkcards.game.windows 
{
	import flash.system.*;
	import flash.utils.ByteArray;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.display.Button;
	import flash.display.Bitmap;
	import starling.text.BitmapFont;
	import starling.text.TextField;
	import starling.events.Event;
	import starling.textures.Texture;
	
	import mkcards.events.Navigation;
	import mkcards.game.statics.Constants;
	import mkcards.game.statics.Resource;
	
	/**
	 * ...
	 * @author Catfish Studio Games
	 */
	public class MessageError extends Sprite 
	{
		private var _textField:TextField;
		private var _message:String;
		
		public function MessageError(message:String) 
		{
			super();
			_message = message;
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			addEventListener(Event.REMOVED_FROM_STAGE, onRemoveFromStage);
		}
		
		private function onAddedToStage(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			name = Constants.WINDOW_MESSAGE_ERROR;
			x = Constants.GAME_WINDOW_WIDTH / 4.5;
			y = Constants.GAME_WINDOW_HEIGHT / 3.5;
			show();
		}
		
		private function onRemoveFromStage(e:Event):void 
		{
			removeEventListener(Event.REMOVED_FROM_STAGE, onRemoveFromStage);
			
			if (_textField) _textField.dispose();
			_textField = null;
				
			while (this.numChildren)
			{
				this.removeChildren(0, -1, true);
			}
			this.removeFromParent(true);
			super.dispose();
			System.gc();
			trace("[X] onRemoveFromStage: " + this.name);
		}
		
		private function show():void
		{
			var bitmap:Bitmap = new Resource.TextureWindowBackground();
			var image:Image = new Image(Texture.fromBitmap(bitmap));
			addChild(image);
			
			_textField = new TextField(450, 350, _message, "Arial", 27, 0xffffff, false);
			_textField.fontName = "Font01";
			_textField.hAlign = "center";
			_textField.x = 10;
			_textField.y = 20;
			addChild(_textField)
			
			bitmap = new Resource.TextureWindowBorder();
			image = new Image(Texture.fromBitmap(bitmap));
			addChild(image);
			
			bitmap = null;
			image.dispose();
			image = null;
		}
		
		
		
		
	}

}