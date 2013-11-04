package game.common 
{
	//import starling.display.Sprite;
	//import starling.display.Stage;
	//import starling.events.Event;
	
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	/**
	 * ...
	 * @author messia_s
	 */
	public class Game extends Sprite 
	{
		public static var mStage:Stage;
		private var introClip:MovieClip;
		
		public function Game() 
		{
			addEventListener(Event.ADDED_TO_STAGE, onAdded);
		}
		
		private function onAdded(e:Event):void
		{
		   
		}
		
		public function startGame():void {
			GameFacade.getInstance().mainStage = mStage;
			startIntro();
			
		}
		
		private function startIntro():void 
		{
			introClip = new IntroClip;
			GameFacade.getInstance().mainStage.addChild(introClip);
			GameFacade.getInstance().mainStage.focus = GameFacade.getInstance().mainStage;
			GameFacade.getInstance().mainStage.addEventListener(MouseEvent.CLICK, onIntroSkip);
			GameFacade.getInstance().mainStage.addEventListener(MouseEvent.RIGHT_CLICK, nullRightClick);
			GameFacade.getInstance().mainStage.frameRate = 24;
		}
		
		private function onIntroSkip(e:MouseEvent):void 
		{
			GameFacade.getInstance().mainStage.removeChild(introClip);
			GameFacade.getInstance().mainStage.removeEventListener(MouseEvent.CLICK, onIntroSkip);
			introClip = null;
			GameFacade.getInstance().mainStage.frameRate = 60;
			trace("Game start");
			GameFacade.getInstance().startup(mStage as Stage);
			/*createHumans();
			createGroups(currentGroups);
			createInterface();
			startLevel();*/
		}
		
		private function nullRightClick(e:MouseEvent):void
		{
			
		}
		
	}

}