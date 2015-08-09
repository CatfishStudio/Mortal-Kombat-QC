package mkcards.game.statics 
{
	import flash.display.Bitmap;
	import flash.utils.ByteArray;
	
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;
	
	/**
	 * ...
	 * @author Catfish Studio Games
	 */
	public class Resource 
	{
		/* Пользователь ------------------- */
		public static var userID:String;			// Идентификатор пользователя в соц. сети
		public static var userName:String;			// Имя пользователя как оно значится в соц. сети
		public static var userLocation:String;		// Место откуда вошел пользователь (соц. сеть)
		public static var userSide:String; 			// Выбранная сторона 
		public static var userWins:int;				// Количество побед
		public static var userDefeats:int;			// Количество поражений
		public static var userMoney:int;			// Количество денег у пользователя
		public static var userSelectFighter:int;	// Активный боец пользователя
		public static var userFightersCards:Array;	// Перечень всех бойцов и колод карт
		/* -------------------------------- */
		
		
		/* Настройки игры ------------------*/
		public static var soundOn:Boolean = true;
		public static var musicOn:Boolean = true;
		public static var languageRus:Boolean = true;
		/* -------------------------------- */
		
		/* Тутор (обучение) ----------------*/
		public static var tutorialStep:int = 0;
		/* -------------------------------- */
		
		/* Шрифт (Font) ------------------- */
		[Embed(source="../../assets/font/font.fnt", mimeType="application/octet-stream")]
		public static const FontXml:Class;
 		[Embed(source = "../../assets/font/font.png")]
		public static const FontTexture:Class;
		/* -------------------------------- */
		
		/* Атласы ------------------------- */
		public static var textureAtlas:TextureAtlas;
		public static var textureAtlasAnimation:TextureAtlas;
		
		[Embed(source = '../../assets/atlas/spinner.png')]
		public static var AtlasSpinner:Class;
		[Embed(source = '../../assets/atlas/spinner.xml', mimeType='application/octet-stream')]
		public static var AtlasSpinnerXML:Class;
		
		[Embed(source = '../../assets/atlas/coin.png')]
		public static var AtlasCoin:Class;
		[Embed(source = '../../assets/atlas/coin.xml', mimeType='application/octet-stream')]
		public static var AtlasCoinXML:Class;
		
		[Embed(source = '../../assets/atlas/fighters.png')]
		public static var AtlasFighters:Class;
		[Embed(source = '../../assets/atlas/fighters.xml', mimeType='application/octet-stream')]
		public static var AtlasFightersXML:Class;
		
		/* Текстуры ----------------------- */
		[Embed(source = '../../assets/textures/background_game_1.jpg')]
		public static var TextureBackgroundGame1:Class;
		
		[Embed(source = '../../assets/textures/background_game_2.jpg')]
		public static var TextureBackgroundGame2:Class;
		
		[Embed(source = '../../assets/textures/button.png')]
		public static var TextureButton:Class;
		
		[Embed(source = '../../assets/textures/button_left.png')]
		public static var TextureButtonLeft:Class;
		[Embed(source = '../../assets/textures/button_right.png')]
		public static var TextureButtonRight:Class;
		
		[Embed(source = '../../assets/textures/title.png')]
		public static var TextureTitle:Class;
		
		[Embed(source = '../../assets/textures/shao_kahn_side.png')]
		public static var TextureSideShaokahn:Class;
		
		[Embed(source = '../../assets/textures/raiden_side.png')]
		public static var TextureSideRaiden:Class;
		
		[Embed(source = '../../assets/textures/window_background.png')]
		public static var TextureWindowBackground:Class;
		[Embed(source = '../../assets/textures/window_border.png')]
		public static var TextureWindowBorder:Class;
		
		[Embed(source = '../../assets/textures/tutorial_dialog.png')]
		public static var TextureTutorialDialog:Class;
		[Embed(source = '../../assets/textures/tutorial_shaokahn.png')]
		public static var TextureTutorialShaokahn:Class;
		[Embed(source = '../../assets/textures/tutorial_down.png')]
		public static var TextureTutorialDown:Class;
		[Embed(source = '../../assets/textures/tutorial_left.png')]
		public static var TextureTutorialLeft:Class;
		[Embed(source = '../../assets/textures/tutorial_right.png')]
		public static var TextureTutorialRight:Class;
		[Embed(source = '../../assets/textures/tutorial_up.png')]
		public static var TextureTutorialUp:Class;
		
		
		public static function initTextureAtlas(atlasSprite:Class, atlasXML:Class, fromBitmap:Boolean = false, embeddedAsset:Boolean = false):void
		{
			disposeTextureAtlas();
			if (fromBitmap == true) setTextureAtlasFromBitmap(atlasSprite, atlasXML);
			if (embeddedAsset == true) setTextureAtlasEmbeddedAsset(atlasSprite, atlasXML);
		}
		
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
			
			trace("-> Загрузка Атласа: From Bitmap");
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
			trace("### Очистка: глобальных атласов");
		}
		
		public static function disposeTextureAtlasAnimation():void
		{
			if (textureAtlasAnimation != null)
			{
				textureAtlasAnimation.dispose();
				textureAtlasAnimation = null;
			}
			trace("### Очистка: глобальных атласов");
		}
		
		
		
	}

}