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
		
		
		public function AnimalView(hName:String) 
		{
			humanName = hName;
			init();
		}
		
		public function init():void {
			
			(GameFacade.getInstance().retrieveProxy(SharedConst.GAME_SERVICE) as IGameService).getCreaturesClip().addChild(human);
			//var body:Rectangle = new Rectangle(0, 0, 20, 20);
			switch (humanName)
			{
				case "antelope":
					body = new Antelope();
					break;
				case "crocodyle":
					body = new Crocodyle();
					break;
				case "strangers":
					body = new Strangers();
					break;
				case "berry":
					body = new Berry();
					break;
				default:
					body = new Antelope();
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