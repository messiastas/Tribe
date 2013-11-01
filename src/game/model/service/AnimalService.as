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
			
			sendNotification(SharedConst.ACTION_MOVE_HUMAN + humanName, { "newX": currentPoint.x, "newY": currentPoint.y } );
			if (Math.abs(currentPoint.y - SharedConst.TRIBE_VERTICAL_POSITION*2)<SharedConst.MAP_SPEED)
			{
				switch(type)
				{
					case "antelope":
						
						if ((GameFacade.getInstance().retrieveProxy(SharedConst.GAME_SERVICE) as IGameService).getGroupSize() > 10)
						{
							trace("ANTELOPE SCARED");
							needToStop = false;
							if (currentPoint.x < SharedConst.STAGE_WIDTH / 2)
							{
								
								currentAngle = 270;
							}	else
							{
								sendNotification(SharedConst.ACTION_CHANGE_STATE+humanName,{newState:"AntelopeGoright"})
								currentAngle = 90;
							}
						}
						break;
					case "crocodyle":
						
						if ((GameFacade.getInstance().retrieveProxy(SharedConst.GAME_SERVICE) as IGameService).getGroupSize() > 25 || SharedConst.CURRENT_STATE=="torch")
						{
							trace("Crocodyle SCARED");
							needToStop = false;
							SharedConst.SHAMAN_LEVEL++;
							sendNotification(SharedConst.CHANGE_PEOPLE, { num:-1 } );
							if (currentPoint.x < SharedConst.STAGE_WIDTH / 2)
							{
								
								currentAngle = 270;
								sendNotification(SharedConst.ACTION_CHANGE_STATE+humanName,{newState:"CrocodyleGoleft"})
							}	else
							{
								sendNotification(SharedConst.ACTION_CHANGE_STATE+humanName,{newState:"CrocodyleGoright"})
								currentAngle = 90;
							}
						}
						break;
					default:
						//trace("SOMEONE SCARED");
						break;
				}
			} else if (Math.abs(currentPoint.y - SharedConst.TRIBE_VERTICAL_POSITION)<SharedConst.MAP_SPEED)
			{
				switch(type)
				{
					case "antelope":
						
						var points:Array = (GameFacade.getInstance().retrieveProxy(SharedConst.GAME_SERVICE) as IGameService).getGroupPoints();
						var scared:Boolean = true;
						for each(var point:int in points)
						{
							if (Math.abs(point - currentPoint.x) <= 40 && SharedConst.CURRENT_STATE=="weapon")
							{
								SharedConst.SUPPLIES += 10;
								sendNotification(SharedConst.ACTION_CHANGE_STATE + humanName, { "newState": "eated"  } );
								scared = false;
								break;
							} else 
							{
								
							}
						}
						if (scared)
						{
							trace("ANTELOPE SCARED");
								needToStop = false;
								if (currentPoint.x < SharedConst.STAGE_WIDTH / 2)
								{
									
									currentAngle = 270;
								}	else
								{
									sendNotification(SharedConst.ACTION_CHANGE_STATE+humanName,{newState:"AntelopeGoright"})
									currentAngle = 90;
								}
						}
						break;
					case "crocodyle":
						if (SharedConst.CURRENT_STATE != "torch")
						{
							
							points = (GameFacade.getInstance().retrieveProxy(SharedConst.GAME_SERVICE) as IGameService).getGroupPoints();
							for each(point in points)
							{
								if (Math.abs(point - currentPoint.x) <= 50 && (GameFacade.getInstance().retrieveProxy(SharedConst.GAME_SERVICE) as IGameService).getGroupSize() <= 25)
								{
									(GameFacade.getInstance().retrieveProxy(SharedConst.GAME_SERVICE) as IGameService).killGroup(point);
								}
							}
						} else 
						{
							trace("Crocodyle SCARED");
							needToStop = false;
							SharedConst.SHAMAN_LEVEL++;
							sendNotification(SharedConst.CHANGE_PEOPLE, { num:-1 } );
							if (currentPoint.x < SharedConst.STAGE_WIDTH / 2)
							{
								
								currentAngle = 270;
								sendNotification(SharedConst.ACTION_CHANGE_STATE+humanName,{newState:"CrocodyleGoleft"})
							}	else
							{
								sendNotification(SharedConst.ACTION_CHANGE_STATE+humanName,{newState:"CrocodyleGoright"})
								currentAngle = 90;
							}
						}
						break;
					case "berry":
						
						points = (GameFacade.getInstance().retrieveProxy(SharedConst.GAME_SERVICE) as IGameService).getGroupPoints();
						for each(point in points)
						{
							if (Math.abs(point - currentPoint.x) <= 40 && SharedConst.CURRENT_STATE=="")
							{
								SharedConst.SUPPLIES += 8;
								sendNotification(SharedConst.ACTION_CHANGE_STATE + humanName, { "newState": "eated"  } );
								break;
							} 
						}
						
						break;
					case "strangers":
						
						points = (GameFacade.getInstance().retrieveProxy(SharedConst.GAME_SERVICE) as IGameService).getGroupPoints();
						for each(point in points)
						{
							if (Math.abs(point - currentPoint.x) <= 50 )
							{
								if ( (GameFacade.getInstance().retrieveProxy(SharedConst.GAME_SERVICE) as IGameService).getGroupSize() >= 5)
								{
									if (SharedConst.SUPPLIES > 0 && SharedConst.CURRENT_STATE != "weapon")
									{
										trace("GO WITH TRIBE")
										sendNotification(SharedConst.ACTION_CHANGE_STATE + humanName, { "newState": "goWithTribe"  } );
										(GameFacade.getInstance().retrieveProxy(SharedConst.GAME_SERVICE) as IGameService).addToTribe(5);
										break;
									} else 
									{
										trace("EAT STRANGERS")
										SharedConst.SUPPLIES += 5;
										sendNotification(SharedConst.ACTION_CHANGE_STATE + humanName, { "newState": "eated"  } );
									}
								} else {
									(GameFacade.getInstance().retrieveProxy(SharedConst.GAME_SERVICE) as IGameService).killGroup(point);
									trace("KILL_GROUP")
								}
								
								
								break;
							}
						}
						break;
					default:
						trace("SOMEONE SCARED");
						break;
				}
			}
			if (!needToStop)
			{
				currentPoint.x += Math.sin(currentAngle *0.0175) * currentSpeed;
				currentPoint.y -= Math.cos(currentAngle * 0.0175) * currentSpeed;
			}
		}
		
		
		
		
		
		
		
	}

}