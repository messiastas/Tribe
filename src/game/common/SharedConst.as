package game.common 
{
	public class SharedConst
	{
		
		public static const GAME_SERVICE:String = "GameService";
		public static const MAP_SERVICE:String = "MapService";
		
		public static const CMD_CREATE_HUMAN:String = "cmd_create_human";
		public static const CMD_CREATE_ANIMAL:String = "cmd_create_animal";
		public static const CMD_CREATE_MAP:String = "cmd_create_map";
		public static const CMD_CREATE_INTERFACE:String = "cmd_create_interface";
		public static const CMD_REGROUP_CLICK:String = "cmd_REGROUP_CLICK";
		
		public static const SHOW_HELP_LEFT:String = "show_help_left";
		public static const SHOW_HELP_RIGHT:String = "show_help_right";
		public static const CHANGE_PEOPLE:String = "change_people";
		public static const CHANGE_SUPPLIES:String = "change_supplies";
		
		
		public static const ACTION_MOVE_HUMAN:String = "action_move_human";
		public static const ACTION_CHANGE_ANGLE:String = "action_change_angle";
		public static const ACTION_CHANGE_STATE:String = "action_change_state";
		
		
		
		public static const NEW_ITER:String = "new_iter";
		
		public static const LEVELTYPE_SCROLLER:String = "LEVELTYPE_SCROLLER";
		
		public static const CURRENT_LEVEL:int = 1;
		public static const MAP_SPEED:int = 3;
		public static var SPEND_DISTANCE:int = 0;
		public static var SHAMAN_LEVEL:int = 1;
		public static var SUPPLIES:Number = 20;
		public static const SUPPLIES_EAT:Number = 0.02;
		public static const STAGE_HEIGHT:int = 600;
		public static const TRIBE_VERTICAL_POSITION:int = 75;
		public static const TRIBE_SIZE:int = 50;
		public static const ACTION_TIME:int = 30;
		public static const HELP_TIME:int = 60;
		public static const MAP_STEP:int = 20;
		
		public static const LEVELS_ARRAY:Array = [
													[	
														{ distance:10, objects:["river", "bridge2"], safeZones:[[210, 320], [490, 590]], long:200 },
														{ distance:300, objects:["show_help_right"] }, 
														{ distance:350, objects:["animal"],type:"antelope",position:200},
														{ distance:500, objects:["river", "bridge1"], safeZones:[[300, 500]], long:200 },
														{ distance:800, objects:["show_help_left"]}
													],
													
													]
		
		public static const isSound:Boolean = true;
		
		
	}
	
}