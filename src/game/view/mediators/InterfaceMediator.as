package game.view.mediators 
{
	import flash.events.Event;
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
	public class InterfaceMediator extends Mediator implements IMediator 
	{
		public static const NAME:String = 'InterfaceMediator'; 
		
		private var interests:Array = new Array
		
		public function InterfaceMediator(Name:String):void
		{
			
			interests = [
				SharedConst.SHOW_HELP_LEFT,
				SharedConst.SHOW_HELP_RIGHT,
				SharedConst.CHANGE_PEOPLE,
				SharedConst.CHANGE_SUPPLIES,
			];
			super( NAME, new InterfaceView(NAME) );
			panel.addEventListener("leftClick", onClick);
			panel.addEventListener("rightClick", onClick);
		}
		
		private function onClick(e:Event):void {
			trace(e.type);
			sendNotification(SharedConst.CMD_REGROUP_CLICK,{action:e.type})
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
				case SharedConst.SHOW_HELP_LEFT:
					panel.showLeft()
					break;
				case SharedConst.SHOW_HELP_RIGHT:
					panel.showRight()
					
					break;
				case SharedConst.CHANGE_PEOPLE:
					panel.changePeople(note.getBody().num)
					
					break;
				case SharedConst.CHANGE_SUPPLIES:
					panel.changeSupplies(note.getBody().num)
					
					break;
				
			}
		}
		
		protected function get panel() : InterfaceView {
			return viewComponent as InterfaceView;
		}
		
	}

}