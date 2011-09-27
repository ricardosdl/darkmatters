package {
    
    import org.flixel.*;
    
    public class GameMap {
        
        public var darkMatters:Array;
        public var map:FlxTilemap;
        
        public function GameMap(level:uint) {
            darkMatters = new Array();
            map = Maps.getMap(level);
        }
        
    }
    
}