package game.view.components 
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.geom.Rectangle;
	import flash.display.Sprite;
	import flash.display.MovieClip;
	import flash.display.Shape;
	import flash.events.EventDispatcher;
	import flash.utils.Timer;
	import game.common.GameFacade
	import game.common.interfaces.*;
	import game.common.SharedConst;
	import game.common.Utils;
	import flash.system.*;
	
	/**
	 * ...
	 * @author messia_s
	 */
	public class MenuView extends EventDispatcher 
	{
		private var movie:Sprite = new Sprite;
		private var body:LevelMap;
		private var humanName:String = "";
		private var helpClip:MovieClip;
		private var helpTimer:Timer = new Timer(1000);
		
		
		
		public function MenuView(hName:String) 
		{
			init();
		}
		
		public function init():void {
			
			GameFacade.getInstance().OtherClip.addChild(movie);
			//var body:Rectangle = new Rectangle(0, 0, 20, 20);
			body = new LevelMap();
			movie.addChild(body);
			//trace("here");
			body.bg.gotoAndStop(1);
			
			randomView(body.level0,true);
			//body.level0.addEventListener(MouseEvent.CLICK, onStartGame);
			
			randomView(body.level10, false);
			randomView(body.level11, false);
			
			
			randomView(body.level20, false);
			randomView(body.level21, false);
			randomView(body.level22, false);
			
			randomView(body.level30, false);
			randomView(body.level31, false);
			randomView(body.level32, false);
			
			randomView(body.level40, false);
			randomView(body.level41,false);
			
			
			body.bWait.alpha = .5;
			body.bWait.addEventListener(MouseEvent.CLICK, onWait);
			makeInactive(body.bWait);
			body.bWait.alpha = 0;
		}
		
		private function randomView(what:MovieClip,isActive:Boolean):void 
		{
			var frame:int = Math.round(Math.random() * (SharedConst.LEVELS_IN_GAME.length-1))
			what.gotoAndStop(SharedConst.LEVELS_IN_GAME[frame]);
			SharedConst.LEVELS_IN_GAME.splice(frame, 1);
			//what.gotoAndStop(1 + Math.round(Math.random() * (body.level0.totalFrames - 1)))
			what.addEventListener(MouseEvent.CLICK, onLevelClick);
			what.mouseChildren = false;
			if (isActive)
			{
				what.buttonMode = true;
				makeActive(what);
			} else {
				makeInactive(what);
			}
		}
		
		private function onWait(e:MouseEvent):void 
		{
			SharedConst.SUPPLIES -= 10;
			Utils.changeDaytime();
			checkBG();
			makeInactive(body.bWait);
		}
		
		private function checkBG():void 
		{
			if (SharedConst.CURRENT_DAYTIME == "day")
			{
				body.bg.gotoAndStop(1);
			} else 
			{
				body.bg.gotoAndStop(2);
			}
		}
		
		private function onStartGame(e:MouseEvent):void 
		{
			trace("LAND_TYPE:", e.target.currentFrame);
			GameFacade.getInstance().OtherClip.removeChild(movie);
			SharedConst.LAND_TYPE = e.target.currentFrame;
			
			dispatchEvent(new Event("startGame"))
			
		}
		
		private function onLevelClick(e:MouseEvent):void 
		{
			GameFacade.getInstance().OtherClip.removeChild(movie);
			SharedConst.LAND_TYPE = e.target.currentFrame;
			trace("level",(e.target as MovieClip).name.split("level")[1]);
			SharedConst.LAST_LEVEL = (e.target as MovieClip).name.split("level")[1];
			SharedConst.CURRENT_STATE = "";
			dispatchEvent(new Event("startGame"))
		}
		
		public function viewMenu():void 
		{
			GameFacade.getInstance().OtherClip.addChild(movie);
			checkBG();
			//makeActive(body.bWait);
			SharedConst.SPEND_DISTANCE = 0;
			if (SharedConst.SUPPLIES > 10)
			{
				makeActive(body.bWait);
			} else 
			{
				makeInactive(body.bWait);
			}
			switch(SharedConst.LAST_LEVEL)
			{
				case "0":
					makeActive(body.level10);
					makeActive(body.level11);
					makePast(body.level0);
					break;
				case "10":
					makeActive(body.level20);
					makeActive(body.level21);
					makePast(body.level10);
					makeInactive(body.level11);
					break;
				case "11":
					makeActive(body.level22);
					makeActive(body.level21);
					makePast(body.level11);
					makeInactive(body.level10);
					break;
					
				case "20":
					makeActive(body.level30);
					makeActive(body.level31);
					makePast(body.level20);
					makeInactive(body.level21);
					makeInactive(body.level22);
					break;
				case "21":
					makeActive(body.level30);
					makeActive(body.level31);
					makeActive(body.level32);
					makePast(body.level21);
					makeInactive(body.level20);
					makeInactive(body.level22);
					break;
				case "22":
					makeActive(body.level32);
					makeActive(body.level31);
					makePast(body.level22);
					makeInactive(body.level21);
					makeInactive(body.level20);
					break;
					
				case "30":
					makeActive(body.level40);
					makeInactive(body.level41);
					makePast(body.level30);
					makeInactive(body.level31);
					makeInactive(body.level32);
					break;
				case "31":
					makeActive(body.level40);
					makeActive(body.level41);
					makePast(body.level31);
					makeInactive(body.level30);
					makeInactive(body.level32);
					break;
				case "32":
					makeInactive(body.level40);
					makeActive(body.level41);
					makePast(body.level32);
					makeInactive(body.level31);
					makeInactive(body.level30);
					break;
				case "40":
					makePast(body.level40);
					makeInactive(body.level41);
					break;
				case "41":
					makePast(body.level41);
					makeInactive(body.level40);
					break;
			}
		}
		
		
		
		private function makeInactive(what:*):void 
		{
			what.mouseEnabled = false;
			try {
				what.bright.visible = true;
				what.past.visible = false;
				
			} catch (er:Error)
			{
				what.alpha = .7;
			}
			
		}
		
		private function makeActive(what:*):void 
		{
			what.mouseEnabled = true;
			try {
				
				what.buttonMode = true;
				what.bright.visible = false;
				what.past.visible = false;
			} catch (er:Error)
			{
				what.mouseEnabled = true;
				what.alpha = 1;
			}
		}
		
		private function makePast(what:*):void 
		{
			what.mouseEnabled = false;
			try {
				what.past.visible = true;
				what.bright.visible = true;
			} catch (er:Error)
			{
				what.alpha = .7;
			}
		}
		
		public function removeListeners():void 
		{
			
		}
		
		
		
		
		
		
		
		
	}

}