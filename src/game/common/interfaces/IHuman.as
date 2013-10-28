package game.common.interfaces 
{
	/**
	 * ...
	 * @author messia_s
	 */
	import flash.geom.Point;
	public interface IHuman 
	{
		
		function getCurrentPoint():Point;
		function setCurrentPoint(newPoint:Point):void;
		function makeStep():void;
		function makeShaman():void;
		function makeDead():String; 
		
		/*function getAgressive():Number;
		function setAgressive(level:Number):void;
		function getRelationWith(some:IHuman):Number;
		function setRelationWith(some:IHuman, level:Number):void;
		function getTargetAction():String;
		function setTargetAction(action:String):void;
		
		function getVisibleObjects():Object;
		function isVisibleObject(some:IWorldObject):Boolean;*/
		
	}

}