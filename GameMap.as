package {
    
    import org.flixel.*;
    
    public class GameMap {
        
        public static const TILE_SIZE:int = 16;
        
        [Embed(source="data/gfx/portal.png")]
        public var pngPortal:Class;
        
        public var darkMatters:FlxGroup;
        public var map:FlxTilemap;
        public var portal:FlxSprite;
        public var playState:PlayState;
        /**
         *This attribute is used to store an array representation of the map.
        */
        public var arrayMap:Array;
        
        public var initialPlayerPosition:FlxPoint;
        
        public function GameMap(level:uint) {
            darkMatters = new FlxGroup();
            map = Maps.getMap(level);
        }
        
    }
    
}