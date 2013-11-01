package game.model.service 
{
	/**
	 * ...
	 * @author messia_s
	 */
	
	 
	 import flash.display.MovieClip;
	 import flash.events.Event;
	 import flash.events.KeyboardEvent;
	 import flash.events.MouseEvent;
	 import flash.events.TimerEvent;
	 import flash.geom.Point;
	 import flash.media.Sound;
	 import flash.utils.Timer;
	 import game.common.interfaces.*;
	import game.common.GameFacade;
	import game.common.SharedConst;
	import game.common.Utils;
	import org.puremvc.as3.interfaces.IProxy;
	import org.puremvc.as3.patterns.proxy.Proxy;
	import flash.net.URLRequest;
	import game.common.SoundPlayer;
	import flash.media.SoundMixer;
	import flash.utils.ByteArray;
	import flash.system.System;
	
	
	public class GameService extends Proxy implements IProxy,IGameService
	{
		
		private var mcCreatures:MovieClip = new MovieClip;
		private var mcMap:MovieClip= new MovieClip;
		private var mcInterface:MovieClip= new MovieClip;
		
		
		private var currentStep:int = 0;
		
		//private var movingObject:Object = new Object;
		private var actionTimer:Timer = new Timer(SharedConst.ACTION_TIME);
		private var keyHeroes:Array = [];
		public static var iteration:Number = 0;
		private var currentLevelType:String;
		
		
		private var humans:Array;
		private var animals:Array = new Array;
		private var humansGroup:Array;
		private var points:Array;
		private var groupsOnPoint:Array;
		private var playerData:Object;
		private var movingObject:Object = { up:0, down:0, left:0, right:0 };
		private var isPlayerMove:Boolean = true;
		private var frozenDistance:int;
		
		private var currentGroups:int = 1
		private var currentDispersion:int = 50;
		private var currentLevelArray:Array;
		private var obstacles:Array = new Array;
		private var introClip:IntroClip;
		
		private var lastObjectLong:int = 0;
		public function GameService(pname:String,data:Object = null ):void 
		{
			proxyName = pname;//SharedConst.GAME_SERVICE;
			GameFacade.getInstance().registerProxy(this);
			init();
		}
		
		public function init():void {
			//proxyName = SharedConst.GAME_SERVICE;
			GameFacade.getInstance().mainStage.focus = GameFacade.getInstance().mainStage;
			GameFacade.getInstance().mainStage.addChild(mcMap);
			GameFacade.getInstance().mainStage.addChild(mcCreatures);
			GameFacade.getInstance().mainStage.addChild(mcInterface);
			actionTimer.addEventListener(TimerEvent.TIMER, onActionTimer);
			createMap();
			startIntro();
			
			
			
			//setStartTargets();
			//setPlayer();
			//startLevel();
			
		}
		
		private function startIntro():void 
		{
			introClip = new IntroClip;
			GameFacade.getInstance().mainStage.addChild(introClip);
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
			createHumans();
			createGroups(currentGroups);
			createInterface();
			startLevel();
		}
		
		private function createHumans():void 
		{
			humans = new Array;
			
			for (var i:int = 0; i < SharedConst.TRIBE_SIZE;i++)
			{	
				var newPoint:Point = new Point(375 + Math.random() * currentDispersion, SharedConst.TRIBE_VERTICAL_POSITION + Math.random() * currentDispersion);
				sendNotification(SharedConst.CMD_CREATE_HUMAN, { name:"human" + String(i), coord:newPoint } );
				SharedConst.LAST_HUMAN_NAME = i;
				humans.push("human" + String(i))
				
			}
			createNewShaman();
		}
		public function createNewShaman():void 
		{
			var shaman:int = int(humans.length / 2);
			getHuman(humans[shaman]).makeShaman();
		}
		
		
		
		private function createMap():void 
		{
			var mapData:Object = {};
			mapData["level"] = SharedConst.CURRENT_LEVEL;
			sendNotification(SharedConst.CMD_CREATE_MAP, mapData);
		}
		
		private function createInterface():void 
		{
			sendNotification(SharedConst.CMD_CREATE_INTERFACE, null);
		}
		
		
		private function startLevel():void 
		{
			if (SharedConst.CURRENT_LEVEL % 2 != 0)
				currentLevelType = SharedConst.LEVELTYPE_SCROLLER;
				
			currentLevelArray = SharedConst.LEVELS_ARRAY[SharedConst.CURRENT_LEVEL-1];
			actionTimer.start();
			
			//GameFacade.getInstance().mainStage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyPush);
			//GameFacade.getInstance().mainStage.addEventListener(KeyboardEvent.KEY_UP,onKeyUnpressed);
		}
		
		private function nullRightClick(e:MouseEvent):void
		{
			
		}
		public function regroup(action:String):void 
		{
			if (isPlayerMove)
			{
				switch (action)
				{
					case "leftClick":
						onLeftClick(null);
						break;
					case "rightClick":
						onRightClick(null);
						break;
				}
			}
		}
		
		private function onLeftClick(e:MouseEvent):void 
		{
			if (currentGroups > 1)
			{
				
				currentGroups--;
				
				createGroups(currentGroups);
				
			}
				
		}
		
		private function onRightClick(e:MouseEvent):void 
		{
			if (currentGroups < humans.length)
			{
				
				currentGroups++;
				createGroups(currentGroups);
			}
		}
		
		private function blockMove(dist:int):void 
		{
			isPlayerMove = false;
			frozenDistance = dist;
		}
		
	
		
		
		private function onActionTimer(e:TimerEvent):void 
		{
			iteration++;
			//GameFacade.getInstance().iteration = iteration;
			//sendNotification(SharedConst.NEW_ITER, { "iteration":iteration } );
			var i:int = 0;
			if (isPlayerMove)
			{
				while (i < humans.length)
				{
						getHuman(humans[i]).makeStep();
						i++
				}
			}
			switch (currentLevelType)
			{
				case SharedConst.LEVELTYPE_SCROLLER:
					scrollerAction();
					
					break;
			}
			
			i = 0;
			while (i < animals.length)
			{
					getAnimal(animals[i]).makeStep();
					i++
			}
			
			if (iteration % 15 == 0)
			{
				SharedConst.SUPPLIES -= SharedConst.SUPPLIES_EAT * humans.length
				
				if (SharedConst.SUPPLIES <= 0 && humans.length>0)
				{
					SharedConst.SUPPLIES = 0;
					var num:int = int(Math.random()*(humans.length-1))
					checkTribe(makeDead(humans[num],num,"normalCorpse"))
				}
				sendNotification(SharedConst.CHANGE_SUPPLIES );
			}
		}
		
		private function scrollerAction():void 
		{
			(GameFacade.getInstance().retrieveProxy(SharedConst.MAP_SERVICE) as ILevelDesign).moveMap( -SharedConst.MAP_SPEED);
			SharedConst.SPEND_DISTANCE += SharedConst.MAP_SPEED;
			if (!isPlayerMove)
			{
				frozenDistance-= SharedConst.MAP_SPEED;
				if (frozenDistance <= 1)
				{
					isPlayerMove = true;
				}
			}
			if (currentLevelArray.length>0 && currentLevelArray[0].distance <= SharedConst.SPEND_DISTANCE)
			{
				createObject(currentLevelArray[0])
				currentLevelArray.shift();
			} else if (currentLevelArray.length == 0)
			{
				createRandomObstacle();
				
				
			}
			
			if (obstacles.length>0 && obstacles[0].distance <= SharedConst.SPEND_DISTANCE)
			{
				var needShaman:Boolean = false;
				for (var hNum:int = 0; hNum < humans.length;hNum++ )
				{
					var h:String = humans[hNum];
					var human:IHuman = getHuman(h);
					var isAlive:Boolean = false;
					for each(var zones:Array in obstacles[0].safeZones)
					{
						//trace(zones);
						if (Utils.xInInterval(human.getCurrentPoint().x, zones[0], zones[1]))
						{				
							isAlive = true;
							break;
						}
					}
					if (!isAlive)
					{
						var nS:Boolean = makeDead(h, hNum, "normalCorpse");
						if (nS)
							needShaman = true;
						hNum--;
					}
				}
				
				SharedConst.SHAMAN_LEVEL++;
				checkTribe(needShaman)
				
				//if (obstacles[0].distance <= SharedConst.SPEND_DISTANCE)
				blockMove(obstacles[0].long);
				obstacles.shift();
				
				
			}
		}
		
		private function createRandomObstacle():void 
		{
			var types:Array = ["river", "animal"];
				var bridges:Array = [1, 2];
				//var animals:Array = ["antelope", "crocodyle"];
				
				var distance:int = lastObjectLong + 50 + Math.random()*300+SharedConst.SPEND_DISTANCE;
				var objects:Array;
				var type:String = "";
				var safeZones:Array = [];
				var position:int = 0;
				var long:int = 200;
				if (Math.random() > .3)//animal
				{
					lastObjectLong = 0;
					objects = ["animal"]
					position = 100 + Math.random() * (SharedConst.STAGE_WIDTH - 200);
					if (Math.random() > .8)//antelope
					{
						type = "antelope"
					} else if (Math.random() > .6)//strangers
					{
						type = "strangers"
					} else if (Math.random() > .4)//berry
					{
						type = "berry"
					}else //crocodyle
					{
						type = "crocodyle"
					}
				} else //river
				{
					long = 200;
					
					if (Math.random() > 0.5)//1
					{
						objects = ["river", "bridge1"];
						safeZones = [[300, 500]]
					} else //2
					{
						objects = ["river", "bridge2"];
						safeZones = [[210, 320], [490, 590]]
					}
					lastObjectLong = long;
				}
				currentLevelArray.push({"distance":distance,"objects":objects,"type":type,"safeZones":safeZones,"position":position,"long":long})
		}
		
		private function makeDead(humanName:String,hNum:int,death:String=""):Boolean 
		{
			var human:IHuman = getHuman(humanName);
			var needShaman:Boolean = false;
			if (	human.makeDead() == "shaman")
				needShaman = true;
			humans.splice(hNum, 1);
			(GameFacade.getInstance().retrieveProxy(SharedConst.MAP_SERVICE) as ILevelDesign).addToObjects(death,human.getCurrentPoint().x,human.getCurrentPoint().y)
			//hNum--;
			//trace(h, "is dead");
			return needShaman;
		}
		
		private function checkTribe(needShaman:Boolean):void 
		{
			if (humans.length > 0)
			{
				
				if (needShaman)
				{
					SharedConst.SHAMAN_LEVEL = 1;
					createNewShaman();
				} else 
				{
					
				}
				//createGroups(currentGroups);
			} else 
			{
				actionTimer.stop();
				
			}
			sendNotification(SharedConst.CHANGE_PEOPLE, { num:humans.length } );
		}
		
		public function createObject(levelObject:Object):void 
		{
			for each(var object:String in levelObject.objects)
			{
				
				if (object.indexOf("bridge") >= 0)
				{
					obstacles.push( { distance:SharedConst.SPEND_DISTANCE + SharedConst.STAGE_HEIGHT - SharedConst.TRIBE_VERTICAL_POSITION*1.5, safeZones:levelObject.safeZones, long:levelObject.long } )
						//trace(obstacles[0].safeZones);
				} else if (object.indexOf("show_help") >= 0)
				{
					//trace("SHOW HELP");
					sendNotification(object, null);
				}else if (object=="animal")
				{
					var aname:String = levelObject.type + String(animals.length)
					sendNotification(SharedConst.CMD_CREATE_ANIMAL, { name:aname, coord:new Point(levelObject.position, SharedConst.STAGE_HEIGHT), type: levelObject.type} );
					animals.push(aname);
				}
				
				(GameFacade.getInstance().retrieveProxy(SharedConst.MAP_SERVICE) as ILevelDesign).addToObjects(object);
			}
		}
		
		
		public function getHuman(hName:String):IHuman
		{
			return GameFacade.getInstance().retrieveProxy(hName) as IHuman
		}
		
		public function getAnimal(hName:String):IAnimal
		{
			return GameFacade.getInstance().retrieveProxy(hName) as IAnimal;
		}
		
		private function copyObject ( objectToCopy:* ):*
		{
			var stream:ByteArray = new ByteArray();
			stream.writeObject( objectToCopy );
			stream.position = 0;
			return stream.readObject();
		}
		
		private function createGroups(num:int):void 
		{
			if (num > humans.length)
				{
					num = humans.length;
					currentGroups = num;
				}
			var i:int = 0;
			var j:int = 0;
			points = new Array;
			groupsOnPoint = new Array();
			humansGroup = new Array;
			createPoints(0, SharedConst.STAGE_WIDTH, num);
			
			//trace("currentGroups:", num, "numPoints:",points.length);
			while (i < humans.length)
			{
				groupsOnPoint[j]++;
				i++;
				j++;
				if (j >= points.length)
					j = 0;
			}
			i = 0;
			for (var group:int = 0; group < groupsOnPoint.length; group++)
			{
				humansGroup[group] = new Array;
				while (groupsOnPoint[group] > 0)
				{
					humansGroup[group].push(humans[i]);
					getHuman(humans[i]).setCurrentPoint(new Point(points[group] - int(currentDispersion / 2) + Math.random() * currentDispersion, SharedConst.TRIBE_VERTICAL_POSITION + Math.random() * currentDispersion));
					groupsOnPoint[group]--;
					i++;
				}
				//trace(humansGroup[group]);
			}
		}
		
		private function createPoints(startPoint:int, endPoint:int, num:int):void
		{
			var step:int = int((endPoint - startPoint) / (num + 1));
			currentDispersion = int(step / 6);
			SharedConst.CURRENT_DISPERSION = currentDispersion;
			var i:int = 1;
			while (startPoint + i * step < endPoint-step/2)
			{
				points.push(startPoint + i * step)
				groupsOnPoint.push(0);
				i++;
			}
			/*if (points.length >= 5) {
				SharedConst.MAP_SPEED = 2;
			}else {
				SharedConst.MAP_SPEED = 3;
			}*/
			//trace(points);
		}
		
		public function killGroup(what:int):void 
		{
			var num:int = points.indexOf(what);
			for each(var hName:String in humansGroup[num])
			{
				checkTribe(makeDead(hName,humans.indexOf(hName),"bloodyCorpse"))
			}
			onLeftClick(null);
			//createGroups(currentGroups);
		}
		
		public function addToTribe(what:int):void 
		{
			for (var i:int = 0; i < what;i++)
			{	
				var newPoint:Point = new Point(375 + Math.random() * currentDispersion, SharedConst.TRIBE_VERTICAL_POSITION + Math.random() * currentDispersion);
				sendNotification(SharedConst.CMD_CREATE_HUMAN, {name:"human"+String(SharedConst.LAST_HUMAN_NAME+1),coord:newPoint});
				humans.push("human" + String(SharedConst.LAST_HUMAN_NAME + 1))
				SharedConst.LAST_HUMAN_NAME++;
				
			}
			createGroups(currentGroups);
			sendNotification(SharedConst.CHANGE_PEOPLE, { num:humans.length } );
		}
		
		public function bornPeople():void 
		{
			if (SharedConst.SUPPLIES > 3)
			{
				SharedConst.SUPPLIES -= 3;
				addToTribe(5);
				sendNotification(SharedConst.CHANGE_SUPPLIES);
			}
		}
		
		public function sacrificePeople():void 
		{
			if (humans.length > 5)
			{
				SharedConst.SUPPLIES += 3;
				checkTribe(makeDead(humans[humans.length - 1], humans.length - 1, "bloodyCorpse"));
				checkTribe(makeDead(humans[0], 0, "bloodyCorpse"));
				checkTribe(makeDead(humans[humans.length - 1], humans.length - 1, "bloodyCorpse"));
				checkTribe(makeDead(humans[0], 0, "bloodyCorpse"));
				checkTribe(makeDead(humans[humans.length - 1], humans.length - 1,"bloodyCorpse"));
				sendNotification(SharedConst.CHANGE_SUPPLIES);
			}
		}
		
		public function getGroupSize():int 
		{
			return humansGroup[0].length;
		}
		
		public function getGroupPoints():Array 
		{
			return points;
		}
		
		public function getMapClip():MovieClip 
		{
			return mcMap;
		}
		public function getCreaturesClip():MovieClip 
		{
			return mcCreatures;
		}
		public function getInterfaceClip():MovieClip 
		{
			return mcInterface;
		}
		
		
		
	}

}