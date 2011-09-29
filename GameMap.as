package {
    
    import org.flixel.*;
    
    public class GameMap {
        
        [Embed(source="data/gfx/portal.png")]
        public static var pngPortal:Class;
        
        public var darkMatters:FlxGroup;
        public var map:FlxTilemap;
        
        public function GameMap(level:uint) {
            darkMatters = new FlxGroup();
            map = Maps.getMap(level);
        }
        
    }
    
}