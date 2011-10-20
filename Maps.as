package {
    
    import org.flixel.*;
    
    public class Maps {
        
        [Embed(source='data/maps/darkness_1.csv', mimeType='application/octet-stream')]
        public static var csvMap1:Class;
        
        [Embed(source='data/maps/darkness_2.csv', mimeType='application/octet-stream')]
        public static var csvMap2:Class;
        
        [Embed(source='data/maps/darkness_3.csv', mimeType='application/octet-stream')]
        public static var csvMap3:Class;
        
        [Embed(source='data/maps/darkness_4.csv', mimeType='application/octet-stream')]
        public static var csvMap4:Class;
        
        [Embed(source="data/gfx/levels_tiles.png")]
        public static var pngTilesLevels:Class;
        
        public function Maps():void {
            
        }
        
        public static function getMap(level:uint):FlxTilemap {
            var map:FlxTilemap = new FlxTilemap();
            map.x = 0;
            map.y = 0;
            if(level == 1) {
                map.loadMap(new Maps.csvMap1(), Maps.pngTilesLevels, 16, 16);
            } else if (level == 2) {
                map.loadMap(new Maps.csvMap2(), Maps.pngTilesLevels, 16, 16);
            } else if (level == 3) {
                map.loadMap(new Maps.csvMap3(), Maps.pngTilesLevels, 16, 16);
            } else if (level == 4) {
                map.loadMap(new Maps.csvMap4(), Maps.pngTilesLevels, 16, 16);
            }
            return map;
        }
        
    }
    
}