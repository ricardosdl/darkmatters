package {
    
    import org.flixel.*;
    
    public class PlayState extends FlxState {
        
        public static var player:Player;
        
        public var darkMatter:DarkMatter;
        
        public var maps:Maps;
	
	public var gameMap:GameMap;
        
        override public function create():void {
            player = new Player(FlxG.width / 2, FlxG.height / 2);
            add(player);
            
            FlxG.camera.setBounds(0, 0, 640, 480, true);
	    FlxG.camera.follow(player, FlxCamera.STYLE_PLATFORMER);
            
	    gameMap = getGameMap(GameState.currentLevel);
	    add(gameMap.map);
            
            add(gameMap.darkMatters);
            
            FlxG.mouse.show();
            
        }
	
	public function getGameMap(level:uint):GameMap {
	    var currentGameMap:GameMap;
	    if (level == 1) {
		currentGameMap = new GameMap1(level);
	    }
	    return currentGameMap;
	}
        
        override public function update():void {
            super.update();
            FlxG.collide(gameMap.map, player);
            if (FlxG.overlap(gameMap.darkMatters, player, overlapped)) {
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