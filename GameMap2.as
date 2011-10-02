package {
    
    import org.flixel.*;
    
    public class GameMap2 extends GameMap {
        
        public var numberOfDarkMatters:uint = 2;
        public var darkMatterPositions:Array;
        
        public function GameMap2(level:uint) {
            super(level);
            initDarkMatterPositions();
            initDarkMatters();
            initPortal();
            initInitialPlayerPosition();
        }
        
        public function initInitialPlayerPosition():void {
            //poistion is tileX = 18 and tileY = 1
            this.initialPlayerPosition = new FlxPoint(18 * GameMap.TILE_SIZE, 1 * GameMap.TILE_SIZE);
        }
        
        public function initPortal():void {
            //always tileY = 29 and tileX = 17
            var portalPosition:FlxPoint = new FlxPoint();
            portalPosition.y = 28 * GameMap.TILE_SIZE;
            portalPosition.x = 16 * GameMap.TILE_SIZE;
            
            this.portal = new FlxSprite(portalPosition.x, portalPosition.y, this.pngPortal);
        }
        
        public function initDarkMatters():void {
            var position1:FlxPoint = darkMatterPositions[0];
            var darkMatter1:DarkMatter = new DarkMatter(position1.x, position1.y,
                darkMatter1Behavior(), 15);
            
            darkMatters.add(darkMatter1);
            
            var darkMatter2:DarkMatter = new DarkMatter(0, 0, darkMatter2Behavior());
            
            darkMatters.add(darkMatter2);
            
        }
        
        public function darkMatter2Behavior():Function {
            var lastPosition:FlxPoint = new FlxPoint();
            
            return function(darkMatter:DarkMatter):void {
                //TODO
            }
        }
        
        public function darkMatter1Behavior():Function {
            var currentTime:Number = 0;
            var lastTime:Number = 0;
            
            return function(darkMatter:DarkMatter):void {
                var timeToGrow:Boolean = currentTime > lastTime + 10;
                if (timeToGrow) {
                    darkMatter.changeRadius(15);
                    lastTime = currentTime;
                    return;
                }
                currentTime += FlxG.elapsed;
            }
        }
        
        public function initDarkMatterPositions():void {
            //bottom right corner
            var position1:FlxPoint = new FlxPoint(640, 480);
            this.darkMatterPositions = new Array();
            this.darkMatterPositions.push(position1);
            //just the first darkmatter is fixed, the second is dynamic
        }
        
    }
    
}