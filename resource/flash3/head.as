package  {
	
	import flash.display.MovieClip;
	import flash.events.Event;
    import flash.display.Sprite;
	
	public class head extends MovieClip {
		
		
		public function head() {
			// constructor code
			
			addEventListener(Event.ENTER_FRAME, my_e);
			
			function my_e(e:Event):void{
	           this.rotation += 1;
            }
		}
	}
	
}
