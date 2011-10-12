package {
    
    import org.flixel.*;
    
    public class DarkOther extends FlxSprite {
        
        public static const MAX_VELOCITY:int = 85;
        public static const ACCELERATION:int = 150;
        
        public function DarkOther(x:Number, y:Number) {
            super(x, y);
            makeGraphic(10,12,0x22bb1111);
            maxVelocity.x = MAX_VELOCITY;
            maxVelocity.y = MAX_VELOCITY;
        }
        
        override public function update():void {
            super.update();
            
        }
        
    }
    
}