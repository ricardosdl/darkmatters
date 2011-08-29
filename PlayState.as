package {
    
    import org.flixel.*;
    
    public class PlayState extends FlxState {
        
        public var player:Player;
        
        public var map1:FlxTilemap;
        
        public var maps:Maps;
        
        override public function create():void {
            player = new Player(FlxG.width / 2, FlxG.height / 2);
            add(player);
            
            FlxG.camera.setBounds(0, 0, 640, 480, true);
	    FlxG.camera.follow(player, FlxCamera.STYLE_PLATFORMER);
            
            maps = new Maps();
            
            map1 = maps.map1();
            add(map1);
            
            var darkMatter:DarkMatter = new DarkMatter(500, 100);
            add(darkMatter);
            
        }
        
        override public function update():void {
            super.update();
            FlxG.collide(map1, player);
            trace('updated');
        }
        
    }
    
}