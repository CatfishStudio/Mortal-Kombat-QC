package mkquest.assets.animation 
{
	import starling.events.Event;
	import starling.display.MovieClip;
	import starling.core.Starling;
	import starling.events.EventDispatcher;
	import starling.textures.TextureAtlas;
	
	import mkquest.assets.statics.Constants;
	import mkquest.assets.statics.Resource;
	
	public class Actions extends MovieClip 
	{
		private var _statusLoop:Boolean = true;
		private var _fighterName:String;
		private var _nameGroupTexture:String;
		private var _direction:String;
		
		public function Actions(_x:int, _y:int, statusLoop:Boolean, fighterName:String, nameGroupTexture:String, direction:String) 
		{
			_statusLoop = statusLoop;
			_fighterName = fighterName;
			_nameGroupTexture = nameGroupTexture;
			_direction = direction;
			
			Resource.textureAtlas = getSelectFighterTextureAtlas(_fighterName);
			super(Resource.textureAtlas.getTextures(_nameGroupTexture + "_" + _direction + "_"), 12);
			x = _x;
			y = _y;
			scaleX += 0.5;
			scaleY += 0.5;
			
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			addEventListener(Event.REMOVED_FROM_STAGE, onRemoveFromStage);
			addEventListener(Event.COMPLETE, onComplete);
		}
		
		private function getSelectFighterTextureAtlas(fighterName:String):TextureAtlas
		{
			if (fighterName == Constants.LIUKANG)
			{
				return Resource.getTextureAtlasEmbeddedAsset(Resource.AtlasSpritesLiukang, Resource.AtlasSpritesLiukangXML);
			}
			return null;
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