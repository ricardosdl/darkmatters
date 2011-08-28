package {
    
    import org.flixel.*;
    
    public class Maps {
        
        [Embed(source='data/maps/darkness_1.csv', mimeType='application/octet-stream')]
        public var csvMap1:Class;
        
        [Embed(source="data/gfx/levels_tiles.png")]
        public var pngTilesLevels:Class;
        
        public function Maps():void {
        }
        
        public function map1():FlxTilemap{
            var map1:FlxTilemap = new FlxTilemap();
            map1.loadMap(new csvMap1, pngTilesLevels, 16, 16);
            map1.x = 0;
            map1.y = 0;
            return map1;
        }
        
    }
    
}