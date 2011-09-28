package {
    
    import org.flixel.*;
    
    public class GameMap {
        
        public var darkMatters:FlxGroup;
        public var map:FlxTilemap;
        
        public function GameMap(level:uint) {
            darkMatters = new FlxGroup();
            map = Maps.getMap(level);
        }
        
    }
    
}