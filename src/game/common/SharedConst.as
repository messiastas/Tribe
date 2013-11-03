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
		public static const CMD_BORN_CLICK:String = "cmd_born_click";
		public static const CMD_SACRIFICE_CLICK:String = "cmd_sacrifice_click";
		public static const CMD_FINISH_LEVEL:String = "cmd_finish_level";
		
		public static const SHOW_HELP_LEFT:String = "show_help_left";
		public static const SHOW_HELP_RIGHT:String = "show_help_right";
		public static const CHANGE_PEOPLE:String = "change_people";
		public static const CHANGE_SUPPLIES:String = "change_supplies";
		
		
		public static const ACTION_MOVE_HUMAN:String = "action_move_human";
		public static const ACTION_CHANGE_ANGLE:String = "action_change_angle";
		public static const ACTION_CHANGE_STATE:String = "action_change_state";
		public static const ACTION_TORCHES:String = "action_torches";
		public static const ACTION_WEAPONS:String = "action_weapons";
		public static const ACTION_HANDS:String = "action_hands";
		
		public static const REMOVE_LISTENERS:String = "remove_listeners";
		public static const REMOVE_ANIMAL:String = "remove_animal";
		
		
		
		public static const NEW_ITER:String = "new_iter";
		
		public static const LEVELTYPE_SCROLLER:String = "LEVELTYPE_SCROLLER";
		
		public static const CURRENT_LEVEL:int = 1;
		public static var MAP_SPEED:int = 3;
		public static var SPEND_DISTANCE:int = 0;
		public static var SHAMAN_LEVEL:int = 1;
		public static var SUPPLIES:Number = 50;
		public static const SUPPLIES_EAT:Number = 0.02;
		public static const STAGE_HEIGHT:int = 600;
		public static const STAGE_WIDTH:int = 800;
		public static const TRIBE_VERTICAL_POSITION:int = 75;
		public static var TRIBE_SIZE:int = 50;
		public static const ACTION_TIME:int = 30;
		public static const HELP_TIME:int = 60;
		public static const MAP_STEP:int = 20;
		
		public static var MAP_DISTANCE:int = MAP_SPEED * (int(1000 / ACTION_TIME)) * 60;
		
		public static const LEVEL_FOR_WEAPON:int = 2;
		public static const LEVEL_FOR_TORCH:int = 4;
		public static const LEVEL_FOR_BORN:int = 6;
		public static const LEVEL_FOR_SACRIFICE:int = 8;
		public static var CURRENT_DISPERSION:Number = 50;
		public static var LAST_HUMAN_NAME:int = 0;
		
		public static var CURRENT_STATE:String = "";
		
		public static const LEVELS_ARRAY:Array = [
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
													],
													
													]
		
		public static const isSound:Boolean = true;
		
		
	}
	
}