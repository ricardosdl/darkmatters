package {

    import org.flixel.*;
    
    public class GhostBrick extends FlxSprite {
        
        [Embed(source="data/gfx/pushable_brick.png")]
        public static var img:Class;
        
        public function GhostBrick(x:Number, y:Number) {
            super(x, y, img);
            alpha = .8;
        }
        
    }
    
}