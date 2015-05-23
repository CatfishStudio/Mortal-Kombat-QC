package mkcards.assets.statics 
{
	import flash.display.Bitmap;
	import flash.utils.ByteArray;
	
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;
	
	public class Resource 
	{
		/* Пользователь ------------------- */
		public static var userID:String;
		public static var userName:String;
		public static var userNickName:String;
		public static var userSide:String; // DARK or WHITE
		/* -------------------------------- */
		
		
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
		
		[Embed(source = '../media/textures/dark_side.png')]
		public static var TextureDarkSide:Class;
		[Embed(source = '../media/textures/light_side.png')]
		public static var TextureLightSide:Class;
		[Embed(source = '../media/textures/text_box.png')]
		public static var TextureTextBox:Class;
		[Embed(source = '../media/textures/white.png')]
		public static var TextureWhite:Class;
		[Embed(source = '../media/textures/yellow.png')]
		public static var TextureYellow:Class;
		
		[Embed(source = '../media/textures/window_select_fighter_background.png')]
		public static var TextureSelectFighterBackground:Class;
		[Embed(source = '../media/textures/window_select_fighter_border.png')]
		public static var TextureSelectFighterBorder:Class;
		
		/* -------------------------------- */
		
	}

}