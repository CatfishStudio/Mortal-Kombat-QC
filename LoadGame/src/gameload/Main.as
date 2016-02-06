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

	[SWF(width="860", height="730", frameRate="30", backgroundColor="#ffffff")]
	public class Main extends MovieClip 
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
		
		// ------------------------------------
		private var LogTextField:TextField;
        private var loader:flash.display.Loader;
        private var vkContainer:Object;
		private var bannerEnd: Boolean = false;
		// ------------------------------------
		
		private var _progressText:Label; // текст загрузки в процентах

		public function Main() 
		{
			//if (stage) init();
			//else addEventListener(Event.ADDED_TO_STAGE, init);
			
			super();
            init();
            Security.allowDomain("*");
            Security.allowInsecureDomain("*");
            if (stage)
            {
                initAd();
            }
            else
            {
                addEventListener(Event.ADDED_TO_STAGE, initAd);
            }
		}
		
		private function init():void
        {
			addChild(_image);
			
			_imageLogo.x = 10;
			_imageLogo.y = 10;
			addChild(_imageLogo);
			
            var flashVars: Object = stage.loaderInfo.parameters as Object;

            new URLLoader().load(new URLRequest("//js.appscentrum.com/s?app_id=4759608&user_id=" + flashVars['viewer_id']));;

            LogTextField = new TextField();
            addChild(LogTextField);

            LogTextField.text = "";
            LogTextField.width = 250;
            LogTextField.x = 25;
            LogTextField.y = 25;

            var LogFormat:TextFormat = new TextFormat();

            LogFormat.color = 0x000000;
            LogTextField.setTextFormat(LogFormat);
        }
		
		private function initAd(e:Event=null):void
        {
            removeEventListener(Event.ADDED_TO_STAGE, initAd);

            stage.scaleMode = flash.display.StageScaleMode.NO_SCALE;
            stage.showDefaultContextMenu = false;
            stage.align = flash.display.StageAlign.TOP_LEFT;
            stage.addEventListener(Event.RESIZE, onResize);

            loader = new flash.display.Loader();
            loader.contentLoaderInfo.addEventListener(Event.COMPLETE, onLoadComplete);

            var context:LoaderContext = new LoaderContext(false, new ApplicationDomain());
            var adrequest:URLRequest = new URLRequest("//ad.mail.ru/static/vkcontainer.swf");
            var requestParams : URLVariables = new URLVariables();
            requestParams['preview'] = '8';
            adrequest.data = requestParams;

            loader.load(adrequest, context);
        }
		
		private function onLoadComplete(e:Event):void
        {
            vkContainer = loader.content;
            addChild(vkContainer as DisplayObject);
            onResize();

            vkContainer.addEventListener("adReady", onAdReady);
            vkContainer.addEventListener("adLoadFailed", onAdLoadFailed);
            vkContainer.addEventListener("adError", onAdError);
            vkContainer.addEventListener("adInitFailed", onAdInitFailed);
            vkContainer.addEventListener("adStarted", onAdStarted);
            vkContainer.addEventListener("adStopped", onAdStopped);
            vkContainer.addEventListener("adPaused", onAdPaused);
            vkContainer.addEventListener("adResumed", onAdResumed);
            vkContainer.addEventListener("adCompleted", onAdCompleted);
            vkContainer.addEventListener("adClicked", onAdClicked);

            vkContainer.addEventListener("adBannerStarted", onAdBannerStarted);
            vkContainer.addEventListener("adBannerStopped", onAdBannerStopped);
            vkContainer.addEventListener("adBannerCompleted", onAdBannerCompleted);

            vkContainer.init("4759608", stage);
        }

        private function onAdReady(e:Event):void
        {
            //print("Adman: Ad Ready");
        }

        private function onAdLoadFailed(e:Event):void
        {
            //print("Adman: Ad Load Failed");
			if(bannerEnd == false) initGame();
        }

        private function onAdError(e:Event):void
        {
            //print("Adman: Ad Error");
			if(bannerEnd == false) initGame();
        }

        private function onAdInitFailed(e:Event):void
        {
            //print("Adman: Ad Init Failed");
			if(bannerEnd == false) initGame();
        }

        private function onAdStarted(e:Event):void
        {
            //print("Adman: Ad Started");
        }

        private function onAdStopped(e:Event):void
        {
            //print("Adman: Ad Stopped");
			if(bannerEnd == false) initGame();
        }

        private function onAdPaused(e:Event):void
        {
            //print("Adman: Ad Paused");
        }

        private function onAdResumed(e:Event):void
        {
            //print("Adman: Ad Resumed");
        }

        private function onAdCompleted(e:Event):void
        {
            //print("Adman: Ad Completed");
        }

        private function onAdClicked(e:Event):void
        {
            //print("Adman: Ad Clicked");
        }

        private function onAdBannerStarted(e:Event):void
        {
            //print("Adman: Ad Banner Started");
        }

        private function onAdBannerStopped(e:Event):void
        {
            //print("Adman: Ad Banner Stopped");
			if(bannerEnd == false) initGame();
        }

        private function onAdBannerCompleted(e:Event):void
        {
            //print("Adman: Ad Banner Completed");
			if(bannerEnd == false) initGame();
        }

        private function onResize(e:Event=null):void
        {
            if (vkContainer)
            {
                vkContainer.setSize(stage.stageWidth, stage.stageHeight);
            }

        }

        public function print(msg:String):void
        {
            msg = "\n" + msg;
            LogTextField.appendText(msg);
        }
		
		
		
		
		
		private function initGame(e:Event = null):void 
		{
			bannerEnd = true;
			
			/* Текстовое отображение загругки в процентах */
			_progressText = new Label(380, 380, 200, 30, "Arial", 24, 0xFFFFFF, "Загрузка...", false);
			_progressText.text = "Загрузка ...";
			this.addChild(_progressText);
			
			_loader = new Loader();
			_loaderContext = new LoaderContext(false, ApplicationDomain.currentDomain, SecurityDomain.currentDomain);
			_request = new URLRequest("http://app.vk.com/c420925/u99302165/a2dd16a54b8b44.swf");
			//_request = new URLRequest("http://catfishstudio.besaba.com/games/mkquest/MKQuest.swf");
			_loader.contentLoaderInfo.addEventListener(Event.COMPLETE, LoadComplite);
			_loader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, onProgress);
			_loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, LoadError);
			_loader.load(_request, _loaderContext);
		}
		
		private function onProgress(e:ProgressEvent):void 
		{
			var nPercent:Number = Math.round((e.bytesLoaded / e.bytesTotal) * 100);    
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