package {
    
    import org.flixel.*;
    
    public class GameMap3 extends GameMap {
        
        public var numberOfDarkMatters:uint = 1;
        public var darkMattersPositions:Array;
        
        public function GameMap3(level:uint) {
            super(level);
            init();
        }
        
        public function init():void {
            initDarkMattersPosition();
            initDarkMatters();
            initPortal();
            initInitialPlayerPosition();
        }
        
        public function initInitialPlayerPosition():void {
            this.initialPlayerPosition = new FlxPoint(38 * GameMap.TILE_SIZE, 1 * GameMap.TILE_SIZE);
        }
        
        public function initPortal():void {
            var portalPosition:FlxPoint = new FlxPoint();
            //always tileX = 1
            portalPosition.x = 1 * GameMap.TILE_SIZE;
            
            portalPosition.y = 1 * GameMap.TILE_SIZE;
            
            this.portal = new FlxSprite(portalPosition.x, portalPosition.y, this.pngPortal);
            this.portal.alive = false;
            this.portal.exists = false;
            
        }
        
        public function darkMatter1Behavior():Function {
            //this darkmatter won't do too much
            return function():void {}
        }
        
        public function initDarkMatters():void {
            var position1:FlxPoint = darkMattersPositions[0];
            var darkMatter1:DarkMatter = new DarkMatter(position1.x, position1.y,
                darkMatter1Behavior(), 30);
            
            darkMatters.add(darkMatter1);
        }
        
        public function initDarkMattersPosition():void {
            //bottom right corner
            var position1:FlxPoint = new FlxPoint(640, 480);
            darkMattersPositions = new Array();
            darkMattersPositions.push(position1);
        }
        
    }

}