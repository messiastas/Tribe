package game.view.components 
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.geom.Rectangle;
	import flash.display.Sprite;
	import flash.display.MovieClip;
	import flash.display.Shape;
	import flash.events.EventDispatcher;
	import flash.utils.Timer;
	import game.common.GameFacade
	import game.common.interfaces.IHuman;
	import game.common.SharedConst;
	
	/**
	 * ...
	 * @author messia_s
	 */
	public class InterfaceView extends EventDispatcher 
	{
		private var movie:Sprite = new Sprite;
		private var body:interfaceView;
		private var humanName:String = "";
		private var helpClip:MovieClip;
		private var helpTimer:Timer = new Timer(2000);
		
		
		public function InterfaceView(hName:String) 
		{
			init();
		}
		
		public function init():void {
			
			GameFacade.getInstance().mainStage.addChild(movie);
			//var body:Rectangle = new Rectangle(0, 0, 20, 20);
			body = new interfaceView();
			movie.addChild(body);
			trace("here");
			body.bRegroup.addEventListener(MouseEvent.CLICK, onLeftClick);
			body.bRegroup.addEventListener(MouseEvent.RIGHT_CLICK, onRightClick);
			helpTimer.addEventListener(TimerEvent.TIMER, removeHelp);
			changePeople(SharedConst.TRIBE_SIZE);
		}
		
		private function onLeftClick(e:MouseEvent):void 
		{
			dispatchEvent(new Event("leftClick"))
				
		}
		
		private function onRightClick(e:MouseEvent):void 
		{
			dispatchEvent(new Event("rightClick"))
		}
		
		public function showLeft():void 
		{
			helpClip = new HelpLeftClick;
			addHelp();
			
		}
		
		public function showRight():void 
		{
			helpClip = new HelpRightClick;
			addHelp();
		}
		
		private function addHelp():void 
		{
			body.addChildAt(helpClip, 0);
			helpClip.x = 800 / 2;
			helpClip.y = SharedConst.STAGE_HEIGHT / 4;
			helpTimer.start();
		}
		private function removeHelp(e:TimerEvent):void 
		{
			body.removeChild(helpClip);
			helpTimer.reset();
		}
		
		public function changePeople(num:int):void 
		{
			body.people.text = String(num);
			body.shamanLevel.text = String(SharedConst.SHAMAN_LEVEL);
		}
		
		public function changeSupplies(num:int):void 
		{
			body.supplies.text = String(num);
		}
		
		
		
		
		
		
		
		
	}

}