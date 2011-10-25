package {
    
    import org.flixel.*;
    
    public class GameMap {
        
        public static const TILE_SIZE:int = 16;
        public static const HALF_TILE_SIZE:int = int(TILE_SIZE / 2);
        
        [Embed(source="data/gfx/portal.png")]
        public var pngPortal:Class;
        
        public var darkMatters:FlxGroup;
        public var map:FlxTilemap;
        public var portal:FlxSprite;
        public var playState:FlxState;
        /**
         *This attribute is used to store an array representation of the map.
        */
        public var arrayMap:Array;
        
        public var initialPlayerPosition:FlxPoint;
        
        public function GameMap(level:uint, playState:FlxState) {
            darkMatters = new FlxGroup();
            map = Maps.getMap(level);
            this.playState = playState;
        }
        
        /**
         *This method is overrided in the subclasses.
        */
        public function addGameMapElements():void {}
        
    }
    
}