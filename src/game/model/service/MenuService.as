package game.model.service 
{
	/**
	 * ...
	 * @author messia_s
	 */
	
	 
	 import flash.display.MovieClip;
	 import flash.events.Event;
	 import flash.events.KeyboardEvent;
	 import flash.events.MouseEvent;
	 import flash.events.TimerEvent;
	 import flash.geom.Point;
	 import flash.media.Sound;
	 import flash.utils.Timer;
	 import game.common.interfaces.*;
	import game.common.GameFacade;
	import game.common.SharedConst;
	import game.common.Utils;
	import org.puremvc.as3.interfaces.IProxy;
	import org.puremvc.as3.patterns.proxy.Proxy;
	import flash.net.URLRequest;
	import game.common.SoundPlayer;
	import flash.media.SoundMixer;
	import flash.utils.ByteArray;
	import flash.system.System;
	
	
	public class MenuService extends Proxy implements IProxy
	{
		
		
		public function MenuService(pname:String,data:Object = null ):void 
		{
			proxyName = pname;//SharedConst.GAME_SERVICE;
			
			init();
		}
		
		public function init():void {
			//proxyName = SharedConst.GAME_SERVICE;
			GameFacade.getInstance().mainStage.focus = GameFacade.getInstance().mainStage;
			
			
		}
		
		
		
		
		
	}

}