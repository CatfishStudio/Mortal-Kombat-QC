package RemoveLoadGame
{
	import com.vk.MainVKBanner;
	import com.vk.MainVKBannerEvent;
	import com.vk.vo.BannersPanelVO;
	import flash.display.Bitmap;
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.net.URLRequest;
	import flash.system.ApplicationDomain;
	import flash.system.LoaderContext;
	import flash.system.Security;
	import flash.system.SecurityDomain;
	import flash.events.ProgressEvent;
	
	// ------------------------------------
	import flash.display.Sprite;
    import flash.display.MovieClip;
    import flash.display.DisplayObject;
    import flash.events.Event;
    import flash.net.URLRequest;
    import flash.net.URLVariables;
    import flash.net.URLLoader;
    import flash.system.ApplicationDomain;
    import flash.system.LoaderContext;
    import flash.system.Security;
    import flash.text.TextField;
    import flash.text.TextFormat;
    import flash.text.TextFieldType;
	// ------------------------------------
	
	/**
	 * ...
	 * @author Catfish Studio
	 */
	[SWF(width="860", height="730", frameRate="60", backgroundColor="#ffffff")]
	public class Main extends Sprite 
	{
		private var messageText:Label;
		
		private var processStartGame:int = 0;
		private var preloader:Loader;
		private var preloaderContent:*;
		
		private var request:URLRequest;
		private var loader:Loader;
		private var loaderContext:LoaderContext;
		
		public function Main() 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			messageShow();
			
			Security.allowDomain("*");
            Security.allowInsecureDomain("*");
			
			/*
			loader = new Loader();
			loaderContext = new LoaderContext(false, ApplicationDomain.currentDomain);
			loaderContext.securityDomain = SecurityDomain.currentDomain;
			try
			{
				// Загружается библиотека с указанным LoaderContext
				this.loader.load(new URLRequest('http://api.vk.com/swf/vk_ads.swf'), loaderContext);
				// По окончанию загрузки выполнится функция loader_onLoad
				this.loader.contentLoaderInfo.addEventListener(Event.COMPLETE, this.onComplete);
			}
			catch (e: Error)
			{
				// если приложение запущено локально, то здесь можно разместить заглушку рекламного блока
				messageAdd("Ошибка загрузки vk_ads.swf : " + e.message)
			}
			*/
			
			processStartGame = 1;
			loadPreloader();
		}
		
		private function onProgress(e:ProgressEvent):void 
		{
			if (processStartGame == 2) {
				preloaderContent.setValue(Math.round((e.bytesLoaded / e.bytesTotal) * 100));
				messageAdd("Процесс: " + Math.round((e.bytesLoaded / e.bytesTotal) * 100).toString());
			}
		}
		
		private function onError(e:IOErrorEvent):void 
		{
			messageAdd("Ошибка загрузки: " + e.toString() );
		}
		
		private function onComplete(e:Event):void
		{
			loader.contentLoaderInfo.removeEventListener(Event.COMPLETE, onComplete);
			loader.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR, onError);
			loader.contentLoaderInfo.removeEventListener(ProgressEvent.PROGRESS, onProgress);
			
			if (processStartGame == 0){ // Banners - complete
				/*
				messageAdd("Загрузка банера завершена!");
				try
				{
					this.initBanner(); // если библиотека загружена правильно, то выполнится функция initBanner, в ином случае вы получите ошибку 1014
				}
				catch (e: Error)
				{
					messageAdd("Ошибка инициализации банера: " + e.message);
				}
				
				processStartGame = 1;
				loadPreloader();
				*/
				
			}else if (processStartGame == 1){ // Preloader - complete
				messageAdd("Загрузка прелоадера завершена!");
				
				preloader = loader;
				preloader.x = 0;
				preloader.y = 0;
				addChild(preloader);
				loader = null;
				
				preloaderContent = preloader.content;
				preloaderContent.setValue(0);
				
				processStartGame = 2;
				loadGame();
			}else if (processStartGame == 2){ // Game - complete
				messageAdd("Загрузка игры завершена!");
				
				this.removeChild(preloader);
				preloader = null;
				this.addChild(loader);
			
				processStartGame = 3;
			}
		}
		
		/* == BANNER ============================================================================================================ */
		/*
		private function initBanner() : void 
		{
			var ad_unit_id: String = "64017"; // укажите тут свой id
			var block: MainVKBanner = new MainVKBanner(ad_unit_id); // создание баннера и присвоение ему id
			block.x = 860;
			block.y = 0;
			addChild(block); // добавление баннера на сцену
			
			var params: BannersPanelVO = new BannersPanelVO(); // создание класса параметров баннера
			// изменение стандартных параметров:
			params.demo = '0'; // 1 - показывает тестовые баннеры; 0 - показывать настоящие банеры
			
			// вертикальный (AD_TYPE_VERTICAL) или горизонтальный (AD_TYPE_HORIZONTAL) блок баннеров
			params.ad_type = BannersPanelVO.AD_TYPE_VERTICAL; 
			// Вертикальный (AD_UNIT_TYPE_VERTICAL) или горизонтальный (AD_UNIT_TYPE_HORIZONTAL) баннер внутри блока баннеров
			params.ad_unit_type = BannersPanelVO.AD_UNIT_TYPE_VERTICAL;
			params.title_color = '#3C5D80'; // цвет заголовка 
			params.desc_color = '#010206'; // цвет описания
			params.domain_color = '#70777D'; // цвет ссылки
			params.bg_color = '#FFFFFF'; // цвет фона
			params.bg_alpha = 0.8; // прозрачность фона (0 - прозрачно, 1 - непрозрачно)
			
			// размер шрифта. FONT_SMALL, FONT_MEDIUM или FONT_BIG
			params.font_size = BannersPanelVO.FONT_MEDIUM;
			params.lines_color = '#E3E3E3'; // цвет разделителей
			params.link_color = '#666666'; // цвет надписи "Реклама ВКонтакте"
			params.ads_count = 3; // количество выдаваемых баннеров
			params.ad_width = 150; // максимальная ширина блока
			block.initBanner(this.loaderInfo.parameters, params); // инициализация баннера
			
			block.addEventListener(MainVKBannerEvent.LOAD_COMPLETE, this.banner_onLoad);
			block.addEventListener(MainVKBannerEvent.LOAD_IS_EMPTY, this.banner_onAdsEmpty);
			block.addEventListener(MainVKBannerEvent.LOAD_ERROR, this.banner_onError);
		}
		
		private function banner_onLoad(e: Event) : void 
		{
			// прячете альтернативную рекламу, в случае, если она показана
			trace('Main.banner_onLoad :');
		}
		
		private function banner_onAdsEmpty(e: Event) : void 
		{
			// показываете альтернативную рекламу
			trace('Main.banner_onAdsEmpty :');
		}
		
		private function banner_onError(e: Event) : void 
		{
			var event: MainVKBannerEvent = e as MainVKBannerEvent;
			trace('Main.banner_onError :', event.errorMessage, event.errorCode);
		}
		*/
		/* ================================================================================================================= */
		
		/* == PRELOADER ==================================================================================================== */
		private function loadPreloader():void
		{
			loader = new Loader();
			loaderContext = new LoaderContext(false, ApplicationDomain.currentDomain, SecurityDomain.currentDomain);
			request = new URLRequest("https://catfishstudio.github.io/mortalkombatquest/Preloader.swf");
			//request = new URLRequest("http://localhost:8080/Preloader.swf");
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, onComplete);
			loader.contentLoaderInfo.removeEventListener(ProgressEvent.PROGRESS, onProgress);
			loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, onError);
			loader.load(request, loaderContext);
			messageAdd("Начало загрузки прелоадера");
		}
		/* ================================================================================================================= */
		
		/* GAME ============================================================================================================ */
		private function loadGame():void
		{
			loader = new Loader();
			loaderContext = new LoaderContext(false, ApplicationDomain.currentDomain, SecurityDomain.currentDomain);
			request = new URLRequest("https://catfishstudio.github.io/mortalkombatquest/MKQuest.swf");
			//request = new URLRequest("http://localhost:8080/MKQuest.swf");
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, onComplete);
			loader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, onProgress);
			loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, onError);
			loader.load(request, loaderContext);
			messageAdd("Начало загрузки игры");
		}
		/* ================================================================================================================= */
		
		private function messageShow():void
		{
			//messageText = new Label(0, 0, 800, 600, "Arial", 14, 0x000000, "Загрузка...", false);
			//messageText.text = "Загрузка ...";
			//this.addChild(messageText);
		}
		
		private function messageAdd(text:String):void
		{
			//messageText.text = messageText.text + "\n" + text;
		}
	}
}