package {
    
    import org.flixel.*;
    
    public class PlayState extends FlxState {
        
        public var player:Player;
        
        public var map1:FlxTilemap;
        
        public var maps:Maps;
        
        override public function create():void {
            player = new Player(FlxG.width / 2, FlxG.height / 2);
            add(player);
            
            maps = new Maps();
            
            map1 = maps.map1();
            add(map1);
            
        }
        
        override public function update():void {
            super.update();
            trace('updated');
        }
        
    }
    
}