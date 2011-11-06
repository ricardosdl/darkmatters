package {
    
    import org.flixel.*;
    import org.flixel.plugin.photonstorm.*;
    
    public class PlayState extends FlxState {
        
        public static var player:Player;
        
        public var darkMatter:DarkMatter;
        
        public var maps:Maps;
	
	public var gameMap:GameMap;
	
	public static var playState:PlayState;
	/**
	 *If this is true it's bad for the player.
	*/
	public static var gameOver:Boolean;
	/**
	 *Helper var that indicates if we already removed the gameMap.darkMatters from the screen.
	 *It's used when we reach the gameOver state.
	*/
	public var _darkMattersRemoved:Boolean;
	/**
	 *IF true indicates that we already added the game over darkMatter. This
	 *darkmatter is showed to the player when she/he fall to the darkness.
	*/
	public var _addedGameOverDarkMatter:Boolean;
	
	public var gameOverDarkMatter:DarkMatter;
	/**
	 *We use this "layer" because we want that the gameOverDarKMatter stay bellow
	 *the player. When this darkMatter grow it will appear that it's growing from inside
	 *the player.
	*/
	public var gameOverDarkMatterLayer:FlxGroup;
	
	
	public function PlayState() {
	    super();
	    playState = this;
	}
        
        override public function create():void {
	    gameOver = false;
	    _darkMattersRemoved = false;
	    _addedGameOverDarkMatter = false;
            gameMap = getGameMap(GameState.currentLevel);
	    gameMap.addGameMapElements();
	    
	    gameOverDarkMatterLayer = new FlxGroup();
	    add(gameOverDarkMatterLayer);
	    
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
	
	public function removeGameMapDarkMatters():void {
	    if (_darkMattersRemoved) {
		//nothing to do
		return;
	    }
	    var numDarkMatters:int = gameMap.darkMatters.length;
	    for(var i:int = numDarkMatters - 1; i >= 0; i--) {
		var darkMatter:FlxSprite = gameMap.darkMatters.members[i] as FlxSprite;
		darkMatter.alive = false;
		darkMatter.exists = false;
		darkMatter.visible = false;
		remove(darkMatter);
	    }
	    _darkMattersRemoved = true;
	}
	
	public function gameOverDarkMatterBehavior():Function {
	    var growing:Boolean = false;
	    var waitTime:int = 2;
	    var currentTime:Number = 0;
	    var radiusStepIncreased:Boolean = false;
	    var maxRadius:Number = 320;
	    
	    return function(darkMatter:DarkMatter):void {
		if (! growing) {
		    darkMatter.changeRadius(maxRadius);
		    growing = true;
		}
		
		if (growing && ! radiusStepIncreased) {
		    currentTime += FlxG.elapsed;
		    if (currentTime > waitTime) {
			darkMatter.radiusStep = 250;
			radiusStepIncreased = true;
		    }
		}
		//TODO finish this shit
		if (player.alpha > 0) {
		    var currentRadiusPercentage:Number = ((darkMatter.currentRadius * 100) / maxRadius) / 100;
		    player.alpha = 1 - currentRadiusPercentage;
		}
		
		if (! darkMatter.isChangingRadius()) {
		    FlxG.switchState(new PlayState());
		}
		
	    }
	}
	
	public function addGameOverDarkMatter():void {
	    if (_addedGameOverDarkMatter) {
		return;
	    }
	    gameOverDarkMatter = new DarkMatter(player.x + player.origin.x,
		player.y + player.origin.y, gameOverDarkMatterBehavior(), 30);
	    gameOverDarkMatterLayer.add(gameOverDarkMatter);
	    _addedGameOverDarkMatter = true;
	}
        
        override public function update():void {
            super.update();
	    if (gameOver) {
		removeGameMapDarkMatters();
		addGameOverDarkMatter();
	    }
	    FlxG.collide(gameMap.map, player);
	    FlxG.collide(gameMap.map, gameMap.mapColliders);
	    playerPortalCollisions();
	    playerDarkMattersColisions(player, gameMap.darkMatters);
        }
	
	public function playerPortalCollisions():void {
	    if (FlxG.overlap(player, gameMap.portal)) {
		if (GameState.currentLevel < 6) {
		    GameState.currentLevel += 1;
		    FlxG.switchState(new PlayState());
		}
	    }
	}
	
	public function playerDarkMattersColisions(player:FlxSprite, darkMatters:FlxGroup):void {
	    var sizeDarkMatters:int = darkMatters.length;
	    for(var i:int = sizeDarkMatters - 1; i >= 0; i--) {
		var darkMatter:FlxSprite = darkMatters.members[i] as FlxSprite;
		if (FlxCollision.pixelPerfectCheck(player, darkMatter)) {
		    gameOver = true;
		}
	    }
	    
	}
        
    }
    
}