package mkquest.assets.statics 
{
	import flash.display.Bitmap;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.utils.ByteArray;
	
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;
	
	import mkquest.assets.stairs.Enemy;
	import mkquest.assets.levels.Levels;
	
	public class Resource 
	{
		/* Характеристики Пользователя ------------------------------------------ */
		public static var user_name:String;			// Имя бойца пользователя
		public static var user_hit_1:int = 0;		// Удар ногой
		public static var user_hit_2:int = 0;		// Удар рукой
		public static var user_hit_3:int = 0;		// Блок
		public static var user_hit_4:int = 0;		// Апперкот
		public static var user_hit_5:int = 0;		// С разворота
		public static var tournamentProgress:int = 12;	// Прогресс прохождения турника (индекс врага) с конца в начало
		public static var experiencePoints:int = 0;	// Очки опыта
		public static var totalPointsPlayer:int = 0;// Общие очки игрока за весь турнир
		/* Характеристики ИИ ---------------------------------------------------- */
		public static var ai_enemies:Vector.<Enemy>; // массив вграгов
		/*----------------------------------------------------------------------- */
		/* Уровни --------------------------------------------------------------- */
		public static var levels:Vector.<Levels>; // массив уровней
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
		
		
		public static function clearUser():void
		{
			user_name = null;		// Имя бойца пользователя
			user_hit_1 = 0;			// Удар ногой
			user_hit_2 = 0;			// Удар рукой
			user_hit_3 = 0;			// Блок
			user_hit_4 = 0;			// Апперкот
			user_hit_5 = 0;			// С разворота
			tournamentProgress = 12;// Прогресс прохождения турника (индекс врага) с конца в начало
			experiencePoints = 0;	// Очки опыта
			totalPointsPlayer = 0;	// Общие очки игрока за весь турнир
		}
		
		public static function clearAI():void
		{
			ai_enemies = null;
		}
		
		
	}

}