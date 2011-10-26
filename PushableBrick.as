package {
    
    import org.flixel.*;
    
    public class PushableBrick extends FlxSprite {
        
        [Embed(source='data/gfx/pushable_brick.png')]
        public static var pushableBrickImg:Class;
        
        public var gameMap:GameMap;
        
        public function PushableBrick(x:Number, y:Number, gameMap:GameMap) {
            super(x, y, pushableBrickImg);
            this.gameMap = gameMap;
            drag.x = 60;
            drag.y = 60;
        }
        
        override public function update():void {
            FlxG.collide(PlayState.player, this);
            super.update();
        }
        
    }

}