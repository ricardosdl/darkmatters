package {

    import org.flixel.*;
    
    public class GameMap5 extends GameMap {
        
        public var numberOfDarkMatters:uint = 3;
        public var darkMattersPositions:Array;
        
        public function GameMap5(level:uint, playState:FlxState) {
            super(level, playState);
            init();
        }
        
        public function init():void {
            initDarkMattersPosition();
            initDarkMatters();
            //initPushableBrick();
            initPortal();
            initInitialPlayerPosition();
        }
        
        override public function addGameMapElements():void {
            playState.add(this.map);
            playState.add(this.darkMatters);
            playState.add(this.portal);
        }
        
        public function initInitialPlayerPosition():void {
            //tileX = 36, tileY = 27
            this.initialPlayerPosition = new FlxPoint(36 * GameMap.TILE_SIZE, 27 * GameMap.TILE_SIZE);
        }
        
        public function initPortal():void {
            var portalPosition:FlxPoint = new FlxPoint();
            //always tileX = 11, tileY = 18
            portalPosition.x = 11 * GameMap.TILE_SIZE;
            
            portalPosition.y = 18 * GameMap.TILE_SIZE;
            
            this.portal = new FlxSprite(portalPosition.x, portalPosition.y, this.pngPortal);
        }
        
        public function initDarkMatters():void {
            var position1:FlxPoint = darkMattersPositions[0];
            var darkMatter1:DarkMatter = new DarkMatter(position1.x, position1.y,
                function(darkMatter:DarkMatter):void{});
            trace(darkMatter1);
            
            var position2:FlxPoint = darkMattersPositions[1];
            var darkMatter2:DarkMatter = new DarkMatter(position2.x, position2.y,
                function(darkMatter:DarkMatter):void{});
            trace(darkMatter2);
            
            var position3:FlxPoint = darkMattersPositions[2];
            var darkMatter3:DarkMatter = new DarkMatter(position3.x, position3.y,
                function(darkMatter:DarkMatter):void{});
            trace(darkMatter3);
            
            darkMatters.add(darkMatter1);
            darkMatters.add(darkMatter2);
            darkMatters.add(darkMatter3);
            
        }
        
        public function initDarkMattersPosition():void {
            //these are starting positions as the darkmatters will move
            darkMattersPositions = new Array();
            
            var halfTileSize:Number = GameMap.TILE_SIZE / 2;
            
            //tileX = 10, tileY = 14
            var position1:FlxPoint = new FlxPoint(10 * GameMap.TILE_SIZE + halfTileSize,
                14 * GameMap.TILE_SIZE + halfTileSize);
            darkMattersPositions.push(position1);
            
            //tileX = 36, tileY = 9
            var position2:FlxPoint = new FlxPoint(36 * GameMap.TILE_SIZE + halfTileSize,
                9 * GameMap.TILE_SIZE + halfTileSize);
            darkMattersPositions.push(position2);
            
            //tileX = 1, tileY = 28
            var position3:FlxPoint = new FlxPoint(1 * GameMap.TILE_SIZE + halfTileSize,
                28 * GameMap.TILE_SIZE + halfTileSize);
            darkMattersPositions.push(position3);
            
        }
        
    }
}