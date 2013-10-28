package game.model.service 
{
	import flash.geom.Point;
	import game.common.interfaces.*
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
	public class AnimalService extends HumanService implements IProxy, IAnimal
	{
		
		private var needToStop:Boolean = true;
		protected var type:String;
		
		
		
		
		
		public function AnimalService(data:Object):void
		{
			super(data);
			type = data.type;
		}
		override public function makeStep():void 
		{
			//trace("ANIMAL STEP",humanName);
			currentPoint.y -= SharedConst.MAP_SPEED;
			if (!needToStop)
			{
				currentPoint.x += Math.sin(currentAngle *0.0175) * currentSpeed;
				currentPoint.y -= Math.cos(currentAngle * 0.0175) * currentSpeed;
			}
			sendNotification(SharedConst.ACTION_MOVE_HUMAN + humanName, { "newX": currentPoint.x, "newY": currentPoint.y } );
			if (Math.abs(currentPoint.y - SharedConst.TRIBE_VERTICAL_POSITION*2)<SharedConst.MAP_SPEED)
			{
				switch(type)
				{
					case "antelope":
						
						if ((GameFacade.getInstance().retrieveProxy(SharedConst.GAME_SERVICE) as IGameService).getGroupSize() > 20)
						{
							trace("ANTELOPE SCARED");
							needToStop = false;
							currentAngle = 270;
						}
						break;
					default:
						trace("SOMEONE SCARED");
						break;
				}
			} else if (Math.abs(currentPoint.y - SharedConst.TRIBE_VERTICAL_POSITION)<SharedConst.MAP_SPEED)
			{
				switch(type)
				{
					case "antelope":
						
						var points:Array = (GameFacade.getInstance().retrieveProxy(SharedConst.GAME_SERVICE) as IGameService).getGroupPoints();
						for each(var point:int in points)
						{
							if (Math.abs(point - currentPoint.x) < 50)
							{
								SharedConst.SUPPLIES += 20;
								sendNotification(SharedConst.ACTION_CHANGE_STATE + humanName, { "newState": "eated"  } );
							}
						}
						break;
					default:
						trace("SOMEONE SCARED");
						break;
				}
			}
		}
		
		
		
		
		
		
		
	}

}