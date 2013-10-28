package game.model.service 
{
	import flash.geom.Point;
	import game.common.interfaces.IGameService;
	import game.common.interfaces.IHuman;
	import game.common.interfaces.ILevelDesign;
	import game.common.interfaces.IWeapon;
	import game.common.interfaces.IWorldObject;
	import org.puremvc.as3.interfaces.IProxy;
	import org.puremvc.as3.patterns.proxy.Proxy;
	import game.common.Utils;
	import game.common.SharedConst;
	import game.common.GameFacade;
	import game.model.entity.*;
	import flash.utils.getDefinitionByName;
	import flash.system.ApplicationDomain;
	
	/**
	 * ...
	 * @author messia_s
	 */
	public class HumanService extends Proxy implements IProxy, IHuman 
	{
		protected var humanName:String = "John Smith";
		protected var playerStartData:Object;
		
		protected var currentPoint:Point;
		protected var currentSpeed:Number = 10;
		protected var wayPoint:Point;
		protected var currentAngle:Number = 0;
		protected var currentState:String = "";
		protected var currentStatus:String = "";
		
		
		private var needToStop:Boolean = true;
		
		
		
		
		
		public function HumanService(data:Object):void
		{
			playerStartData = Utils.recursiveCopy(data);
			humanName = playerStartData.name;
			proxyName = humanName
			init();
			
		}
		
		protected function init():void 
		{
			currentPoint = playerStartData["coord"]
			sendNotification(SharedConst.ACTION_MOVE_HUMAN + humanName, { "newX": currentPoint.x, "newY": currentPoint.y } );
			
		}
		
		
		
		
		
		
		protected function calculateAngleToPoint(point:Point):Number
		{
			var a:Number = 180*(-1)*Math.atan2(currentPoint.x-wayPoint.x,currentPoint.y-wayPoint.y)/Math.PI;
			return a;
		}
		
		public function makeStep():void 
		{
			if (!needToStop)
			{
				currentPoint.x += Math.sin(currentAngle *0.0175) * currentSpeed;
				currentPoint.y -= Math.cos(currentAngle * 0.0175) * currentSpeed;
				sendNotification(SharedConst.ACTION_MOVE_HUMAN + humanName, { "newX": currentPoint.x, "newY": currentPoint.y } );
				if (Utils.calculateDistance(currentPoint, wayPoint) < currentSpeed)
				{
					needToStop = true;
				}
			}
		}
		
		
		
		
		
		public function getCurrentPoint():Point
		{
			return currentPoint;
		}
		
		public function setCurrentPoint(newPoint:Point):void
		{
			wayPoint = newPoint;
			currentAngle = calculateAngleToPoint(wayPoint);
			needToStop = false;
			//sendNotification(SharedConst.ACTION_MOVE_HUMAN + humanName, { "newX": currentPoint.x, "newY": currentPoint.y } );
		}
		
		public function getName():String
		{
			return humanName;
		}
		
		public function getState():String
		{
			return currentState;
		}
		
		public function makeShaman():void 
		{
			sendNotification(SharedConst.ACTION_CHANGE_STATE + humanName, { "newState": "shaman"  } );
			currentStatus = "shaman";
			
		}
		
		public function makeDead():String 
		{
			sendNotification(SharedConst.ACTION_CHANGE_STATE + humanName, { "newState": "dead"  } );
			currentState = "dead";
			
			return currentStatus;
		}
		
		
		
		
		
	}

}