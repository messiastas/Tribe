package game.view.mediators 
{
	import game.common.interfaces.IHuman;
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
	public class HumanMediator extends Mediator implements IMediator 
	{
		public static const NAME:String = 'PlayerMediator'; 
		private var humanName:String = "John Smith";
		
		private var interests:Array = new Array
		//private var handleFunction:Function;
		
		public function HumanMediator(Name:String):void
		{
			humanName = Name;
			mediatorName = humanName;
			interests = [
				SharedConst.ACTION_MOVE_HUMAN + humanName,
				SharedConst.ACTION_CHANGE_ANGLE + humanName,
				SharedConst.ACTION_CHANGE_STATE + humanName,
				SharedConst.ACTION_TORCHES,
				SharedConst.ACTION_WEAPONS,
				SharedConst.ACTION_HANDS,
				SharedConst.REMOVE_LISTENERS,
			];
			super( NAME + humanName, new HumanView(humanName) );
			//handleFunction = onHandle;
		}
		
		override public function listNotificationInterests() : Array 
		{
			return interests; 
		}
		
		/*override public function handleNotification( note : INotification ) : void  
		{
			//trace(note.getName());
			if(handleFunction !=null)
				handleFunction(note);
		}*/
		
		override public function handleNotification(note:INotification):void 
		{
			var obj:Object = note.getBody();
			switch ( note.getName() ) 
			{
				case SharedConst.ACTION_MOVE_HUMAN + humanName:
					human.setPosition(note.getBody()["newX"], note.getBody()["newY"]);
					break;
				case SharedConst.ACTION_CHANGE_STATE + humanName:
					human.setState(note.getBody())
					if (note.getBody().newState == "dead")
					{
						//interests = [];
						//handleFunction = null;
						GameFacade.getInstance().removeMediator(mediatorName);
					}
					break;
				case SharedConst.ACTION_TORCHES:
					human.setState({newState:SharedConst.ACTION_TORCHES})
					
					break;
				case SharedConst.ACTION_WEAPONS:
					human.setState({newState:SharedConst.ACTION_WEAPONS})
					
					break;
				case SharedConst.ACTION_HANDS:
					human.setState({newState:SharedConst.ACTION_HANDS})
					
					break;
				case SharedConst.REMOVE_LISTENERS:
					human.removeAll();
					GameFacade.getInstance().removeMediator(mediatorName);
					
					break;
				
			}
		}
		
		protected function get human() : HumanView {
			return viewComponent as HumanView;
		}
		
	}

}