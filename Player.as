package {
    
    import org.flixel.*;
    
    public class Player extends FlxSprite {
        
        public static const MAX_VELOCITY:int = 100;
        public static const ACCELERATION:int = MAX_VELOCITY;
        
        
        public function Player(x:Number, y:Number) {
            super(x, y);
            makeGraphic(10,12,0xffaa1111);
            maxVelocity.x = MAX_VELOCITY;
            maxVelocity.y = MAX_VELOCITY;
            drag.x = ACCELERATION;
            drag.y = ACCELERATION;
        }
        
        public function input():void {
            acceleration.x = 0;
            acceleration.y = 0;
            if (FlxG.keys.LEFT || FlxG.keys.RIGHT) {
                if (FlxG.keys.LEFT) {
                    acceleration.x = -1 * ACCELERATION;
                } else {
                    acceleration.x = ACCELERATION;
                }
            }
            
            if (FlxG.keys.UP || FlxG.keys.DOWN) {
                if (FlxG.keys.UP) {
                    acceleration.y = -1 * ACCELERATION;
                } else {
                    acceleration.y = ACCELERATION;
                }
            }
        }
        
        override public function update():void {
            super.update();
            input();
        }
        
    }
    
}