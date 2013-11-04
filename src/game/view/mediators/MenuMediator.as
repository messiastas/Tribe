package game.view.mediators 
{
	import flash.events.Event;
	import game.view.components.MenuView;
	import org.puremvc.as3.interfaces.IMediator;
	import org.puremvc.as3.patterns.mediator.Mediator;
	import game.view.components.InterfaceView;
	import flash.geom.Point;
	import game.common.GameFacade;
	import game.common.SharedConst;
	import org.puremvc.as3.interfaces.INotification;
	
	/**
	 * ...
	 * @author messia_s
	 */
	public class MenuMediator extends Mediator implements IMediator 
	{
		public static const NAME:String = 'MenuMediator'; 
		
		private var interests:Array = new Array
		
		public function MenuMediator(Name:String):void
		{
			mediatorName = "MenuMediator";
			interests = [
				SharedConst.VIEW_MENU,
			];
			super( NAME, new MenuView(NAME) );
			panel.addEventListener("startGame", onStartGame);
		}
		
		private function onStartGame(e:Event):void 
		{
			sendNotification(SharedConst.CMD_START_LEVEL);
		}
		
		
		
		override public function listNotificationInterests() : Array 
		{
			return interests; 
		}
		
		override public function handleNotification( note : INotification ) : void  
		{
			//trace(note.getName());
			var obj:Object = note.getBody();
			switch ( note.getName() ) 
			{
				
				case SharedConst.REMOVE_LISTENERS:
					
					panel.removeListeners();
					GameFacade.getInstance().removeMediator(mediatorName);
					break;
				case SharedConst.VIEW_MENU:
					panel.viewMenu();
					break;
				
			}
		}
		
		protected function get panel() : MenuView {
			return viewComponent as MenuView;
		}
		
	}

}