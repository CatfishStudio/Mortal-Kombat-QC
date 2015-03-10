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
		public static var ai_enemies:Vector.<Enemy>; // массив врагов
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
		public static var textureAtlasAnimation:TextureAtlas;
		
		[Embed(source = '../media/atlas/sprites_game.png')]
		public static var AtlasSpritesGame:Class;
		[Embed(source = '../media/atlas/sprites_game.xml', mimeType='application/octet-stream')]
		public static var AtlasSpritesGameXML:Class;
		
		[Embed(source = '../media/atlas/sprites_level_textures.png')]
		public static var AtlasSpritesLevelTextures:Class;
		[Embed(source = '../media/atlas/sprites_level_textures.xml', mimeType='application/octet-stream')]
		public static var AtlasSpritesLevelTexturesXML:Class;
		
		/*
		[Embed(source = '../media/atlas/sprites_level_animation.png')]
		public static var AtlasSpritesLevelAnimation:Class;
		[Embed(source = '../media/atlas/sprites_level_animation.xml', mimeType='application/octet-stream')]
		public static var AtlasSpritesLevelAnimationXML:Class;
		*/
		
		[Embed(source = '../media/atlas/sprites_blood.png')]
		public static var AtlasSpritesBlood:Class;
		[Embed(source = '../media/atlas/sprites_blood.xml', mimeType='application/octet-stream')]
		public static var AtlasSpritesBloodXML:Class;
		
		[Embed(source = '../media/atlas/sprites_dragon.png')]
		public static var AtlasSpritesDragon:Class;
		[Embed(source = '../media/atlas/sprites_dragon.xml', mimeType='application/octet-stream')]
		public static var AtlasSpritesDragonXML:Class;
		
		
		
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
		
		[Embed(source = '../media/atlas/sprites_goro.png')]
		public static var AtlasSpritesGoro:Class;
		[Embed(source = '../media/atlas/sprites_goro.xml', mimeType='application/octet-stream')]
		public static var AtlasSpritesGoroXML:Class;
		
		[Embed(source = '../media/atlas/sprites_shaokahn.png')]
		public static var AtlasSpritesShaokahn:Class;
		[Embed(source = '../media/atlas/sprites_shaokahn.xml', mimeType='application/octet-stream')]
		public static var AtlasSpritesShaokahnXML:Class;
		/* -------------------------------- */
		
		/* Уровни ------------------------- */
		[Embed(source = '../levels/level.xml', mimeType='application/octet-stream')]
		public static var ClassXMLFileLevel:Class;
		
		[Embed(source = '../levels/level0.xml', mimeType='application/octet-stream')]
		public static var ClassXMLFileLevel0:Class;
		[Embed(source = '../levels/level1.xml', mimeType='application/octet-stream')]
		public static var ClassXMLFileLevel1:Class;
		[Embed(source = '../levels/level2.xml', mimeType='application/octet-stream')]
		public static var ClassXMLFileLevel2:Class;
		[Embed(source = '../levels/level3.xml', mimeType='application/octet-stream')]
		public static var ClassXMLFileLevel3:Class;
		[Embed(source = '../levels/level4.xml', mimeType='application/octet-stream')]
		public static var ClassXMLFileLevel4:Class;
		[Embed(source = '../levels/level5.xml', mimeType='application/octet-stream')]
		public static var ClassXMLFileLevel5:Class;
		[Embed(source = '../levels/level6.xml', mimeType='application/octet-stream')]
		public static var ClassXMLFileLevel6:Class;
		[Embed(source = '../levels/level7.xml', mimeType='application/octet-stream')]
		public static var ClassXMLFileLevel7:Class;
		[Embed(source = '../levels/level8.xml', mimeType='application/octet-stream')]
		public static var ClassXMLFileLevel8:Class;
		[Embed(source = '../levels/level9.xml', mimeType='application/octet-stream')]
		public static var ClassXMLFileLevel9:Class;
		[Embed(source = '../levels/level10.xml', mimeType='application/octet-stream')]
		public static var ClassXMLFileLevel10:Class;
		[Embed(source = '../levels/level11.xml', mimeType='application/octet-stream')]
		public static var ClassXMLFileLevel11:Class;
		[Embed(source = '../levels/level12.xml', mimeType='application/octet-stream')]
		public static var ClassXMLFileLevel12:Class;
		[Embed(source = '../levels/level13.xml', mimeType='application/octet-stream')]
		public static var ClassXMLFileLevel13:Class;
		/* -------------------------------- */
		
		
		
		/* Инициализация атласа текстур игры / уровня
		 * (Используется в классе "Games" функция "initGameTextureAtlas")
		 * */
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
			
			trace("-> Загрузка Атласа: Ftom Bitmap");
		}
		
		
		/* Инициализация атласа текстур анимации для уровня
		 * (Используется в классе "Games" функция "initLevelTextureAtlas")
		 * */
		public static function setTextureAtlasEmbeddedAsset(ClassAtlasSprite:Class, ClassAtlasSpritesXML:Class):void
		{
			var contentfile:ByteArray = new ClassAtlasSpritesXML();
			var contentstr:String = contentfile.readUTFBytes(contentfile.length);
			var xml:XML = new XML(contentstr);
			
			if (textureAtlasAnimation == null)
			{
				textureAtlasAnimation = new TextureAtlas(Texture.fromEmbeddedAsset(ClassAtlasSprite), xml);
			}
			else
			{
				textureAtlasAnimation.dispose();
				textureAtlasAnimation = null;
				textureAtlasAnimation = new TextureAtlas(Texture.fromEmbeddedAsset(ClassAtlasSprite), xml);
			}
			
			contentfile = null;
			contentstr = null;
			xml = null;
			
			trace("-> Загрузка Атласа: Ftom Embedded Asset");
		}
		
		public static function disposeTextureAtlas():void
		{
			if (textureAtlas != null)
			{
				textureAtlas.dispose();
				textureAtlas = null;
			}
			if (textureAtlasAnimation != null)
			{
				textureAtlasAnimation.dispose();
				textureAtlasAnimation = null;
			}
			trace("### Очистка: глобальных атласов");
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
			trace("-/- Очистка: данных пользователя");
		}
		
		public static function clearAI():void
		{
			ai_enemies = null;
			trace("-/- Очистка: данных ИИ");
		}
		
		
	}

}