package game.common.interfaces 
{
	import flash.display.MovieClip;
	
	/**
	 * ...
	 * @author messia_s
	 */
	public interface IGameService 
	{
		function getHuman(hName:String): IHuman;
		function regroup(action:String):void;
		function createNewShaman():void;
		function getGroupSize():int;
		function getGroupPoints():Array;
		function getMapClip():MovieClip;
		function getCreaturesClip():MovieClip;
		function getInterfaceClip():MovieClip;
		function killGroup(what:int):void;
		function addToTribe(what:int):void;
		function bornPeople():void;
		function sacrificePeople():void;
		function finishLevel():void;
		//function restartLevel():void;
		function removeAnimal(aName:String):void;
	}
	
}