package {
    
    import org.flixel.*;
    
    public class GameMap1 extends GameMap {
        
        public var numberOfDarkMatters:uint = 2;
        public var darkMattersPositions:Array;
        
        public function GameMap1(level:uint, playState:FlxState) {
            super(level, playState);
            init();
        }
        
        public function init():void {
            initDarkMattersPositions();
            initDarkMatters();
            initPortal();
            initInitialPlayerPosition();
        }
        
        override public function addGameMapElements():void {
            playState.add(this.map);
            playState.add(this.darkMatters);
            playState.add(this.portal);
        }
        
        public function initInitialPlayerPosition():void {
            //poistion is tileX = 2 and tileY = 2
            this.initialPlayerPosition = new FlxPoint(2 * GameMap.TILE_SIZE, 2 * GameMap.TILE_SIZE);
        }
        
        public function initPortal():void {
            var portalPosition:FlxPoint = new FlxPoint();
            //always tile y-27
            portalPosition.y = 27 * GameMap.TILE_SIZE;
            
            var xTilePosition:int = Math.floor(Math.random() * 39);
            if (xTilePosition <= 0) {
                xTilePosition = 1;
            }
            portalPosition.x = xTilePosition * GameMap.TILE_SIZE;
            this.portal = new FlxSprite(portalPosition.x, portalPosition.y, this.pngPortal);
        }
        
        public function darkMatterBehaviors(id:int):Function {
            var behavior:Function;
            if (id == 1) {
                behavior = darkMatter1Behavior();
            } else if (id == 2) {
                behavior = darkMatter2Behavior();
            }
            return behavior;
        }
        
        public function darkMatter2Behavior():Function {
            //current time of exection of the game
            var currentTime:Number = 0;
            //last time the dark matter grown
            var lastTime:Number = 0;
            //tells if the darkmatter has already grown one time
            var firstGrow:Boolean = true;
            
            return function(darkMatter:DarkMatter):void {
                var timeToGrow:Boolean;
                if (firstGrow) {
                    //the first grow takes only 3 seconds
                    timeToGrow = currentTime > lastTime + 3;
                } else {
                    //the further growns will take 5 seconds
                    timeToGrow = currentTime > lastTime + 5;
                }
                
                if (timeToGrow) {
                    darkMatter.changeRadius(5);
                    lastTime = currentTime;
                    firstGrow = false;
                    return;
                }
                currentTime += FlxG.elapsed;
            }
        }
        
        public function darkMatter1Behavior():Function {
            var currentTime:Number = 0;
            var lastTime:Number = 0;
            
            return function(darkMatter:DarkMatter):void {
                var timeToGrow:Boolean = currentTime > lastTime + 5;
                if (timeToGrow) {
                    darkMatter.changeRadius(30);
                    lastTime = currentTime;
                    return;
                }
                currentTime += FlxG.elapsed;
            }
        }
        
        public function initDarkMatters():void {
            var position1:FlxPoint = darkMattersPositions[0];
            var darkMatter1:DarkMatter = new DarkMatter(position1.x, position1.y,
                darkMatter1Behavior(), 30);
            
            darkMatters.add(darkMatter1);
            
            var position2:FlxPoint = darkMattersPositions[1];
            var darkMatter2:DarkMatter = new DarkMatter(position2.x, position2.y,
                darkMatter2Behavior(), 10);
            
            darkMatters.add(darkMatter2);
            
        }
        
        public function initDarkMattersPositions():void {
            //upper right corner
            var position1:FlxPoint = new FlxPoint(640, 0);
            //
            var position2:FlxPoint = new FlxPoint(FlxG.width, FlxG.height);
            darkMattersPositions = new Array();
            darkMattersPositions.push(position1);
            darkMattersPositions.push(position2);
            
        }
        
    }
    
}