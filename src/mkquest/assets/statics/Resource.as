package mkquest.assets.statics 
{
	import flash.display.Bitmap;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.utils.ByteArray;
	
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;
	
	public class Resource 
	{
		/* Настройки игры ------------------*/
		public static var soundOn:Boolean = true;
		public static var musicOn:Boolean = true;
		public static var languageRus:Boolean = true;
		/* -------------------------------- */
		
		/* Звуки -------------------------- */
		public static var musicMelody:Sound;
		public static var musicChannel:SoundChannel;
		public static var moveSound:Sound;
		/* -------------------------------- */
		
		/* Атласы ------------------------- */
		[Embed(source = '../media/atlas/sprites_game.png')]
		private static var AtlasSpritesGame:Class;
		[Embed(source = '../media/atlas/sprites_game.xml', mimeType='application/octet-stream')]
		private static var AtlasSpritesGameXML:Class;
		public static var texturesAtlasGame:TextureAtlas;
		
		[Embed(source = '../media/atlas/sprites_character.png')]
		private static var AtlasSpritesCharacter:Class;
		[Embed(source = '../media/atlas/sprites_character.xml', mimeType='application/octet-stream')]
		private static var AtlasSpritesCharacterXML:Class;
		public static var texturesAtlasCharacter:TextureAtlas;
		
		[Embed(source = '../media/atlas/sprites_spinner.png')]
		private static var AtlasSpritesSpinner:Class;
		[Embed(source = '../media/atlas/sprites_spinner.xml', mimeType='application/octet-stream')]
		private static var AtlasSpritesSpinnerXML:Class;
		public static var texturesAtlasSpinner:TextureAtlas;
		/* -------------------------------- */
		
		public static function LoadResource():Boolean 
		{
			var bitmap:Bitmap;
			var xml:XML;
			var contentfile:ByteArray;
			var contentstr:String;
			
			contentfile = new AtlasSpritesGameXML();
			contentstr = contentfile.readUTFBytes(contentfile.length);
			xml = new XML(contentstr);
			bitmap = new AtlasSpritesGame();
			texturesAtlasGame = new TextureAtlas(Texture.fromBitmap(bitmap), xml);
			
			contentfile = new AtlasSpritesCharacterXML();
			contentstr = contentfile.readUTFBytes(contentfile.length);
			xml = new XML(contentstr);
			bitmap = new AtlasSpritesCharacter();
			texturesAtlasCharacter = new TextureAtlas(Texture.fromBitmap(bitmap), xml);
			
			contentfile = new AtlasSpritesSpinnerXML();
			contentstr = contentfile.readUTFBytes(contentfile.length);
			xml = new XML(contentstr);
			texturesAtlasSpinner = new TextureAtlas(Texture.fromEmbeddedAsset(AtlasSpritesSpinner), xml);
			
			contentfile = null;
			contentstr = null;
			bitmap = null;
			xml = null;
			AtlasSpritesGame = null;
			AtlasSpritesGameXML = null;
			AtlasSpritesCharacter = null;
			AtlasSpritesCharacterXML = null;
			AtlasSpritesSpinner = null;
			AtlasSpritesSpinnerXML = null;
			
			return true;
		}
		
	}

}