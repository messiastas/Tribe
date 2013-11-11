package game.view.components 
{
	import adobe.utils.CustomActions;
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
	import flash.system.*;
	
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
		private var helpTimer:Timer = new Timer(1000);
		
		
		public function InterfaceView(hName:String) 
		{
			init();
		}
		
		public function init():void {
			
			GameFacade.getInstance().InterfaceClip.addChild(movie);
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
			
			body.levelTime.gotoAndStop(1);
			
			GameFacade.getInstance().mainStage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
			
			helpTimer.addEventListener(TimerEvent.TIMER, refreshTime);
			helpTimer.start();
			changePeople();
			
			body.nightMask.mouseEnabled = false;
			body.mcDanger.visible = false;
			body.mcDanger.mouseEnabled = false;
			checkNight();
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
				case 27:
					fscommand("quit");
					break;
			}
		}
		
		private function onWeaponClick(e:MouseEvent):void 
		{
			dispatchEvent(new Event("onWeaponClick"))
			checkFire(false);
		}
		
		private function onTorchClick(e:MouseEvent):void 
		{
			checkFire(true);
			dispatchEvent(new Event("onTorchClick"))
		}
		
		private function onHandsClick(e:MouseEvent):void 
		{
			dispatchEvent(new Event("onHandsClick"))
			checkFire(false);
		}
		
		private function onBornClick(e:MouseEvent):void 
		{
			dispatchEvent(new Event("onBornClick"))
			checkFire(false);
		}
		
		private function onSacrificeClick(e:MouseEvent):void 
		{
			dispatchEvent(new Event("onSacrificeClick"))
			checkFire(false);
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
			helpTimer.reset();
			helpTimer.start();
			helpTimer.addEventListener(TimerEvent.TIMER, removeHelp);
		}
		private function removeHelp(e:TimerEvent):void 
		{
			body.removeChild(helpClip);
			helpTimer.removeEventListener(TimerEvent.TIMER, removeHelp);
			//helpTimer.reset();
		}
		
		
		private function refreshTime(e:TimerEvent):void 
		{
			body.levelTime.gotoAndStop(int(body.levelTime.totalFrames*(SharedConst.SPEND_DISTANCE / SharedConst.MAP_DISTANCE)))
			if (SharedConst.SPEND_DISTANCE > SharedConst.MAP_DISTANCE)
			{
				dispatchEvent(new Event("finishLevel"))
			}
		}
		
		public function changePeople():void 
		{
			
			body.people.text = String(SharedConst.TRIBE_SIZE);
			body.shamanLevel.text = String(SharedConst.SHAMAN_LEVEL);
			checkShamanLevel();
			if (SharedConst.CURRENT_STATE == "torch")
				checkFire(true);
			if (SharedConst.TRIBE_SIZE > 5)
			{
				body.mcDanger.visible = false;
				
			} else 
			{
				body.mcDanger.visible = true;
			}
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
		
		public function removeListeners():void 
		{
			body.bRegroup.removeEventListener(MouseEvent.CLICK, onLeftClick);
			body.bRegroup.removeEventListener(MouseEvent.RIGHT_CLICK, onRightClick);
			
			body.bWeapon.removeEventListener(MouseEvent.CLICK, onWeaponClick);
			body.bTorches.removeEventListener(MouseEvent.CLICK, onTorchClick);
			body.bHands.removeEventListener(MouseEvent.CLICK, onHandsClick);
			body.bBorn.removeEventListener(MouseEvent.CLICK, onBornClick);
			body.bSacrifice.removeEventListener(MouseEvent.CLICK, onSacrificeClick);
			helpTimer.removeEventListener(TimerEvent.TIMER, refreshTime);
			helpTimer.stop();
		}
		
		public function clickAreaInvisible():void 
		{
			body.bRegroup.visible = false;
			body.nightMask.visible = false;
			
			body.bWeapon.visible = false;
			body.bTorches.visible = false;
			body.bBorn.visible = false;
			body.bSacrifice.visible = false;
		}
		
		public function clickAreaVisible():void 
		{
			body.bRegroup.visible = true;
			checkNight();
			checkShamanLevel();
			onHandsClick(null);
		}
		
		private function checkNight():void 
		{
			if (SharedConst.CURRENT_DAYTIME == "day")
			{
				body.nightMask.visible = false;
			} else 
			{
				body.nightMask.visible = true;
			}
		}
		private function checkFire(isFire:Boolean):void 
		{
			if (SharedConst.CURRENT_DAYTIME == "night")
			{
				if (!isFire)
				{
					body.nightMask.gotoAndStop(1);
				} else 
				{
					var frame:int = 2 + int(SharedConst.TRIBE_SIZE / 10);
					if (frame > 5)
						frame = 5;
					body.nightMask.gotoAndStop(frame);
				}
			}
		}
		
		public function showGameOver():void 
		{
			helpTimer.addEventListener(TimerEvent.TIMER, addGameOver);
			helpTimer.start();
		}
		
		private function addGameOver(e:TimerEvent):void 
		{
			helpTimer.removeEventListener(TimerEvent.TIMER, addGameOver);
			helpTimer.stop();
			
			GameFacade.getInstance().mainStage.frameRate = 24;
			var gameOverClip:GameOver = new GameOver;
			GameFacade.getInstance().InterfaceClip.addChild(gameOverClip);
			gameOverClip.gotoAndPlay(1);
			gameOverClip.addEventListener(MouseEvent.CLICK, onGameOverClick);
			gameOverClip.mouseChildren = false;
		}
		
		private function onGameOverClick(e:MouseEvent):void 
		{
			//fscommand("quit");
			dispatchEvent(new Event("restartGame"));
			GameFacade.getInstance().InterfaceClip.removeChild((e.target as MovieClip));
			
			GameFacade.getInstance().mainStage.frameRate = 60;
		}
		
		
		
		
		
		
		
		
	}

}