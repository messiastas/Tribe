package game.common.interfaces 
{
	
	/**
	 * ...
	 * @author messia_s
	 */
	public interface ILevelDesign 
	{
		function getMapArray():Array;
		function moveMap(speed:int):void;
		function addToObjects(type:String):void 
	}
	
}