package  {
	import flash.display.MovieClip;

	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.geom.Point;
	import flash.text.TextLineMetrics;
	import ValveLib.Globals;
	
	public class gasbar extends MovieClip {
		
		public var gameAPI:Object;
		public var globals:Object;
		public var elementName:String;
		public var len:Number;
		
		public function setup(api:Object,glob:Object): * {
          this.gameAPI = api;
		  this.globals = glob;
          len=this.tiao.height;
          //这是我们的事件的监听器
          this.gameAPI.SubscribeToGameEvent("p_update", this.updateui2);
		  trace("phud ui init complete")
        }
		
		public function gasbar() {
			// constructor code
		}
		
		 public function updateui2(args:Object) : * {
			 
              trace("jajaja");
              var pID:int = globals.Players.GetLocalPlayer();
			  trace(len);
			  trace(args.pp1);
			  switch(pID) {
			     case 0:this.tiao.height=len*args.pp1/100;break;
				 case 1:this.tiao.height=len*args.pp2/100;break;
				 case 2:this.tiao.height=len*args.pp3/100;break;

			  }

            }
		
		
	}
	
}
