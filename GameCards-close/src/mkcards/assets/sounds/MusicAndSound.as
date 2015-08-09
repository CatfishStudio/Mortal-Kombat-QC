package mkcards.assets.sounds 
{
	import flash.events.Event;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import mkcards.assets.statics.Resource;
	
	public class MusicAndSound 
	{
		
		/* Звуки -------------------------- */
		public static var musicMelody:Sound;
		public static var musicChannel:SoundChannel;
		public static var sound:Sound;
		
		public static var melodyIndex:int = 0;
		
		/*
		[Embed(source = '../media/music/music1.mp3')]
		public static var Music1:Class;
		[Embed(source = '../media/music/music2.mp3')]
		public static var Music2:Class;
		[Embed(source = '../media/music/music3.mp3')]
		public static var Music3:Class;
		
		[Embed(source = '../media/sounds/button.mp3')]
		public static var Sound1:Class;
		[Embed(source = '../media/sounds/f_01.mp3')]
		public static var Sound2:Class;
		[Embed(source = '../media/sounds/f_02.mp3')]
		public static var Sound3:Class;
		[Embed(source = '../media/sounds/f_d_03.mp3')]
		public static var Sound4:Class;
		[Embed(source = '../media/sounds/fight.mp3')]
		public static var Sound5:Class;
		[Embed(source = '../media/sounds/hit_1_5.mp3')]
		public static var Sound6:Class;
		[Embed(source = '../media/sounds/hit_2_4.mp3')]
		public static var Sound7:Class;
		[Embed(source = '../media/sounds/hit_block.mp3')]
		public static var Sound8:Class;
		[Embed(source = '../media/sounds/hit_move.mp3')]
		public static var Sound9:Class;
		[Embed(source = '../media/sounds/Lost.mp3')]
		public static var Sound10:Class;
		[Embed(source = '../media/sounds/m_01.mp3')]
		public static var Sound11:Class;
		[Embed(source = '../media/sounds/m_02.mp3')]
		public static var Sound12:Class;
		[Embed(source = '../media/sounds/m_d_03.mp3')]
		public static var Sound13:Class;
		[Embed(source = '../media/sounds/wins.mp3')]
		public static var Sound14:Class;
		/* -------------------------------- */
		
		
		/* МУЗЫКА -------------------------------------------------*/
		public static function MusicInit(MusicClass:Class):void
		{
			musicMelody = new MusicClass() as Sound;
		}
		
		public static function PlayMusic():void
		{
			if (Resource.musicOn == true) {
				musicChannel = musicMelody.play();
				musicChannel.addEventListener(Event.SOUND_COMPLETE, PlayMusicLoop);
			}
		}
		
		public static function PlayMusicLoop(e:Event):void
		{
			SoundChannel(e.target).removeEventListener(e.type, PlayMusicLoop);
			if (Resource.musicOn == true) PlayMusic();
		}
		
		public static function StopMusic():void
		{
			if (musicChannel != null) musicChannel.stop();
		}
		/*---------------------------------------------------------*/
		
		/*ЗВУКИ --------------------------------------------------*/
		public static function PlaySound(SoundClass:Class):void
		{
			if (Resource.soundOn)
			{
				sound = new SoundClass() as Sound;
				sound.play();
			}
		}
		/*---------------------------------------------------------*/
	}

}