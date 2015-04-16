package gameload
{
	import flash.display.Bitmap;
	import flash.system.LoaderContext;
	import flash.system.ApplicationDomain;
	import flash.system.SecurityDomain;
	import flash.system.Security;
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.net.URLRequest;

	[SWF(width="860", height="730", frameRate="30", backgroundColor="#ffffff")]
	public class Main extends Sprite 
	{
		[Embed(source = 'textures/background.jpg')]
		private var BackgroundImage:Class;
		private var _image:Bitmap = new BackgroundImage();
		
		[Embed(source = 'textures/logo.png')]
		private var LogoImage:Class;
		private var _imageLogo:Bitmap = new LogoImage();
		
		private var _request:URLRequest;
		private var _loader:Loader;
		private var _loaderContext:LoaderContext;
		
		private var _progressText:Label; // текст загрузки в процентах

		public function Main() 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			addChild(_image);
			
			_imageLogo.x = 10;
			_imageLogo.y = 10;
			addChild(_imageLogo);
			
			/* Текстовое отображение загругки в процентах */
			_progressText = new Label(380, 380, 200, 30, "Arial", 24, 0xFFFFFF, "Загрузка...", false);
			_progressText.text = "Загрузка ...";
			this.addChild(_progressText);
			
			_loader = new Loader();
			_loaderContext = new LoaderContext(false, ApplicationDomain.currentDomain, SecurityDomain.currentDomain);
			_request = new URLRequest("http://app.vk.com/c420925/u99302165/af2cea9c265c63.swf");
			//_request = new URLRequest("http://catfishstudio.besaba.com/games/mkquest/MKQuest.swf");
			_loader.contentLoaderInfo.addEventListener(Event.COMPLETE, LoadComplite);
			_loader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, onProgress);
			_loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, LoadError);
			_loader.load(_request, _loaderContext);
			
		}
		
		private function onProgress(e:ProgressEvent):void 
		{
			var nPercent:Number = Math.round((e.bytesLoaded / e.bytesTotal) * 100);    
			//loadingAnim.bar.scaleX = nPercent / 100;
			//loadingAnim.percLoaded.text = nPercent.toString() + "%";
			_progressText.text = "Загрузка " + nPercent.toString() + "%";
		}
		
		private function LoadError(e:IOErrorEvent):void 
		{
			_progressText.text = "Ошибка загрузки!!! ";
			trace("Error!!! " + e.toString() );
		}
		
		private function LoadComplite(e:Event):void
		{
			_progressText.text = "Загрузка завершена! ";
			_loader.contentLoaderInfo.removeEventListener(Event.COMPLETE, LoadComplite); 
			
			this.addChild(_loader);
			
			this.removeChild(_imageLogo);
			_imageLogo = null;
			this.removeChild(_image);
			_image = null;
			this.removeChild(_progressText);
			_progressText = null;
		}
		
		
	}
	
}