package game.common.interfaces 
{
	/**
	 * ...
	 * @author messia_s
	 */
	import flash.geom.Point;
	public interface IAnimal 
	{
		
		function getCurrentPoint():Point;
		function setCurrentPoint(newPoint:Point):void;
		function makeStep():void;
		function makeDead():String; 
		
	}

}