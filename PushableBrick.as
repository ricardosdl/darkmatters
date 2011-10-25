package {
    
    import org.flixel.*;
    
    public class PushableBrick extends FlxSprite {
        
        [Embed(source='data/gfx/pushable_brick.png')]
        public static var pushableBrickImg:Class;
        
        public var gameMap:GameMap;
        
        public function PushableBrick(x:Number, y:Number, gameMap:GameMap) {
            super(x, y, pushableBrickImg);
            this.gameMap = gameMap;
        }
        
        override public function update():void {
            super.update();
        }
        
    }

}