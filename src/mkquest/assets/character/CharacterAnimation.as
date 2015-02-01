package mkquest.assets.character 
{
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	
	import mkquest.assets.statics.Constants;
	import mkquest.assets.statics.Resource;
	import mkquest.assets.xml.FileXML;
	
	public class CharacterAnimation extends Sprite 
	{
		[Embed(source = 'CharacterAnimation.xml', mimeType='application/octet-stream')]
		private var ClassFileXML:Class;
		private var _fileXML:XML = FileXML.getFileXML(ClassFileXML);
		private var _image:Image;
		
		public function CharacterAnimation() 
		{
			super();
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			addEventListener(Event.REMOVED_FROM_STAGE, onRemoveFromStage);
		}
		
		private function onAddedToStage(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			
			name = Constants.CHARACTER_SMALL;
			x = 0 - (Constants.GAME_WINDOW_WIDTH / 3.5) //Constants.GAME_WINDOW_WIDTH / 25 * (-1);
			y = 0;
			
			createCharacterAnimationFromXML();
		}
		
		private function createCharacterAnimationFromXML():void 
		{
			Resource.textureAtlas = Resource.getTextureAtlasFromBitmap(Resource.AtlasSpritesCharacter, Resource.AtlasSpritesCharacterXML);
						
			_image = new Image(Resource.textureAtlas.getTexture(_fileXML.Background));
			addChild(_image);
			
			_image = new Image(Resource.textureAtlas.getTexture(_fileXML.Border));
			addChild(_image);
		}
		
		private function onRemoveFromStage(e:Event):void 
		{
			removeEventListener(Event.REMOVED_FROM_STAGE, onRemoveFromStage);
			ClassFileXML = null;
			_fileXML = null;
			_image.dispose();
			_image = null;
		}
		
	}

}