package {
    
    import org.flixel.*;
    import org.flixel.plugin.photonstorm.*;
    
    public class GameMap4 extends GameMap {
        
        public const MAX_RAIDUS_DARKMATTER_1:int = 40;
        
        public var numberOfDarkMatters:uint = 2;
        public var darkMattersPositions:Array;
        
        public var key:Key;
        
        public var pushableBrick:PushableBrick;
        
        public function GameMap4(level:uint, playState:FlxState) {
            super(level, playState);
            init();
        }
        
        public function init():void {
            initDarkMattersPosition();
            initDarkMatters();
            initPushableBrick();
            initPortal();
            initInitialPlayerPosition();
            initKey();
        }
        
        override public function addGameMapElements():void {
            playState.add(this.map);
            playState.add(this.darkMatters);
            playState.add(this.portal);
            playState.add(this.pushableBrick);
            playState.add(this.key);
        }
        
        public function initPushableBrick():void {
            //position tileX = 25, tileY = 13
            this.pushableBrick = new PushableBrick(25 * GameMap.TILE_SIZE, 13 * GameMap.TILE_SIZE, this);
            this.mapColliders.add(this.pushableBrick);
        }
        
        public function initKey():void {
            //tileX = 19, tileY = 15
            this.key = new Key(18 * GameMap.TILE_SIZE + GameMap.HALF_TILE_SIZE,
                14 * GameMap.TILE_SIZE + GameMap.HALF_TILE_SIZE, this);
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
            /**
             *What the hell is that?
             *It's just a lista of radius sizes that the darkmatter will have while
             *shrinking. The sizes are relative to the MAX_RAIDUS_DARKMATTER_1.
            */
            var radiusSizes:Array = [
                1 * MAX_RAIDUS_DARKMATTER_1,
                .75 * MAX_RAIDUS_DARKMATTER_1,
                1 * MAX_RAIDUS_DARKMATTER_1,
                .50 * MAX_RAIDUS_DARKMATTER_1,
                .75 * MAX_RAIDUS_DARKMATTER_1,
                .25 * MAX_RAIDUS_DARKMATTER_1,
                .50 * MAX_RAIDUS_DARKMATTER_1,
                0 * MAX_RAIDUS_DARKMATTER_1,
                .25 * MAX_RAIDUS_DARKMATTER_1,
                0 * MAX_RAIDUS_DARKMATTER_1];
            /**
             *This var indicates at which size the darkmatter have or is going to have
            */
            var radiusSizeId:int = 0;
            
            return function(darkMatter:DarkMatter):void {
                var currentRadius:Number = darkMatter.currentRadius;
                
                //if the darkMatter collides with the pushableBrick
                if (FlxCollision.pixelPerfectCheck(darkMatter, pushableBrick)) {
                    //we will try to make the darkMatter shrink
                    //first we select a radiusSizeId that has a radius size smaller than
                    //the actual one
                    if (radiusSizeId != 9) {
                        var evenRadiusSizeId:Boolean = (radiusSizeId % 2) == 0;
                        //the even radiusSizeId are greater than the odd ones.
                        if (evenRadiusSizeId) {
                            radiusSizeId += 1;
                        } else {
                            radiusSizeId += 2;
                        }
                    }
                    _changeDarkMatterRadius(radiusSizes, radiusSizeId, currentRadius, darkMatter);
                    //darkMatter.changeRadius(darkMatter.previousRadius - currentRadius); --might work
                }
                
                if (Math.abs(currentRadius) == radiusSizes[radiusSizeId]) {
                    //the radius sizes goes from the largest size to the smallest one, 0
                    if (radiusSizeId < 9) {
                        radiusSizeId += 1;
                    } else {
                        radiusSizeId = 0;
                    }
                    if (Math.abs(currentRadius) == 0) {
                        //restore the darkmatter to it's original position
                        darkMatter.x = darkMattersPositions[0].x;
                        darkMatter.y = darkMattersPositions[0].y;
                    }
                }
                
                if (! darkMatter.isChangingRadius()) {
                    _changeDarkMatterRadius(radiusSizes, radiusSizeId, currentRadius, darkMatter);
                }
            }
        }
        
        public function _changeDarkMatterRadius(radiusSizes:Array, radiusSizeId:int,
            currentRadius:Number, darkMatter:DarkMatter):void {
            //radiusSizes[radiusSizeId] represents the next radius, it can be smaller
            //or greater than the currentRadius
            var amountToChange:Number = radiusSizes[radiusSizeId] - currentRadius;
            darkMatter.changeRadius(amountToChange);
            if (amountToChange < 0) {
                darkMatter.radiusStep = 40;
            } else {
                darkMatter.radiusStep = 40;
            }
        }
        
        public function darkMatter2Behavior():Function {
            var maxRadius:int = 40;
            
            //TODO implement this darkmatter
            return function(darkMatter:DarkMatter):void {
                var currentRadius:Number = darkMatter.currentRadius;
                
                if (FlxCollision.pixelPerfectCheck(darkMatter, pushableBrick)) {
                    darkMatter.changeRadius(-1 * currentRadius);
                }
                
                if (! darkMatter.isChangingRadius()) {
                    if (Math.abs(currentRadius) == maxRadius) {
                        darkMatter.changeRadius(-1 * maxRadius);
                    } else {
                        darkMatter.changeRadius(maxRadius);
                    }
                    if (Math.abs(currentRadius) == 0) {
                        //restoring the original position
                        darkMatter.x = darkMattersPositions[1].x;
                        darkMatter.y = darkMattersPositions[1].y;
                    }
                }
                
                if (darkMatter.isShrinking()) {
                    darkMatter.radiusStep = 60;
                } else {
                    darkMatter.radiusStep = 40;
                }
                
            }
        }
        
        public function initDarkMatters():void {
            var position1:FlxPoint = darkMattersPositions[0];
            var darkMatter1:DarkMatter = new DarkMatter(position1.x, position1.y,
                darkMatter1Behavior(), 10);
            
            var position2:FlxPoint = darkMattersPositions[1];
            var darkMatter2:DarkMatter = new DarkMatter(position2.x, position2.y,
                darkMatter2Behavior(), 40);
            
            darkMatters.add(darkMatter1)
            darkMatters.add(darkMatter2);
        }
        
        public function initDarkMattersPosition():void {
            darkMattersPositions = new Array();
            
            var halfTileSize:Number = GameMap.TILE_SIZE / 2;
            
            //tileX = 17, tileY = 13
            var position1:FlxPoint = new FlxPoint(17 * GameMap.TILE_SIZE + halfTileSize,
                13 * GameMap.TILE_SIZE + halfTileSize);
            darkMattersPositions.push(position1);
            
            //tileX = 20, tileY = 16
            var position2:FlxPoint = new FlxPoint(20 * GameMap.TILE_SIZE + halfTileSize,
                16 * GameMap.TILE_SIZE + halfTileSize);
            darkMattersPositions.push(position2);
            
        }
        
    }

}