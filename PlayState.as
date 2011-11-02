package {
    
    import org.flixel.*;
    import org.flixel.plugin.photonstorm.*;
    
    public class PlayState extends FlxState {
        
        public static var player:Player;
        
        public var darkMatter:DarkMatter;
        
        public var maps:Maps;
	
	public var gameMap:GameMap;
	
	public static var playState:PlayState;
	
	public function PlayState() {
	    super();
	    playState = this;
	}
        
        override public function create():void {
            gameMap = getGameMap(GameState.currentLevel);
	    gameMap.addGameMapElements();
	    
	    player = new Player(gameMap.initialPlayerPosition.x, gameMap.initialPlayerPosition.y);
            add(player);
	    
	    FlxG.camera.setBounds(0, 0, 640, 480, true);
	    FlxG.camera.follow(player, FlxCamera.STYLE_TOPDOWN_TIGHT);
            
            FlxG.mouse.show();
            
        }
	
	public function getGameMap(level:uint):GameMap {
	    var currentGameMap:GameMap;
	    if (level == 1) {
		currentGameMap = new GameMap1(level, this);
	    } else if (level == 2) {
		currentGameMap = new GameMap2(level, this);
	    } else if (level == 3) {
		currentGameMap = new GameMap3(level, this);
	    } else if (level == 4) {
		currentGameMap = new GameMap4(level, this);
	    } else if (level == 5) {
		currentGameMap = new GameMap5(level, this);
	    } else if (level == 6) {
		currentGameMap = new GameMap6(level, this);
	    }
	    return currentGameMap;
	}
        
        override public function update():void {
            super.update();
	    //trace('player velocity x:' + player.velocity.x);
	    //trace('player velocity y:' + player.velocity.y);
            FlxG.collide(gameMap.map, player);
	    FlxG.collide(gameMap.map, gameMap.mapColliders);
	    playerDarkMattersColisions(player, gameMap.darkMatters);
	    playerPortalCollisions();
            input();
        }
	
	public function playerPortalCollisions():void {
	    if (FlxG.overlap(player, gameMap.portal)) {
		trace('next level please');
	    }
	}
	
	public function playerDarkMattersColisions(player:FlxSprite, darkMatters:FlxGroup):void {
	    var sizeDarkMatters:int = darkMatters.length;
	    for(var i:int = sizeDarkMatters - 1; i >= 0; i--) {
		var darkMatter:FlxSprite = darkMatters.members[i] as FlxSprite;
		if (FlxCollision.pixelPerfectCheck(player, darkMatter)) {
		    trace('game over');
		}
	    }
	    
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