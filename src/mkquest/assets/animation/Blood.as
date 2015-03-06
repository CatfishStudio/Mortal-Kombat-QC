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
	
	public class Blood extends MovieClip 
	{
		
		public function Blood(textures:Vector.<Texture>, fps:Number=12) 
		{
			super(textures, fps);
			
		}
		
	}

}