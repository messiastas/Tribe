package game.controller.command 
{
	import game.model.service.MenuService;
	import game.view.mediators.MenuMediator;
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
	public class StartupCommand extends SimpleCommand implements ICommand
	{
		
		override public function execute(notification:INotification):void
		{
			GameFacade.getInstance().registerMediator(new MenuMediator(SharedConst.MENU_SERVICE));
			GameFacade.getInstance().registerProxy(new MenuService(SharedConst.MENU_SERVICE, null));
			//new GameService(SharedConst.GAME_SERVICE,null)
			//new MenuService(SharedConst.MENU_SERVICE,null)
		}
		
	}

}