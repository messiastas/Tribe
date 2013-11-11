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
			mediatorName = Name;
			interests = [
				SharedConst.SHOW_HELP_LEFT,
				SharedConst.SHOW_HELP_RIGHT,
				SharedConst.CHANGE_PEOPLE,
				SharedConst.CHANGE_SUPPLIES,
				SharedConst.REMOVE_LISTENERS,
				SharedConst.CMD_START_LEVEL,
				SharedConst.GAME_OVER,
			];
			super( NAME, new InterfaceView(NAME) );
			panel.addEventListener("leftClick", onClick);
			panel.addEventListener("rightClick", onClick);
			
			panel.addEventListener("onWeaponClick", onWeaponClick);
			panel.addEventListener("onTorchClick", onTorchClick);
			panel.addEventListener("onHandsClick", onHandsClick);
			panel.addEventListener("onBornClick", onBornClick);
			panel.addEventListener("onSacrificeClick", onSacrificeClick);
			
			panel.addEventListener("finishLevel", onFinishLevel);
			panel.addEventListener("restartGame", onRestartGame);
			
			panel.clickAreaInvisible();
		}
		
		private function onWeaponClick(e:Event):void 
		{
			sendNotification(SharedConst.ACTION_WEAPONS);
			SharedConst.CURRENT_STATE = "weapon"
		}
		
		private function onTorchClick(e:Event):void 
		{
			sendNotification(SharedConst.ACTION_TORCHES);
			SharedConst.CURRENT_STATE = "torch"
		}
		
		private function onHandsClick(e:Event):void 
		{
			sendNotification(SharedConst.ACTION_HANDS);
			SharedConst.CURRENT_STATE = ""
		}
		
		private function onBornClick(e:Event):void 
		{
			sendNotification(SharedConst.CMD_BORN_CLICK);
		}
		
		private function onSacrificeClick(e:Event):void 
		{
			sendNotification(SharedConst.CMD_SACRIFICE_CLICK);
		}
		
		private function onClick(e:Event):void {
			//trace(e.type);
			sendNotification(SharedConst.CMD_REGROUP_CLICK,{action:e.type})
		}
		
		private function onFinishLevel(e:Event):void 
		{
			sendNotification(SharedConst.CMD_FINISH_LEVEL);
		}
		
		private function onRestartGame(e:Event):void 
		{
			GameFacade.getInstance().removeProxy(SharedConst.MAP_SERVICE);
			GameFacade.getInstance().removeProxy(SharedConst.GAME_SERVICE);
			sendNotification(SharedConst.CMD_RESTART_GAME);
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
					panel.changePeople()
					
					break;
				case SharedConst.CHANGE_SUPPLIES:
					panel.changeSupplies()
					
					break;
				case SharedConst.CMD_START_LEVEL:
					panel.clickAreaVisible();
					break;
				case SharedConst.REMOVE_LISTENERS:
					panel.clickAreaInvisible();
					/*panel.removeEventListener("leftClick", onClick);
					panel.removeEventListener("rightClick", onClick);
					
					panel.removeEventListener("onWeaponClick", onWeaponClick);
					panel.removeEventListener("onTorchClick", onTorchClick);
					panel.removeEventListener("onHandsClick", onHandsClick);
					panel.removeEventListener("onBornClick", onBornClick);
					panel.removeEventListener("onSacrificeClick", onSacrificeClick);
					
					panel.removeEventListener("finishLevel", onFinishLevel);
					panel.removeListeners();
					GameFacade.getInstance().removeMediator(mediatorName);*/
					break;
				case SharedConst.GAME_OVER:
					panel.showGameOver();
					break;
				
			}
		}
		
		protected function get panel() : InterfaceView {
			return viewComponent as InterfaceView;
		}
		
	}

}