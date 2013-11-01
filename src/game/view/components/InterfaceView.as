package game.view.components 
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.KeyboardEvent;
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
	public class InterfaceView extends EventDispatcher 
	{
		private var movie:Sprite = new Sprite;
		private var body:interfaceView;
		private var humanName:String = "";
		private var helpClip:MovieClip;
		private var helpTimer:Timer = new Timer(2000);
		
		
		public function InterfaceView(hName:String) 
		{
			init();
		}
		
		public function init():void {
			
			(GameFacade.getInstance().retrieveProxy(SharedConst.GAME_SERVICE) as IGameService).getInterfaceClip().addChild(movie);
			//var body:Rectangle = new Rectangle(0, 0, 20, 20);
			body = new interfaceView();
			movie.addChild(body);
			//trace("here");
			body.bRegroup.addEventListener(MouseEvent.CLICK, onLeftClick);
			body.bRegroup.addEventListener(MouseEvent.RIGHT_CLICK, onRightClick);
			
			body.bWeapon.addEventListener(MouseEvent.CLICK, onWeaponClick);
			body.bTorches.addEventListener(MouseEvent.CLICK, onTorchClick);
			body.bHands.addEventListener(MouseEvent.CLICK, onHandsClick);
			body.bBorn.addEventListener(MouseEvent.CLICK, onBornClick);
			body.bSacrifice.addEventListener(MouseEvent.CLICK, onSacrificeClick);
			
			body.bWeapon.buttonMode = true;
			body.bTorches.buttonMode = true;
			body.bHands.buttonMode = true;
			body.bBorn.buttonMode = true;
			body.bSacrifice.buttonMode = true;
			
			GameFacade.getInstance().mainStage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
			
			helpTimer.addEventListener(TimerEvent.TIMER, removeHelp);
			changePeople(SharedConst.TRIBE_SIZE);
		}
		
		private function onKeyDown(e:KeyboardEvent):void 
		{
			switch (e.keyCode)
			{
				case 49:
					if (body.bHands.visible)
						onHandsClick(null);
					break;
				case 50:
					if (body.bWeapon.visible)
						onWeaponClick(null);
					break;
				case 51:
					if (body.bTorches.visible)
						onTorchClick(null);
					break;
				case 52:
					if (body.bBorn.visible)
						onBornClick(null);
					break;
				case 53:
					if (body.bSacrifice.visible)
						onSacrificeClick(null);
					break;
			}
		}
		
		private function onWeaponClick(e:MouseEvent):void 
		{
			dispatchEvent(new Event("onWeaponClick"))
		}
		
		private function onTorchClick(e:MouseEvent):void 
		{
			dispatchEvent(new Event("onTorchClick"))
		}
		
		private function onHandsClick(e:MouseEvent):void 
		{
			dispatchEvent(new Event("onHandsClick"))
		}
		
		private function onBornClick(e:MouseEvent):void 
		{
			dispatchEvent(new Event("onBornClick"))
		}
		
		private function onSacrificeClick(e:MouseEvent):void 
		{
			dispatchEvent(new Event("onSacrificeClick"))
		}
		
		private function onLeftClick(e:MouseEvent):void 
		{
			dispatchEvent(new Event("leftClick"))
				
		}
		
		private function onRightClick(e:MouseEvent):void 
		{
			dispatchEvent(new Event("rightClick"))
		}
		
		public function showLeft():void 
		{
			helpClip = new HelpLeftClick;
			addHelp();
			
		}
		
		public function showRight():void 
		{
			helpClip = new HelpRightClick;
			addHelp();
		}
		
		private function addHelp():void 
		{
			body.addChildAt(helpClip, 0);
			helpClip.x = 800 / 2;
			helpClip.y = SharedConst.STAGE_HEIGHT / 4;
			helpTimer.start();
		}
		private function removeHelp(e:TimerEvent):void 
		{
			body.removeChild(helpClip);
			helpTimer.reset();
		}
		
		public function changePeople(num:int):void 
		{
			if(num>=0)
				body.people.text = String(num);
			body.shamanLevel.text = String(SharedConst.SHAMAN_LEVEL);
			checkShamanLevel();
		}
		
		public function changeSupplies():void 
		{
			body.supplies.text = String(int(SharedConst.SUPPLIES));
		}
		
		private function checkShamanLevel():void 
		{
			body.bWeapon.visible = false;
			body.bTorches.visible = false;
			body.bBorn.visible = false;
			body.bSacrifice.visible = false;
			
			if (SharedConst.SHAMAN_LEVEL >= SharedConst.LEVEL_FOR_WEAPON)
			{
				body.bWeapon.visible = true;
				if (SharedConst.SHAMAN_LEVEL >= SharedConst.LEVEL_FOR_TORCH)
				{
					body.bTorches.visible = true;
					if (SharedConst.SHAMAN_LEVEL >= SharedConst.LEVEL_FOR_BORN)
					{
						body.bBorn.visible = true;
						if (SharedConst.SHAMAN_LEVEL >= SharedConst.LEVEL_FOR_SACRIFICE)
						{
							body.bSacrifice.visible = true;
						}
					}
				}
			}
		}
		
		
		
		
		
		
		
		
	}

}