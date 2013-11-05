package game.view.components 
{
	import flash.events.EventDispatcher;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.geom.Rectangle;
	import flash.display.Sprite;
	import flash.display.MovieClip;
	import flash.display.Shape;
	import flash.events.EventDispatcher;
	import flash.utils.Timer;
	import game.common.GameFacade
	import game.common.interfaces.*;
	import game.common.SharedConst;
	
	/**
	 * ...
	 * @author messia_s
	 */
	public class AnimalView extends EventDispatcher 
	{
		private var human:Sprite = new Sprite;
		private var body:MovieClip;
		private var humanName:String = "";
		private var size:int = 5;
		
		
		public function AnimalView(hName:String,_size:int = 5) 
		{
			humanName = hName;
			size = _size
			init();
		}
		
		public function init():void {
			
			(GameFacade.getInstance().retrieveProxy(SharedConst.GAME_SERVICE) as IGameService).getCreaturesClip().addChild(human);
			//var body:Rectangle = new Rectangle(0, 0, 20, 20);
			switch (humanName)
			{
				case "antelope":
					if (SharedConst.LAND_TYPE == 4)
					{
						body = new Camel();
					} else 
					{
						body = new Antelope();
					}
					break;
				case "crocodyle":
					if (SharedConst.LAND_TYPE == 2)
					{
						body = new Bear();
					} else if (SharedConst.LAND_TYPE == 1 || SharedConst.LAND_TYPE == 3)
					{
						body = new Crocodyle();
					} else 
					{
						body = new Crocodyle();
					}
					
					break;
				case "strangers":
					//trace(size)
					if (size == 5)
					{
						
						body = new Strangers();
					} else if(size == 10)
					{
						body = new Strangers10();
					} else 
					{
						body = new Strangers();
					}
					break;
				case "berry":
					if (SharedConst.LAND_TYPE == 4)
					{
						body = new Bananas();
					} else 
					{
						body = new Berry();
					}
					break;
				case "giant":
					body = new Pterodactyl();
					break;
				default:
					if (SharedConst.LAND_TYPE == 4)
					{
						body = new Camel();
					} else 
					{
						body = new Antelope();
					}
					
					break;
			}
			
			human.addChild(body);
		}
		
		
		
		public function setPosition(newX:Number, newY:Number):void 
		{
			human.x = newX;
			human.y = newY;
		}
		
		
		public function setState(data:Object):void 
		{
			var state:String = data.newState
			switch (state)
			{
				case "eated":
					body.gotoAndStop(2);
				break;
				case "goWithTribe":
					body.gotoAndStop(3);
				break;
				case "CrocodyleGoleft":
					body.rotation = -90;
				break;
				case "CrocodyleGoright":
					body.rotation = 90;
				break;
				case "AntelopeGoright":
					body.scaleX = -1;
				break;
			}
		}
		
		public function removeAnimal():void 
		{
			(GameFacade.getInstance().retrieveProxy(SharedConst.GAME_SERVICE) as IGameService).getCreaturesClip().removeChild(human);
		}
		
		
		
	}

}