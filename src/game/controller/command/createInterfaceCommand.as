package game.controller.command 
{
	import game.view.mediators.InterfaceMediator;
	import org.puremvc.as3.interfaces.ICommand;
	import org.puremvc.as3.patterns.command.SimpleCommand;
	import org.puremvc.as3.interfaces.INotification;
	import game.common.GameFacade;
	
	
	/**
	 * ...
	 * @author messia_s
	 */
	public class createInterfaceCommand extends SimpleCommand implements ICommand 
	{
		
		
		override public function execute(notification:INotification):void
		{
			
			GameFacade.getInstance().registerMediator(new InterfaceMediator("interface"));
		}
		
	}

}