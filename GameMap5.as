package {

    import org.flixel.*;
    
    public class GameMap5 extends GameMap {
        
        public var numberOfDarkMatters:uint = 3;
        public var darkMattersPositions:Array;
        
        public var pathFinder:PathFinder;
        
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
            initArrayMap();
            initPathFinder();
        }
        
        override public function addGameMapElements():void {
            playState.add(this.map);
            playState.add(this.portal);
            playState.add(this.darkMatters);
        }
        
        public function initPathFinder():void {
            pathFinder = new PathFinder(this.arrayMap);
        }
        
        public function initArrayMap():void {
            this.arrayMap = [
                    [1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1],
                    [1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1],
                    [1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,1],
                    [1,0,0,0,0,0,0,1,0,0,1,1,0,0,0,0,0,0,0,0,0,0,0,0,1,1,0,0,0,0,0,0,1,1,0,0,0,0,0,1],
                    [1,0,0,0,0,0,0,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,1,0,0,0,0,0,0,1,1,0,0,0,0,1],
                    [1,0,0,0,0,0,0,1,1,0,0,0,1,0,0,0,0,0,0,0,0,0,0,1,1,1,1,0,0,0,0,0,0,0,1,0,0,0,0,1],
                    [1,0,0,0,0,0,0,1,1,0,0,1,1,1,0,0,0,0,0,0,0,0,1,1,1,1,1,1,0,0,0,0,0,0,1,1,1,0,0,1],
                    [1,0,1,1,1,1,1,1,1,0,0,0,1,0,0,0,0,0,0,0,0,0,1,1,1,1,1,1,0,0,0,0,0,0,0,0,1,1,1,1],
                    [1,0,0,0,0,0,0,1,1,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1],
                    [1,0,0,0,0,0,0,1,1,0,0,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1],
                    [1,1,1,1,1,1,0,1,1,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1],
                    [1,0,0,0,0,0,0,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1],
                    [1,0,0,0,0,0,0,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1],
                    [1,0,0,0,0,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,1,0,0,1,1,0,0,0,0,0,1],
                    [1,0,0,0,0,1,1,1,1,0,0,0,0,0,0,0,1,1,1,1,0,0,1,1,1,0,0,1,1,1,0,0,1,1,0,0,0,0,0,1],
                    [1,0,0,0,0,0,0,1,1,0,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1],
                    [1,0,0,0,0,0,0,1,1,0,1,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1],
                    [1,0,0,0,0,0,0,1,1,0,1,0,1,0,0,0,0,0,0,1,1,0,0,1,0,0,1,1,0,0,0,0,0,0,0,0,0,0,0,1],
                    [1,0,0,0,0,0,0,1,1,0,1,0,1,0,0,0,0,0,1,1,0,0,1,1,1,0,0,1,1,0,0,0,0,0,0,0,1,1,1,1],
                    [1,0,0,0,0,0,0,0,1,0,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1],
                    [1,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1],
                    [1,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,1],
                    [1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1],
                    [1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,1,0,0,0,0,0,0,0,0,0,0,0,1,1,0,0,0,0,0,0,0,1],
                    [1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,0,0,0,0,0,0,0,1],
                    [1,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,0,0,0,0,0,0,1],
                    [1,0,0,0,1,0,1,0,0,0,0,0,0,0,0,1,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,0,0,1,1,1,0,1],
                    [1,0,0,0,1,0,1,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,1],
                    [1,0,0,0,1,0,1,0,1,0,1,0,0,0,0,0,0,0,0,0,0,0,0,1,1,0,0,0,0,0,0,0,0,0,0,1,0,0,0,1],
                    [1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1]
            ];
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
        
        public function darkMatter1Behavior():Function {
            var darkMatterCurrentWayPoint:uint = 1;
            
            var darkMatterMaxX:Number = 208;
            var darkMatterMaxY:Number = 320;
            
            var darkMatterMinX:Number = 160;
            var darkMatterMinY:Number = 240;
            
            var maxRadius:Number = 40;
            
            return function(darkMatter:DarkMatter):void {
                var currentRadius:Number = darkMatter.currentRadius;
                
                if (! darkMatter.isChangingRadius()) {
                    if (currentRadius >= maxRadius) {
                        darkMatter.changeRadius(-1 * maxRadius);
                    } else {
                        darkMatter.changeRadius(maxRadius);
                    }
                }
                
                //the darkMatter  will dislocate around the blocks that surrounds
                //the portal, each way point is one of the corners of the rectangle
                
                //indicating the velocities according to each way point
                if (darkMatterCurrentWayPoint == 1) {
                    darkMatter.velocity.x = 20;
                    darkMatter.velocity.y = 0;
                } else if (darkMatterCurrentWayPoint == 2) {
                    darkMatter.velocity.y = 20;
                    darkMatter.velocity.x = 0;
                } else if (darkMatterCurrentWayPoint == 3) {
                    darkMatter.velocity.x = -20;
                    darkMatter.velocity.y = 0;
                } else if (darkMatterCurrentWayPoint == 0) {
                    darkMatter.velocity.y = -20;
                    darkMatter.velocity.x = 0;
                }
                
                var darkMatterXCenter:Number = darkMatter.x + darkMatter.origin.x;
                var darkMatterYCenter:Number = darkMatter.y + darkMatter.origin.y;
                
                if (darkMatterCurrentWayPoint == 1) {
                    if (darkMatterXCenter >= darkMatterMaxX) {
                        darkMatter.x = darkMatterMaxX - darkMatter.origin.x;
                        darkMatterCurrentWayPoint = 2;
                    }
                } else if (darkMatterCurrentWayPoint == 2) {
                    if (darkMatterYCenter >= darkMatterMaxY) {
                        darkMatter.y = darkMatterMaxY - darkMatter.origin.y;
                        darkMatterCurrentWayPoint = 3;
                    }
                } else if (darkMatterCurrentWayPoint == 3) {
                    if (darkMatterXCenter <= darkMatterMinX) {
                        darkMatter.x = darkMatterMinX - darkMatter.origin.x;
                        darkMatterCurrentWayPoint = 0;
                    }
                } else if (darkMatterCurrentWayPoint == 0) {
                    if (darkMatterYCenter <= darkMatterMinY) {
                        darkMatter.y = darkMatterMinY - darkMatter.origin.y;
                        darkMatterCurrentWayPoint = 1;
                    }
                }
                
            }
        }
        
        public function darkMatter2Behavior():Function {
            var wayPoints:Array = new Array();
            wayPoints.push(new FlxPoint(24, 2));
            wayPoints.push(new FlxPoint(3, 4));
            wayPoints.push(new FlxPoint(3, 20));
            wayPoints.push(new FlxPoint(17, 27));
            wayPoints.push(new FlxPoint(34, 18));
            wayPoints.push(new FlxPoint(36, 9));
            
            var numWayPoints:int = wayPoints.length;
            var currentPathId:uint = 0;
            var path:Array;
            var start:Object = new Object();
            var end:Object = new Object();
            var nextPoint:FlxPoint = new FlxPoint();
            var currentPoint:FlxPoint = new FlxPoint();
            
            var darkMatterVelocity:Number = 60;
            var maxRadius:Number = 40;
            
            return function(darkMatter:DarkMatter):void {
                
                if (! darkMatter.isChangingRadius()) {
                    if (darkMatter.currentRadius >= maxRadius) {
                        darkMatter.changeRadius(-1 * maxRadius);
                    } else {
                        darkMatter.changeRadius(maxRadius);
                    }
                }
                
                start.x = int((darkMatter.x + darkMatter.origin.x) / GameMap.TILE_SIZE);
                start.y = int((darkMatter.y + darkMatter.origin.y) / GameMap.TILE_SIZE);
                
                end.x = int(wayPoints[currentPathId].x);
                end.y = int(wayPoints[currentPathId].y);
                
                path = pathFinder.calcPath(start, end);
                //just one node in the path means that we are already
                //at the end node
                if (path.length == 1) {
                    darkMatter.velocity.x = 0;
                    darkMatter.velocity.y = 0;
                    if (currentPathId < numWayPoints - 1) {
                        currentPathId++;
                    } else {
                        currentPathId = 0;
                    }
                    return;
                }
                
                //removes the first because it's the actual node where the darkother is.
                path.splice(0, 1);
                
                var node:Object = path[0];
                //this is the point that the darkohter must reach
                nextPoint.x = node.x * GameMap.TILE_SIZE + (GameMap.TILE_SIZE / 2);
                nextPoint.y = node.y * GameMap.TILE_SIZE + (GameMap.TILE_SIZE / 2);
                    
                currentPoint.x = darkMatter.x + darkMatter.origin.x;
                currentPoint.y = darkMatter.y + darkMatter.origin.y;
                
                //calculate the angle difference and set the velocity according to it
                var angleRadians:Number = Math.atan2(nextPoint.y - currentPoint.y,
                    nextPoint.x - currentPoint.x);
                darkMatter.velocity.x = darkMatterVelocity * Math.cos(angleRadians);
                darkMatter.velocity.y = darkMatterVelocity * Math.sin(angleRadians);
                
            }
        }
        
        public function initDarkMatters():void {
            var position1:FlxPoint = darkMattersPositions[0];
            var darkMatter1:DarkMatter = new DarkMatter(position1.x, position1.y,
                darkMatter1Behavior());
            //darkMatter1.changeRadius(15);
            
            var position2:FlxPoint = darkMattersPositions[1];
            var darkMatter2:DarkMatter = new DarkMatter(position2.x, position2.y,
                darkMatter2Behavior());
            //darkMatter2.changeRadius(15);
            
            var position3:FlxPoint = darkMattersPositions[2];
            var darkMatter3:DarkMatter = new DarkMatter(position3.x, position3.y,
                function(darkMatter:DarkMatter):void{});
            //darkMatter3.changeRadius(15);
            
            darkMatters.add(darkMatter1);
            darkMatters.add(darkMatter2);
            darkMatters.add(darkMatter3);
            
        }
        
        public function initDarkMattersPosition():void {
            //these are starting positions as the darkmatters will move
            darkMattersPositions = new Array();
            
            var halfTileSize:Number = GameMap.TILE_SIZE / 2;
            
            //tileX = 10, tileY = 15
            var position1:FlxPoint = new FlxPoint(10 * GameMap.TILE_SIZE,
                15 * GameMap.TILE_SIZE);
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