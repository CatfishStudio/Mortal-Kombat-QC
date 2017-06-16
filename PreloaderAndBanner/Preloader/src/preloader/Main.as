package preloader
{
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Catfish Studio
	 */
	[SWF(width="860", height="730", frameRate="60", backgroundColor="#ffffff")]
	public class Main extends Sprite 
	{
		[Embed(source = '../../assets/background.jpg')]
		private var BackgroundImage:Class;
		private var backgroundBitmap:Bitmap = new BackgroundImage();
		
		[Embed(source = '../../assets/logo.png')]
		private var LogoImage:Class;
		private var imageLogo:Bitmap = new LogoImage();
		
		private var progressText:Label;
		
		public function Main() 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			addChild(backgroundBitmap);
			
			imageLogo.x = 10;
			imageLogo.y = 10;
			addChild(imageLogo);
			
			progressText = new Label(380, 600, 200, 30, "Arial", 24, 0xFFFFFF, "Загрузка...", false);
			progressText.text = "Загрузка 0%";
			progressText.scaleX = 0.9;
			progressText.scaleY = 0.9;
			this.addChild(progressText);
		}
		
		public function setValue(valuePercent:int):void
		{
			progressText.text = "Загрузка " + valuePercent.toString() + "%";
		}
		
		public function setText(valueText:String):void
		{
			progressText.text = valueText;
		}
		
		public function getValue():String
		{
			return progressText.text;
		}
		
	}
	
}