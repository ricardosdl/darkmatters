package {
    
    import org.flixel.*;
    
    public class GameMap4 extends GameMap {
        
        public var numberOfDarkMatters:uint = 2;
        public var darkMattersPositions:Array;
        
        public function GameMap4(level:uint, playState:FlxState) {
            super(level, playState);
            init();
        }
        
        public function init():void {
            initDarkMattersPosition();
            initDarkMatters();
            initPortal();
            initInitialPlayerPosition();
        }
        
        public function initInitialPlayerPosition():void {
            //tileX = 1, tileY = 28
            this.initialPlayerPosition = new FlxPoint(1 * GameMap.TILE_SIZE, 28 * GameMap.TILE_SIZE);
        }
        
        public function initPortal():void {
            var portalPosition:FlxPoint = new FlxPoint();
            //always tileX = 25, tileY = 13
            portalPosition.x = 25 * GameMap.TILE_SIZE;
            
            portalPosition.y = 13 * GameMap.TILE_SIZE;
            
            this.portal = new FlxSprite(portalPosition.x, portalPosition.y, this.pngPortal);
            this.portal.alive = false;
            this.portal.exists = false;
        }
        
        public function darkMatter1Behavior():Function {
            //TODO implement this darkmatter
            return function(darkMatter:DarkMatter):void {
                //not much to do for now
            }
        }
        
        public function darkMatter2Behavior():Function {
            //TODO implement this darkmatter
            return function(darkMatter:DarkMatter):void {
                //not much to do for now
            }
        }
        
        public function initDarkMatters():void {
            var position1:FlxPoint = darkMattersPositions[0];
            var darkMatter1:DarkMatter = new DarkMatter(position1.x, position1.y,
                darkMatter1Behavior(), 30);
            
            var position2:FlxPoint = darkMattersPositions[1];
            var darkMatter2:DarkMatter = new DarkMatter(position2.x, position2.y,
                darkMatter2Behavior(), 30);
            
            darkMatters.add(darkMatter1)
            darkMatters.add(darkMatter2);
        }
        
        public function initDarkMattersPosition():void {
            darkMattersPositions = new Array();
            
            var halfTileSize:Number = GameMap.TILE_SIZE / 2;
            
            //tileX = 18, tileY = 14
            var position1:FlxPoint = new FlxPoint(18 * GameMap.TILE_SIZE + halfTileSize,
                14 * GameMap.TILE_SIZE + halfTileSize);
            darkMattersPositions.push(position1);
            
            //tileX = 20, tileY = 16
            var position2:FlxPoint = new FlxPoint(20 * GameMap.TILE_SIZE + halfTileSize,
                16 * GameMap.TILE_SIZE + halfTileSize);
            darkMattersPositions.push(position2);
            
        }
        
    }

}