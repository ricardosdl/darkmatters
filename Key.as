package {
    
    import org.flixel.*;
    import org.flixel.plugin.photonstorm.*;
    
    public class Key extends FlxSprite {
        
        [Embed(source='data/gfx/key.png')]
        public static var keyImg:Class;
        
        [Embed(source='data/sfx/pickKey3.mp3')]
        public static var mp3PickKey:Class;
        
        public var gameMap:GameMap;
        
        public var pickKeySound:FlxSound;
        
        public function Key(x:Number, y:Number, gameMap:GameMap) {
            super(x, y, keyImg);
            this.gameMap = gameMap;
            pickKeySound = new FlxSound();
            pickKeySound.loadEmbedded(mp3PickKey);
        }
        
        override public function update():void {
            super.update();
            if (FlxCollision.pixelPerfectCheck(PlayState.player, this)) {
                gameMap.portal.alive = true;
                gameMap.portal.exists = true;
                pickKeySound.proximity(gameMap.portal.x, gameMap.portal.y, this, 320);
                pickKeySound.play();
                kill();
            }
        }
        
    }

}