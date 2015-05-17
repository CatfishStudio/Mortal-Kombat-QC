package mkcards.assets.statics 
{
	import flash.display.Bitmap;
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
		
		/* Тутор (обучение) ----------------*/
		public static var tutorialStep:int = 1;
		/* -------------------------------- */
		
		/* Текстуры ----------------------- */
		[Embed(source = '../media/textures/background_game.jpg')]
		public static var TextureBackgroundGame:Class;
		[Embed(source = '../media/textures/button.png')]
		public static var TextureButton:Class;
		[Embed(source = '../media/textures/fullscreen.png')]
		public static var TextureButtonFullscreen:Class;
		
		[Embed(source = '../media/textures/tutorial_dialog.png')]
		public static var TextureTutorialDialog:Class;
		[Embed(source = '../media/textures/tutorial_shaokahn.png')]
		public static var TextureTutorialShaokahn:Class;
		[Embed(source = '../media/textures/tutorial_down.png')]
		public static var TextureTutorialDown:Class;
		[Embed(source = '../media/textures/tutorial_left.png')]
		public static var TextureTutorialLeft:Class;
		[Embed(source = '../media/textures/tutorial_right.png')]
		public static var TextureTutorialRight:Class;
		[Embed(source = '../media/textures/tutorial_up.png')]
		public static var TextureTutorialUp:Class;
		/* -------------------------------- */
		
	}

}