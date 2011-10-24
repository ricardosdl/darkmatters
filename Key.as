package {
    
    import org.flixel.*;
    import org.flixel.plugin.photonstorm.*;
    
    public class Key extends FlxSprite {
        
        [Embed(source='data/gfx/key.png')]
        public static var keyImg:Class;
        
        public var gameMap:GameMap;
        
        public function Key(x:Number, y:Number, gameMap:GameMap) {
            super(x, y, keyImg);
            this.gameMap = gameMap;
        }
        
        override public function update():void {
            if (FlxCollision.pixelPerfectCheck(PlayState.player, this)) {
                gameMap.portal.alive = true;
                gameMap.portal.exists = true;
                kill();
            }
        }
        
    }

}