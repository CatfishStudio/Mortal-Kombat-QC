package mkquest.assets.animation 
{
	import flash.utils.ByteArray;
	
	import starling.events.Event;
	import starling.display.MovieClip;
	import starling.core.Starling;
	import starling.events.EventDispatcher;
	import starling.textures.TextureAtlas;
	import starling.textures.Texture;
	
	import mkquest.assets.statics.Constants;
	import mkquest.assets.statics.Resource;
	
	public class Actions extends MovieClip 
	{
		private var _statusLoop:Boolean = true;
		private var _fighterName:String;
		private var _nameGroupTexture:String;
		private var _direction:String;
		
		private var textureAtlas:TextureAtlas;
		
		public function Actions(_x:int, _y:int, statusLoop:Boolean, fighterName:String, nameGroupTexture:String, direction:String) 
		{
			_statusLoop = statusLoop;
			_fighterName = fighterName;
			_nameGroupTexture = nameGroupTexture;
			_direction = direction;
			
			selectFighterTextureAtlas(_fighterName);
			super(textureAtlas.getTextures(_nameGroupTexture + "_" + _direction + "_"), 12);
			
			x = _x;
			y = _y;
			scaleX += 0.5;
			scaleY += 0.5;
			
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			addEventListener(Event.REMOVED_FROM_STAGE, onRemoveFromStage);
			addEventListener(Event.COMPLETE, onComplete);
		}
		
		public function setTextureAtlasEmbeddedAsset(ClassAtlasSprite:Class, ClassAtlasSpritesXML:Class):void
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
		
		private function selectFighterTextureAtlas(fighterName:String):void
		{
			if (fighterName == Constants.LIUKANG)
			{
				setTextureAtlasEmbeddedAsset(Resource.AtlasSpritesLiukang, Resource.AtlasSpritesLiukangXML);
			}
			if (fighterName == Constants.KUNGLAO)
			{
				setTextureAtlasEmbeddedAsset(Resource.AtlasSpritesKunglao, Resource.AtlasSpritesKunglaoXML);
			}
			if (fighterName == Constants.JOHNNYCAGE)
			{
				setTextureAtlasEmbeddedAsset(Resource.AtlasSpritesJohnnycage, Resource.AtlasSpritesJohnnycageXML);
			}
			if (fighterName == Constants.REPTILE)
			{
				setTextureAtlasEmbeddedAsset(Resource.AtlasSpritesReptile, Resource.AtlasSpritesReptileXML);
			}
			if (fighterName == Constants.SUBZERO)
			{
				setTextureAtlasEmbeddedAsset(Resource.AtlasSpritesSubzero, Resource.AtlasSpritesSubzeroXML);
			}
			if (fighterName == Constants.SHANGTSUNG)
			{
				setTextureAtlasEmbeddedAsset(Resource.AtlasSpritesShangtsung, Resource.AtlasSpritesShangtsungXML);
			}
			if (fighterName == Constants.KITANA)
			{
				setTextureAtlasEmbeddedAsset(Resource.AtlasSpritesKitana, Resource.AtlasSpritesKitanaXML);
			}
			if (fighterName == Constants.JAX)
			{
				setTextureAtlasEmbeddedAsset(Resource.AtlasSpritesJax, Resource.AtlasSpritesJaxXML);
			}
			if (fighterName == Constants.MILEENA)
			{
				setTextureAtlasEmbeddedAsset(Resource.AtlasSpritesMileena, Resource.AtlasSpritesMileenaXML);
			}
			if (fighterName == Constants.BARAKA)
			{
				setTextureAtlasEmbeddedAsset(Resource.AtlasSpritesBaraka, Resource.AtlasSpritesBarakaXML);
			}
			if (fighterName == Constants.SCORPION)
			{
				setTextureAtlasEmbeddedAsset(Resource.AtlasSpritesScorpion, Resource.AtlasSpritesScorpionXML);
			}
			if (fighterName == Constants.RAIDEN)
			{
				setTextureAtlasEmbeddedAsset(Resource.AtlasSpritesRaiden, Resource.AtlasSpritesRainedXML);
			}
		}
		
		private function onAddedToStage(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			name = Constants.ACTIONS;
						
			loop = _statusLoop;
			play();
			
			Starling.juggler.add(this);
		}
		
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
			trace("[X] Удалена анимации бойца");
		}
		
		private function onComplete(e:Event):void 
		{
			if (_statusLoop == false)
			{
				removeEventListener(Event.COMPLETE, onComplete);
				dispatchEvent(new Event(Event.COMPLETE));
			}
		}
	}

}