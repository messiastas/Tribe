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
	import game.common.interfaces.IHuman;
	import game.common.SharedConst;
	
	/**
	 * ...
	 * @author messia_s
	 */
	public class HumanView extends EventDispatcher 
	{
		private var human:Sprite = new Sprite;
		private var body:MovieClip;
		private var humanName:String = "";
		
		
		public function HumanView(hName:String) 
		{
			humanName = hName;
			init();
		}
		
		public function init():void {
			
			GameFacade.getInstance().mainStage.addChild(human);
			//var body:Rectangle = new Rectangle(0, 0, 20, 20);
			body = new Human();
			body.head.gotoAndPlay(int(Math.random() * (body.totalFrames - 1)) + 1)
			body.crown.visible = false;
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
				case "shaman":
					body.crown.visible = true;
					GameFacade.getInstance().mainStage.addChild(human);
					body.scaleX = body.scaleY = 1.5;
					break;
				case "dead":
					GameFacade.getInstance().mainStage.removeChild(human);
					break;
			}
		}
		
		
		
	}

}