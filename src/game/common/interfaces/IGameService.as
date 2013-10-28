package game.common.interfaces 
{
	
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
	}
	
}