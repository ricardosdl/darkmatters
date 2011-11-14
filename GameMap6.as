package {
    
    import org.flixel.*;
    
    public class GameMap6 extends GameMap {
        
        public var numberOfDarkMatters:uint = 1;
        public var darkMattersPositions:Array;
        
        public function GameMap6(level:uint, playState:FlxState) {
            super(level, playState);
            init();
        }
        
        public function init():void {
            initDarkMattersPosition();
            initDarkMatters();
            initPortal();
            initInitialPlayerPosition();
        }
        
        public function initPortal():void {
            var portalPosition:FlxPoint = new FlxPoint();
            //always tileX = 20, tileY = 15, midlle of the map
            portalPosition.x = 20 * GameMap.TILE_SIZE;
            
            portalPosition.y = 15 * GameMap.TILE_SIZE;
            
            this.portal = new FlxSprite(portalPosition.x, portalPosition.y, this.pngPortal);
            this.portal.alive = false;
            this.portal.exists = false;
        }
        
        override public function addGameMapElements():void {
            playState.add(this.map);
            playState.add(this.portal);
            playState.add(this.darkMatters);
        }
        
        public function initInitialPlayerPosition():void {
            //tileX = 1, tileY = 1
            this.initialPlayerPosition = new FlxPoint(1 * GameMap.TILE_SIZE, 1 * GameMap.TILE_SIZE);
        }
        
        public function darkMatter1Behavior():Function {
            
            var darkMatterCentralPoint:FlxPoint = new FlxPoint();
            var playerCentralPoint:FlxPoint = new FlxPoint();
            
            return function(darkMatter:DarkMatter):void {
                var currentRadius:Number = darkMatter.currentRadius;
                
                if (! darkMatter.isChangingRadius()) {
                    if (currentRadius <= 0) {
                        darkMatter.alive = false;
                        darkMatter.exists = false;
                        darkMatter.visible = false;
                        portal.alive = true;
                        portal.exists = true;
                        return;
                    }
                }
                
                var minDistancePlayer:Number = currentRadius + ((20 / 100) * currentRadius) + PlayState.player.width;
                darkMatterCentralPoint.x = darkMatter.x + darkMatter.origin.x;
                darkMatterCentralPoint.y = darkMatter.y + darkMatter.origin.y;
                
                playerCentralPoint.x = PlayState.player.x + PlayState.player.origin.x;
                playerCentralPoint.y = PlayState.player.y + PlayState.player.origin.y;
                
                var distanceFromPlayer:Number = FlxU.getDistance(
                    darkMatterCentralPoint, playerCentralPoint);
                
                if (distanceFromPlayer > minDistancePlayer) {
                    return;
                }
                var playerVelocity:Number;
                if (Math.abs(PlayState.player.velocity.x) > Math.abs(PlayState.player.velocity.y)) {
                    playerVelocity = PlayState.player.velocity.x;
                } else {
                    playerVelocity = PlayState.player.velocity.y;
                }
                darkMatter.radiusStep = 1.5 * Math.abs(playerVelocity);
                darkMatter.changeRadius(-1 * PlayState.player.width * 2);
                
                //TODO = this darkMatter will shrink as the player approaches
                //until the zero raidus is reached, so we end the game
            }
        }
        
        public function initDarkMatters():void {
            var position1:FlxPoint = darkMattersPositions[0];
            var darkMatter1:DarkMatter = new DarkMatter(position1.x, position1.y,
                darkMatter1Behavior(), 140);
            darkMatter1.changeRadius(100);
            
            darkMatters.add(darkMatter1);
        }
        
        public function initDarkMattersPosition():void {
            darkMattersPositions = new Array();
            var halfSize:Number = GameMap.TILE_SIZE / 2;
            
            //tileX = 20, tileY = 15 (the middle of the map)
            var position1:FlxPoint = new FlxPoint(20 * GameMap.TILE_SIZE + halfSize,
                15 * GameMap.TILE_SIZE + halfSize);
            darkMattersPositions.push(position1);
            
        }
        
    }

}