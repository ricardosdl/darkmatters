package {
    
    import org.flixel.*;
    
    public class Player extends FlxSprite {
        
        public function Player(x:Number, y:Number) {
            super(x, y);
            makeGraphic(10,12,0xffaa1111);
        }
        
        override public function update():void {
            trace("player updated");
        }
        
    }
    
}