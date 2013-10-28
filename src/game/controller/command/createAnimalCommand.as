package game.controller.command 
{
	import game.model.service.AnimalService;
	import game.view.mediators.AnimalMediator;
	import org.puremvc.as3.interfaces.ICommand;
	import org.puremvc.as3.patterns.command.SimpleCommand;
	import org.puremvc.as3.interfaces.INotification;
	import game.common.GameFacade;
	
	
	/**
	 * ...
	 * @author messia_s
	 */
	public class createAnimalCommand extends SimpleCommand implements ICommand 
	{
		
		
		override public function execute(notification:INotification):void
		{
			
			GameFacade.getInstance().registerMediator(new AnimalMediator(notification.getBody().name));
			GameFacade.getInstance().registerProxy(new AnimalService(notification.getBody()));
			
		}
		
	}

}