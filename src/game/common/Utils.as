package game.common 
{
	import flash.geom.Point;
	/**
	 * ...
	 * @author messia_s
	 */
	public class Utils 
	{
		
		public static function recursiveTrace(obj:Object,objName:String):void 
		{
			for (var d:String in obj)
			{
				trace( objName,"[", d, "] = ", obj[d]);
				if (obj[d] is Object)
					recursiveTrace(obj[d], String(objName + "[" + d + "]"));
				
			}
		}
		
		public static function recursiveCopy(obj:Object):Object 
		{
			var newObj:Object = new Object;
			for (var d:String in obj)
			{
			//	if (obj[d] is Object)
				//	newObj[d] = recursiveCopy(obj[d])
			//	else 
					newObj[d] = obj[d];
				
			}
			return newObj;
		}
		
		public static function calculateDistance(A:*,B:*):Number
		{
			return Math.sqrt((A.x - B.x) * (A.x - B.x) + (A.y - B.y) * (A.y - B.y));
		}
		
		public static function xInInterval(x:int,xStart:int,xEnd:int):Boolean
		{
			return (x >= xStart && x <= xEnd);
		}
		
		public static function changeDaytime():void 
		{
			if (SharedConst.CURRENT_DAYTIME == "day")
			{
				SharedConst.CURRENT_DAYTIME = "night"
			} else 
			{
				SharedConst.CURRENT_DAYTIME = "day"
			}
		}
		
		
		
	}

}