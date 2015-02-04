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
		public static var textureAtlas:TextureAtlas;
		
		[Embed(source = '../media/atlas/sprites_game.png')]
		public static var AtlasSpritesGame:Class;
		[Embed(source = '../media/atlas/sprites_game.xml', mimeType='application/octet-stream')]
		public static var AtlasSpritesGameXML:Class;
		
		[Embed(source = '../media/atlas/sprites_character.png')]
		public static var AtlasSpritesCharacter:Class;
		[Embed(source = '../media/atlas/sprites_character.xml', mimeType='application/octet-stream')]
		public static var AtlasSpritesCharacterXML:Class;
		
		[Embed(source = '../media/atlas/sprites_spinner.png')]
		public static var AtlasSpritesSpinner:Class;
		[Embed(source = '../media/atlas/sprites_spinner.xml', mimeType='application/octet-stream')]
		public static var AtlasSpritesSpinnerXML:Class;
		
		[Embed(source = '../media/atlas/sprites_liukang.png')]
		public static var AtlasSpritesLiukang:Class;
		[Embed(source = '../media/atlas/sprites_liukang.xml', mimeType='application/octet-stream')]
		public static var AtlasSpritesLiukangXML:Class;
		
		[Embed(source = '../media/atlas/sprites_kunglao.png')]
		public static var AtlasSpritesKunglao:Class;
		[Embed(source = '../media/atlas/sprites_kunglao.xml', mimeType='application/octet-stream')]
		public static var AtlasSpritesKunglaoXML:Class;
		
		[Embed(source = '../media/atlas/sprites_johnnycage.png')]
		public static var AtlasSpritesJohnnycage:Class;
		[Embed(source = '../media/atlas/sprites_johnnycage.xml', mimeType='application/octet-stream')]
		public static var AtlasSpritesJohnnycageXML:Class;
		
		/* -------------------------------- */
		
		
		public static function getTextureAtlasFromBitmap(ClassAtlasSprite:Class, ClassAtlasSpritesXML:Class):TextureAtlas
		{
			var contentfile:ByteArray = new ClassAtlasSpritesXML();
			var contentstr:String = contentfile.readUTFBytes(contentfile.length);
			var xml:XML = new XML(contentstr);
			var bitmap:Bitmap = new ClassAtlasSprite();
			
			contentfile = null;
			contentstr = null;
			
			return new TextureAtlas(Texture.fromBitmap(bitmap), xml);
			
		}
		
		public static function getTextureAtlasEmbeddedAsset(ClassAtlasSprite:Class, ClassAtlasSpritesXML:Class):TextureAtlas
		{
			var contentfile:ByteArray = new ClassAtlasSpritesXML();
			var contentstr:String = contentfile.readUTFBytes(contentfile.length);
			var xml:XML = new XML(contentstr);
			
			contentfile = null;
			contentstr = null;
			
			return new TextureAtlas(Texture.fromEmbeddedAsset(ClassAtlasSprite), xml);
		}
		
		
	}

}