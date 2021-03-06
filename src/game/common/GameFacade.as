package game.common 
{
	
	import flash.display.MovieClip;
	import org.puremvc.as3.patterns.facade.Facade;
	import org.puremvc.as3.interfaces.IFacade;
	import flash.display.Stage;
	//import starling.display.Stage;
	//import game.model.entity.GameParameters;
	import game.controller.command.*;

	
	/**
	 * ...
	 * @author Stas.Shostak
	 */
	
	public class GameFacade extends Facade implements IFacade 
	{
		public static const NAME:String = 'Game';
		
		public static const CMD_STARTUP:String = NAME + 'StartUp';
		
		
		private static var _instance:GameFacade = new GameFacade();
		
		//private var _gameParameters:GameParameters = new GameParameters();
		private static var _mainStage:Stage;
		
		private static var _iteration:Number = 0;
		
		private static var interfaceClip:MovieClip = new MovieClip;
		private static var otherClip:MovieClip = new MovieClip;
		
		public function GameFacade() 
		{
			if (_instance != null) throw new Error("GameFacade is obviously also... Singleton.");
			init();
		}
		
		public function init():void 
        {
			registerCommand(CMD_STARTUP, StartupCommand);
			registerCommand(SharedConst.CMD_CREATE_HUMAN, createHumanCommand);
			registerCommand(SharedConst.CMD_CREATE_MAP, createMapCommand);
			registerCommand(SharedConst.CMD_CREATE_INTERFACE, createInterfaceCommand);
			registerCommand(SharedConst.CMD_REGROUP_CLICK, regroupCommand);
			registerCommand(SharedConst.CMD_CREATE_ANIMAL, createAnimalCommand);
			registerCommand(SharedConst.CMD_BORN_CLICK, bornCommand);
			registerCommand(SharedConst.CMD_SACRIFICE_CLICK, sacrificeCommand);
			registerCommand(SharedConst.CMD_FINISH_LEVEL, finishCommand);
			registerCommand(SharedConst.CMD_START_LEVEL, startCommand);
		}
		
		public function startup(newStage:Stage):void 
		{
			mainStage = newStage;
			mainStage.addChild(otherClip);
			mainStage.addChild(interfaceClip);
			sendNotification(CMD_STARTUP, null);
			sendNotification(SharedConst.CMD_CREATE_INTERFACE, null);
		}
		
		
		
		public static function getInstance():GameFacade 
        {
            if (_instance == null ) _instance = new GameFacade();
            return _instance as GameFacade;
        }
		
		/*public function get gameParameters():GameParameters 
		{
			return _gameParameters;
		}
		
		public function set gameParameters(value:GameParameters):void 
		{
			_gameParameters = value;
		}*/
		
		public function get mainStage():Stage 
		{
			return _mainStage;
		}
		
		public function set mainStage(value:Stage):void 
		{
			_mainStage = value;
		}
		
		public function get iteration():Number 
		{
			return _iteration;
		}
		
		public function set iteration(value:Number):void 
		{
			_iteration = value;
		}
		
		public function get InterfaceClip():MovieClip
		{
			return interfaceClip;
		}
		
		public function get OtherClip():MovieClip
		{
			return otherClip;
		}
	}
}