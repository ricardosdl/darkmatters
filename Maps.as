package {
    
    import org.flixel.*;
    
    public class Maps {
        
        [Embed(source='data/maps/darkness_1.csv', mimeType='application/octet-stream')]
        public static var csvMap1:Class;
        
        [Embed(source="data/gfx/levels_tiles.png")]
        public static var pngTilesLevels:Class;
        
        public function Maps():void {
            
        }
        
        public static function getMap(level:uint):FlxTilemap {
            var map:FlxTilemap;
            if(level == 1) {
                map.loadMap(new Maps.csvMap1, Maps.pngTilesLevels, 16, 16);
                map.x = 0;
                map.y = 0;
            }
            return map;
        }
        
    }
    
}