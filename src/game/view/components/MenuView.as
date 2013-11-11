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
		private var story:FinalStory = new FinalStory;
		
		
		
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
			
			randomViewToAll();
			
			
			
			
		}
		
		public function randomViewToAll():void 
		{
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
			randomView(body.level41, false);
			
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
			dispatchEvent(new Event("wait"));
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
		
		public function onlyViewMenu():void 
		{
			GameFacade.getInstance().OtherClip.addChild(movie);
			checkBG();
		}
		
		public function viewMenu():void 
		{
			GameFacade.getInstance().OtherClip.addChild(movie);
			checkBG();
			//makeActive(body.bWait);
			SharedConst.SPEND_DISTANCE = 0;
			if (SharedConst.SUPPLIES > 10 && SharedConst.LEVELS_IN_GAME.length<2)
			{
				makeActive(body.bWait);
			} else 
			{
				makeInactive(body.bWait);
			}
			switch(SharedConst.LAST_LEVEL)
			{
				case "":
					
					break;
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
					createFinalStory();
					break;
				case "41":
					makePast(body.level41);
					makeInactive(body.level40);
					createFinalStory();
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
		
		private function createFinalStory():void 
		{
			
			GameFacade.getInstance().mainStage.addChild(story);
			
			trace("TRIBESIZE:", SharedConst.TRIBE_SIZE, ", FOOD:", SharedConst.SUPPLIES, ", SHAMAN:", SharedConst.SHAMAN_LEVEL, ", HUNTING:", SharedConst.SUCCEED_HUNTING, ", PLANTING:", SharedConst.SUCCEED_PLANTING, ", CANNIBALISM:", SharedConst.SUCCEED_CANNIBALISM, ", DIPLOMACY:", SharedConst.SUCCEED_DIPLOMACY);
			
			story.storyText.text = "";
			
			if (SharedConst.TRIBE_SIZE > 25)
			{
				addToStory(SharedConst.GAME_RESULTS.size[0]);
				if (SharedConst.SUPPLIES > SharedConst.TRIBE_SIZE)
				{
					addToStory(SharedConst.GAME_RESULTS.food[0]);
					storyShamanLevel(0);
				} else 
				{
					addToStory(SharedConst.GAME_RESULTS.food[1]);
					storyShamanLevel(1);
				}
			} else 
			{
				addToStory(SharedConst.GAME_RESULTS.size[1]);
				if (SharedConst.SUPPLIES > SharedConst.TRIBE_SIZE)
				{
					addToStory(SharedConst.GAME_RESULTS.food[2]);
					storyShamanLevel(0);
				} else 
				{
					addToStory(SharedConst.GAME_RESULTS.food[3]);
					storyShamanLevel(1);
				}
			}
			
			
			
		}
		
		private function storyShamanLevel(situation:int):void 
		{
			switch (situation)
			{
				case 0:
					if (SharedConst.SHAMAN_LEVEL > 15)
					{
						addToStory(SharedConst.GAME_RESULTS.level[0]);
						storyHunting(1);
					} else 
					{
						addToStory(SharedConst.GAME_RESULTS.level[2]);
						storyHunting(3);
					}
					break;
				case 1:
					if (SharedConst.SHAMAN_LEVEL > 15)
					{
						addToStory(SharedConst.GAME_RESULTS.level[3]);
						storyHunting(3);
					} else 
					{
						addToStory(SharedConst.GAME_RESULTS.level[1]);
						storyHunting(2);
					}
					break;
			}
		}
		
		private function storyHunting(situation:int):void 
		{
			var huntToPlant:Number = SharedConst.SUCCEED_HUNTING / SharedConst.SUCCEED_PLANTING;
			if (situation == 1 || situation == 3)
			{
				if (huntToPlant > 1.3)
				{
					addToStory(SharedConst.GAME_RESULTS.hunting[0]);
					endStory(situation, "a");
				} else if (huntToPlant < .7)
				{
					addToStory(SharedConst.GAME_RESULTS.hunting[1])
					endStory(situation, "b");
				} else 
				{
					addToStory(SharedConst.GAME_RESULTS.hunting[2])
					endStory(situation, "c");
				}
			} else 
			{
				if (huntToPlant > 1.3)
				{
					addToStory(SharedConst.GAME_RESULTS.hunting[3])
					endStory(situation, "a");
				} else if (huntToPlant < .7)
				{
					addToStory(SharedConst.GAME_RESULTS.hunting[4])
					endStory(situation, "b");
				} else 
				{
					addToStory(SharedConst.GAME_RESULTS.hunting[5])
					endStory(situation, "c");
				}
			}
		}
		
		private function endStory(situation:int, hunting:String):void 
		{
			var cannToDip:Boolean = (SharedConst.SUCCEED_CANNIBALISM>3*SharedConst.SUCCEED_DIPLOMACY)
			switch (String(String(situation)+hunting))
			{
				case "1a":
					if (cannToDip)
					{
						addToStory(SharedConst.GAME_RESULTS.cannibalism[0])
					} else 
					{
						addToStory(SharedConst.GAME_RESULTS.cannibalism[2])
					}
					break;
				case "1b":
					if (cannToDip)
					{
						addToStory(SharedConst.GAME_RESULTS.cannibalism[1])
					} else 
					{
						addToStory(SharedConst.GAME_RESULTS.cannibalism[3])
					}
					break;
				case "1c":
					if (cannToDip)
					{
						addToStory(SharedConst.GAME_RESULTS.cannibalism[1])
					} else 
					{
						addToStory(SharedConst.GAME_RESULTS.cannibalism[3])
					}
					break;
				
				case "3a":
					if (cannToDip)
					{
						addToStory(SharedConst.GAME_RESULTS.cannibalism[4])
					} else 
					{
						addToStory(SharedConst.GAME_RESULTS.cannibalism[7])
					}
					break;
				case "3b":
					if (cannToDip)
					{
						addToStory(SharedConst.GAME_RESULTS.cannibalism[5])
					} else 
					{
						addToStory(SharedConst.GAME_RESULTS.cannibalism[8])
					}
					break;
				case "3c":
					if (cannToDip)
					{
						addToStory(SharedConst.GAME_RESULTS.cannibalism[6])
					} else 
					{
						addToStory(SharedConst.GAME_RESULTS.cannibalism[9])
					}
					break;
					
				case "2a":
					if (cannToDip)
					{
						addToStory(SharedConst.GAME_RESULTS.cannibalism[10])
					} else 
					{
						addToStory(SharedConst.GAME_RESULTS.cannibalism[13])
					}
					break;
				case "2b":
					if (cannToDip)
					{
						addToStory(SharedConst.GAME_RESULTS.cannibalism[11])
					} else 
					{
						addToStory(SharedConst.GAME_RESULTS.cannibalism[14])
					}
					break;
				case "2c":
					if (cannToDip)
					{
						addToStory(SharedConst.GAME_RESULTS.cannibalism[12])
					} else 
					{
						addToStory(SharedConst.GAME_RESULTS.cannibalism[15])
					}
					break;
			}
		}
		
		
		
		
		
		
		private function addToStory(s:String):void 
		{
			story.storyText.text += "\n \n";
			story.storyText.text += s;
		}
		
	}

}