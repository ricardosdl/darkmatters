package {
    
    import org.flixel.*;
    
    public class Player extends FlxSprite {
        
        public static const MAX_VELOCITY:int = 75;
        public static const ACCELERATION:int = 150;
        public static const DRAG:int = 2 * MAX_VELOCITY;
        public static const INTERVAL_BETWEEN_STEPS_SOUND:Number = .25;
        
        [Embed(source="data/gfx/player_sprites.png")]
        private var imgPlayer:Class;
        
        [Embed(source="data/sfx/steps1.mp3")]
        private var mp3Steps:Class;
        
        public var handleInput:Boolean;
        
        public var lastTimePlayedStep:Number = 0;
        public var currentTime:Number = 0;
        
        
        public function Player(x:Number, y:Number) {
            super(x, y);
            //makeGraphic(10,12,0xffaa1111);
            loadGraphic(imgPlayer, true, true, 10, 12);
            addAnimation("idle", [4], 0, false);
            addAnimation("walk", [0, 1, 2, 3], 10, true);
            maxVelocity.x = MAX_VELOCITY;
            maxVelocity.y = MAX_VELOCITY;
            drag.x = DRAG;
            drag.y = DRAG;
            handleInput = true;
        }
        
        public function input():void {
            if (! handleInput) {
                return;
            }
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
        
        public function stop():void {
            play("idle");
            acceleration.x = 0;
            acceleration.y = 0;
            velocity.x = 0;
            velocity.y = 0;
        }
        
        override public function update():void {
            super.update();
            if (PlayState.gameOver) {
                stop();
                return;
            }
            
            input();
            
            if ((velocity.x != 0) || (velocity.y != 0)) {
                play("walk");
            } else {
                play("idle");
            }
            
            if (acceleration.x > 0) {
                facing = RIGHT;
            } else if (acceleration.x < 0) {
                facing = LEFT;
            }
            
            if ((velocity.x != 0) || (velocity.y != 0)) {
                currentTime += FlxG.elapsed;
                if ((currentTime - lastTimePlayedStep) >= INTERVAL_BETWEEN_STEPS_SOUND) {
                    FlxG.play(mp3Steps, .8, false);
                    lastTimePlayedStep = currentTime;
                }
            } else {
                currentTime += FlxG.elapsed;
                lastTimePlayedStep = currentTime;
            }
            
        }
        
    }
    
}