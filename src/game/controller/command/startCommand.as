package game.controller.command 
{
	import game.common.interfaces.IGameService;
	import org.puremvc.as3.interfaces.ICommand;
	import org.puremvc.as3.patterns.command.SimpleCommand;
	import game.common.GameFacade;
	import game.model.service.GameService;
	import org.puremvc.as3.interfaces.INotification;
	import game.common.SharedConst;
	
	/**
	 * ...
	 * @author messia_s
	 */
	public class startCommand extends SimpleCommand implements ICommand
	{
		
		override public function execute(notification:INotification):void
		{
			new GameService(SharedConst.GAME_SERVICE,null)
			
		}
		
	}

}