package game.common 
{
	/**
	 * ...
	 * @author messia_s
	 */
	
	 
	 import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundTransform;
	import flash.net.URLRequest;
	import flash.events.Event;
	import flash.system.ApplicationDomain;
	import flash.utils.getDefinitionByName;
	
	
	public class SoundPlayer 
	{
		private var goChannel:SoundChannel;
		private var musicChannel:SoundChannel;
		private var currentMusic:Class;
		private var tune:Sound;
		private static var instance:SoundPlayer;
		
		public function SoundPlayer() 
		{
			
		}
		
		public static function getInstance():SoundPlayer {
			if(SoundPlayer.instance == null){
				SoundPlayer.instance = new SoundPlayer();
			}
			return SoundPlayer.instance;
		}
		
		public function playSound(sound:Sound):void {
			
			if(SharedConst.isSound){	
				/*if( goChannel!=null){
					goChannel.stop();
				}*/
				
				goChannel = sound.play();
				//goChannel.addEventListener(Event.SOUND_COMPLETE,onComplete);
			
				goChannel.soundTransform = new SoundTransform(.3,0)
			} 
		}
		
		public function playMusic(music:Class):void {
			
			if (music != null)
			{
				if( musicChannel!=null){
					musicChannel.stop();
				}
				var sound:Sound = new (music as Class);
				musicChannel = (sound as Sound).play();
				musicChannel.addEventListener(Event.SOUND_COMPLETE, onCompleteMusic);
				currentMusic = music;
			} else if (currentMusic != null)
			{
				if( musicChannel!=null){
					musicChannel.stop();
				}
				sound = new (currentMusic as Class);
				musicChannel = (sound as Sound).play();
				musicChannel.addEventListener(Event.SOUND_COMPLETE, onCompleteMusic);
			}
			if(SharedConst.isSound){
				musicChannel.soundTransform = new SoundTransform(1,0)
			} else 
			{
				musicChannel.soundTransform = new SoundTransform(0,0)
			}
		}
		
		public function stopSound():void {
			if( goChannel!=null){
				goChannel.stop();
			}
		}
		
		public function stopMusic():void {
			if( musicChannel!=null){
				musicChannel.stop();
			}
		}
		
		public function onComplete(e:Event):void {
			//playSound();
		}
		
		public function onCompleteMusic(e:Event):void {
			playMusic(currentMusic);
		}
		
	}

}