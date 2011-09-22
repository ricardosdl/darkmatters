package {
    
    import org.flixel.*;
    
    public class PlayState extends FlxState {
        
        public var player:Player;
        
        public var darkMatter:DarkMatter;
        
        public var map1:FlxTilemap;
        
        public var maps:Maps;
        
        override public function create():void {
            player = new Player(FlxG.width / 2, FlxG.height / 2);
            add(player);
            
            FlxG.camera.setBounds(0, 0, 640, 480, true);
	    FlxG.camera.follow(player, FlxCamera.STYLE_PLATFORMER);
            
            maps = new Maps();
            
            map1 = maps.getMap(GameData.currentLevel);
            add(map1);
            
            darkMatter = new DarkMatter(100, 100);
            add(darkMatter);
            
            FlxG.mouse.show();
            
        }
        
        override public function update():void {
            super.update();
            FlxG.collide(map1, player);
            if (FlxG.overlap(darkMatter, player, overlapped)) {
                trace("overlapped");
            } else {
                trace("didn't overlapped");
            }
            input();
        }
        
        public function overlapped(sprite1:FlxSprite, sprite2:FlxSprite):void {
            trace("collided");
        }
        
        public function input():void {
            if (FlxG.keys.justPressed("C")) {
                darkMatter.changeRadius(15);
            } else if (FlxG.keys.justPressed("X")) {
                darkMatter.changeRadius(-15);
            }
        }
        
    }
    
}