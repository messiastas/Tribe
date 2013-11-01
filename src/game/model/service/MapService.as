package game.model.service 
{
	import flash.display.BitmapData;
	import flash.display.MovieClip;
	import org.puremvc.as3.interfaces.IProxy;
	import org.puremvc.as3.patterns.proxy.Proxy;
	import game.common.SharedConst;
	import game.common.interfaces.*;
	import game.common.GameFacade;
	
	/**
	 * ...
	 * @author messia_s
	 */
	public class MapService extends Proxy implements IProxy,ILevelDesign
	{
		
		private var currentMapGraphic:MovieClip;
		private var currentMapGraphic2:MovieClip;
		private var objectsGraphic:MovieClip = new MovieClip;
		private var objectsArray:Array = new Array;
		private var mapStep:int;
		private var realMap:Array = new Array();
		
		public function MapService(pname:String,data:Object):void 
		{
			proxyName = pname;// SharedConst.MAP_SERVICE;
			switch(data["level"])
			{
				case 1:
					currentMapGraphic = new Land1();
					currentMapGraphic2 = new Land1();
					
					break;
					
			}
			(GameFacade.getInstance().retrieveProxy(SharedConst.GAME_SERVICE) as IGameService).getMapClip().addChild(currentMapGraphic);
			(GameFacade.getInstance().retrieveProxy(SharedConst.GAME_SERVICE) as IGameService).getMapClip().addChild(currentMapGraphic2);
			(GameFacade.getInstance().retrieveProxy(SharedConst.GAME_SERVICE) as IGameService).getMapClip().addChild(objectsGraphic);
			currentMapGraphic2.y = currentMapGraphic2.height;
			mapStep = SharedConst.MAP_STEP;
			//createMap();
		}
		
		public function moveMap(speed:int):void 
		{
			currentMapGraphic.y += speed;
			currentMapGraphic2.y += speed;
			objectsGraphic.y += speed;
			if (currentMapGraphic.y <= -currentMapGraphic.height)
				currentMapGraphic.y = currentMapGraphic.height;
			else if (currentMapGraphic2.y <=-currentMapGraphic2.height)
				currentMapGraphic2.y = currentMapGraphic2.height;
				
			for each (var object:Object in objectsArray)
			{
				if (object.obj.y-object.coordY>SharedConst.STAGE_HEIGHT+object.obj.height)
				{
					objectsGraphic.removeChild(object.obj);
					object.obj = null;
					objectsArray.splice(objectsArray.indexOf(object), 1);
				}
			}
			if (objectsArray.length == 0)
				objectsGraphic.y = 0;
		}
		
		public function addToObjects(type:String,oX:int=0,oY:int=0):void 
		{
			var needToAdd:Boolean = true;
			switch (type)
			{
				case "river":
					var newObject:MovieClip = new River;
					
					break;
				case "bridge2":
					newObject = new Bridge2;
					break;
				case "bridge1":
					newObject = new Bridge1;
					break;
				default:
					needToAdd = false;
					break;
				case "normalCorpse":
					newObject = new Human;
					newObject.gotoAndStop(2);
					
					break;
				case "bloodyCorpse":
					newObject = new Human;
					newObject.gotoAndStop(3);
					
					break;
			}
			if (needToAdd)
			{
				objectsGraphic.addChild(newObject);
				if ((oX + oY) == 0)
				{
					newObject.y = -objectsGraphic.y + SharedConst.STAGE_HEIGHT;
				} else
				{
					newObject.y = -objectsGraphic.y + oY;
					newObject.x = oX;
				}
				
				objectsArray.push({obj:newObject,coordY:newObject.y})
			}
			
		}
		
		
		public function getMapArray():Array
		{
			return realMap;
		}
		
	}

}