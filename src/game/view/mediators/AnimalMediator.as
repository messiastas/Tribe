package game.view.mediators 
{
	import game.common.interfaces.IHuman;
	import game.view.components.AnimalView;
	import org.puremvc.as3.interfaces.IMediator;
	import org.puremvc.as3.patterns.mediator.Mediator;
	import game.view.components.HumanView;
	import flash.geom.Point;
	import game.common.GameFacade;
	import game.common.SharedConst;
	import org.puremvc.as3.interfaces.INotification;
	
	/**
	 * ...
	 * @author messia_s
	 */
	public class AnimalMediator extends Mediator implements IMediator 
	{
		public static const NAME:String = 'PlayerMediator'; 
		private var humanName:String = "John Smith";
		
		private var interests:Array = new Array
		
		public function AnimalMediator(Name:String):void
		{
			humanName = Name;	
			interests = [
				SharedConst.ACTION_MOVE_HUMAN + humanName,
				SharedConst.ACTION_CHANGE_ANGLE + humanName,
				SharedConst.ACTION_CHANGE_STATE + humanName,
			];
			super( NAME + humanName, new AnimalView(humanName) );
			trace("MEDIATOR", humanName);
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
				case SharedConst.ACTION_MOVE_HUMAN + humanName:
					human.setPosition(note.getBody()["newX"], note.getBody()["newY"]);
					break;
				case SharedConst.ACTION_CHANGE_STATE + humanName:
					human.setState(note.getBody())
					
					break;
				
			}
		}
		
		protected function get human() : AnimalView {
			return viewComponent as AnimalView;
		}
		
	}

}