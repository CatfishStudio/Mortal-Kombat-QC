package mkquest.assets.animation 
{
	import flash.system.*;
	import flash.utils.ByteArray;
	
	import starling.events.Event;
	import starling.display.MovieClip;
	import starling.core.Starling;
	import starling.events.EventDispatcher;
	import starling.textures.TextureAtlas;
	import starling.textures.Texture;
	
	import mkquest.assets.statics.Constants;
	import mkquest.assets.statics.Resource;
	
	public class Blood extends MovieClip 
	{
		private var textureAtlas:TextureAtlas;
		
		public function Blood(_x:int, _y:int) 
		{
			setTextureAtlasEmbeddedAsset();
			super(textureAtlas.getTextures("blood_"), 12);
			x = _x;
			y = _y;
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			//addEventListener(Event.REMOVED_FROM_STAGE, onRemoveFromStage);
			addEventListener(Event.COMPLETE, onComplete);
		}
		
		public function setTextureAtlasEmbeddedAsset():void
		{
			var contentfile:ByteArray = new Resource.AtlasSpritesBloodXML;
			var contentstr:String = contentfile.readUTFBytes(contentfile.length);
			var xml:XML = new XML(contentstr);
			
			if (textureAtlas == null)
			{
				textureAtlas = new TextureAtlas(Texture.fromEmbeddedAsset(Resource.AtlasSpritesBlood), xml);
			}
			else
			{
				textureAtlas.dispose();
				textureAtlas = null;
				textureAtlas = new TextureAtlas(Texture.fromEmbeddedAsset(Resource.AtlasSpritesBlood), xml);
			}
			
			contentfile = null;
			contentstr = null;
			xml = null;
		}
		
		private function onAddedToStage(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			name = Constants.BLOOD;
						
			loop = false;
			play();
			
			Starling.juggler.add(this);
		}
		
		/*
		private function onRemoveFromStage(e:Event):void 
		{
			removeEventListener(Event.REMOVED_FROM_STAGE, onRemoveFromStage);
			
			stop();
			Starling.juggler.removeTweens(this);
			while (this.numFrames > 1)
			{
				this.removeFrameAt(0);
			}
			if(textureAtlas != null) textureAtlas.dispose();
			textureAtlas = null;
			this.removeFromParent(true);
			
			super.dispose();
			trace("[X] Удалена анимации кровь");
		}
		*/
		
		private function onComplete(e:Event):void 
		{
			removeEventListener(Event.COMPLETE, onComplete);
		
			stop();
			Starling.juggler.removeTweens(this);
			while (this.numFrames > 1)
			{
				this.removeFrameAt(0);
			}
			if(textureAtlas != null) textureAtlas.dispose();
			textureAtlas = null;
			this.removeFromParent(true);
			
			super.dispose();
			System.gc();
			trace("[X] Удалена анимации Blood");
		}
		
		
		
		
	}

}