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
		/* Характеристики Пользователя ------------------------------------------ */
		public static var user_hit_1:int = 0;
		public static var user_hit_2:int = 0;
		public static var user_hit_3:int = 0;
		public static var user_hit_4:int = 0;
		public static var user_hit_5:int = 0;
		public static var tournamentProgress = 1;
		/* Характеристики ИИ ---------------------------------------------------- */
		public static var ai_hit_1:int = 0;
		public static var ai_hit_2:int = 0;
		public static var ai_hit_3:int = 0;
		public static var ai_hit_4:int = 0;
		public static var ai_hit_5:int = 0;
		/*----------------------------------------------------------------------- */
		
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
		
		/* Текстуры ----------------------- */
		[Embed(source = '../media/textures/background_game.jpg')]
		public static var TextureBackgroundGame:Class;
		[Embed(source = '../media/textures/button.png')]
		public static var TextureButton:Class;
		/* -------------------------------- */
		
		/* Атласы ------------------------- */
		public static var textureAtlas:TextureAtlas;
		
		[Embed(source = '../media/atlas/sprites_game.png')]
		public static var AtlasSpritesGame:Class;
		[Embed(source = '../media/atlas/sprites_game.xml', mimeType='application/octet-stream')]
		public static var AtlasSpritesGameXML:Class;
		
		[Embed(source = '../media/atlas/sprites_level.png')]
		public static var AtlasSpritesLevel:Class;
		[Embed(source = '../media/atlas/sprites_level.xml', mimeType='application/octet-stream')]
		public static var AtlasSpritesLevelXML:Class;
				
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
		
		[Embed(source = '../media/atlas/sprites_reptile.png')]
		public static var AtlasSpritesReptile:Class;
		[Embed(source = '../media/atlas/sprites_reptile.xml', mimeType='application/octet-stream')]
		public static var AtlasSpritesReptileXML:Class;
		
		[Embed(source = '../media/atlas/sprites_subzero.png')]
		public static var AtlasSpritesSubzero:Class;
		[Embed(source = '../media/atlas/sprites_subzero.xml', mimeType='application/octet-stream')]
		public static var AtlasSpritesSubzeroXML:Class;
		
		[Embed(source = '../media/atlas/sprites_shangtsung.png')]
		public static var AtlasSpritesShangtsung:Class;
		[Embed(source = '../media/atlas/sprites_shangtsung.xml', mimeType='application/octet-stream')]
		public static var AtlasSpritesShangtsungXML:Class;
		
		[Embed(source = '../media/atlas/sprites_kitana.png')]
		public static var AtlasSpritesKitana:Class;
		[Embed(source = '../media/atlas/sprites_kitana.xml', mimeType='application/octet-stream')]
		public static var AtlasSpritesKitanaXML:Class;
		
		[Embed(source = '../media/atlas/sprites_jax.png')]
		public static var AtlasSpritesJax:Class;
		[Embed(source = '../media/atlas/sprites_jax.xml', mimeType='application/octet-stream')]
		public static var AtlasSpritesJaxXML:Class;
		
		[Embed(source = '../media/atlas/sprites_mileena.png')]
		public static var AtlasSpritesMileena:Class;
		[Embed(source = '../media/atlas/sprites_mileena.xml', mimeType='application/octet-stream')]
		public static var AtlasSpritesMileenaXML:Class;
		
		[Embed(source = '../media/atlas/sprites_baraka.png')]
		public static var AtlasSpritesBaraka:Class;
		[Embed(source = '../media/atlas/sprites_baraka.xml', mimeType='application/octet-stream')]
		public static var AtlasSpritesBarakaXML:Class;
		
		[Embed(source = '../media/atlas/sprites_scorpion.png')]
		public static var AtlasSpritesScorpion:Class;
		[Embed(source = '../media/atlas/sprites_scorpion.xml', mimeType='application/octet-stream')]
		public static var AtlasSpritesScorpionXML:Class;
		
		[Embed(source = '../media/atlas/sprites_raiden.png')]
		public static var AtlasSpritesRaiden:Class;
		[Embed(source = '../media/atlas/sprites_raiden.xml', mimeType='application/octet-stream')]
		public static var AtlasSpritesRainedXML:Class;
		/* -------------------------------- */
		
		public static function setTextureAtlasFromBitmap(ClassAtlasSprite:Class, ClassAtlasSpritesXML:Class):void
		{
			var contentfile:ByteArray = new ClassAtlasSpritesXML();
			var contentstr:String = contentfile.readUTFBytes(contentfile.length);
			var xml:XML = new XML(contentstr);
			var bitmap:Bitmap = new ClassAtlasSprite();
			
			if (textureAtlas == null)
			{
				textureAtlas = new TextureAtlas(Texture.fromBitmap(bitmap), xml);
			}
			else
			{
				textureAtlas.dispose();
				textureAtlas = null;
				textureAtlas = new TextureAtlas(Texture.fromBitmap(bitmap), xml);
			}
			
			contentfile = null;
			contentstr = null;
			xml = null;
			bitmap = null;
		}
		
		public static function setTextureAtlasEmbeddedAsset(ClassAtlasSprite:Class, ClassAtlasSpritesXML:Class):void
		{
			var contentfile:ByteArray = new ClassAtlasSpritesXML();
			var contentstr:String = contentfile.readUTFBytes(contentfile.length);
			var xml:XML = new XML(contentstr);
			
			if (textureAtlas == null)
			{
				textureAtlas = new TextureAtlas(Texture.fromEmbeddedAsset(ClassAtlasSprite), xml);
			}
			else
			{
				textureAtlas.dispose();
				textureAtlas = null;
				textureAtlas = new TextureAtlas(Texture.fromEmbeddedAsset(ClassAtlasSprite), xml);
			}
			
			contentfile = null;
			contentstr = null;
			xml = null;
		}
		
		
		/*
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
		*/
		
		
	}

}