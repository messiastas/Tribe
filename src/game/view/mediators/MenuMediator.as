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
	import game.common.SoundPlayer;
	
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
				SharedConst.CMD_RESTART_GAME,
			];
			super( NAME, new MenuView(NAME) );
			panel.addEventListener("startGame", onStartGame);
			panel.addEventListener("wait", onWait);
		}
		
		private function onStartGame(e:Event):void 
		{
			sendNotification(SharedConst.CMD_START_LEVEL);
		}
		
		private function onWait(e:Event):void 
		{
			sendNotification(SharedConst.CHANGE_SUPPLIES);
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
					SoundPlayer.getInstance().playMusic(musicMenu);
					panel.viewMenu();
					break;
				case SharedConst.CMD_RESTART_GAME:
					
					SharedConst.TRIBE_SIZE = 50;
					SharedConst.CURRENT_LEVEL = 1;
					SharedConst.CURRENT_DAYTIME = "day";
					SharedConst.LAND_TYPE = 1;
					SharedConst.MAP_SPEED = 3;
					SharedConst.SPEND_DISTANCE = 0;
					SharedConst.SHAMAN_LEVEL = 1;
					SharedConst.SUPPLIES = 50;
					SharedConst.CURRENT_STATE = ""
					SharedConst.LAST_LEVEL = "";
					SharedConst.CURRENT_DISPERSION = 50;
					SharedConst.LAST_HUMAN_NAME = 0;
					SharedConst.SUCCEED_HUNTING = 0;
					SharedConst.SUCCEED_PLANTING = 0;		
					SharedConst.SUCCEED_CANNIBALISM = 0;
					SharedConst.SUCCEED_DIPLOMACY = 0;
					SharedConst.LEVELS_IN_GAME = [1, 1, 1, 2, 2, 2, 3, 3, 3, 4, 4];
					
					SharedConst.LEVELS_ARRAY = [
													[	
														{ distance:10, objects:[ "bridge2"], safeZones:[[210, 320], [490, 590]], long:200 },
														{ distance:300, objects:["show_help_right"] }, 
														{ distance:400, objects:["animal"],type:"berry",position:400},
														{ distance:500, objects:[ "bridge1"], safeZones:[[300, 500]], long:200 },
														{ distance:700, objects:["show_help_left"] },
														/*{ distance:810, objects:["animal"], type:"antelope", position:750 },
														{ distance:1200, objects:["animal"], type:"crocodyle", position:350 },
														{ distance:1250, objects:["animal"], type:"crocodyle", position:600 },
														{ distance:1600, objects:["animal"],type:"antelope",position:320},*/
													],[],[],[],[],[]
													
													];
					
					
					sendNotification(SharedConst.CHANGE_PEOPLE );
					sendNotification(SharedConst.CHANGE_SUPPLIES);
					
					panel.randomViewToAll();
					panel.onlyViewMenu();
			}
		}
		
		protected function get panel() : MenuView {
			return viewComponent as MenuView;
		}
		
	}

}