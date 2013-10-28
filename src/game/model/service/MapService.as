package game.model.service 
{
	import flash.display.BitmapData;
	import flash.display.MovieClip;
	import org.puremvc.as3.interfaces.IProxy;
	import org.puremvc.as3.patterns.proxy.Proxy;
	import game.common.SharedConst;
	import game.common.interfaces.ILevelDesign;
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
			GameFacade.getInstance().mainStage.addChild(currentMapGraphic);
			GameFacade.getInstance().mainStage.addChild(currentMapGraphic2);
			GameFacade.getInstance().mainStage.addChild(objectsGraphic);
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
					objectsArray.splice(objectsArray.indexOf(object), 1);
				}
			}
			if (objectsArray.length == 0)
				objectsGraphic.y = 0;
		}
		
		public function addToObjects(type:String):void 
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
			}
			if (needToAdd)
			{
				objectsGraphic.addChild(newObject);
				newObject.y = -objectsGraphic.y + SharedConst.STAGE_HEIGHT;
				objectsArray.push({obj:newObject,coordY:newObject.y})
			}
			
		}
		
		private function createMap():void 
		{
			var i:int = 0;//vertical
			var j:int = 0;//horizontal
			var bMap:BitmapData = new BitmapData(currentMapGraphic.width, currentMapGraphic.height, true, 0);
			bMap.fillRect(bMap.rect, 0);
			bMap.draw(currentMapGraphic);
			
			
			//trace(currentMapGraphic.width, currentMapGraphic.height);
			while (i * mapStep < currentMapGraphic.height)
			{
				var horizontalArray:Array = [];
				while (j * mapStep < currentMapGraphic.width)
				{
					
					if (bMap.getPixel(j * mapStep + mapStep *0.5, i * mapStep + mapStep *0.5)>0)
					{
						//trace(i, j);
						horizontalArray[j] = 1
					} else 
					{
						horizontalArray[j] = 0
					}
					j++;
				}
				realMap[i] = horizontalArray;
				i++;
				j = 0;
			}
			//trace(realMap);
		}
		
		public function getMapArray():Array
		{
			return realMap;
		}
		
	}

}