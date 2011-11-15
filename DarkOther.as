package {
    
    import org.flixel.*;
    import flash.utils.ByteArray;
    
    public class DarkOther extends FlxSprite {
        
        public static const NORMAL_MAX_VELOCITY:int = 90;
        public static const BOOST_MAX_VELOCITY:int = 130;
        public static const ACCELERATION:int = 150;
        public static const MIN_PLAYER_DISTANCE:Number = 55;
        public static const INTERVAL_BETWEEN_STEPS_SOUND:Number = .25;
        
        [Embed(source="data/gfx/darkother_sprites.png")]
        private var imgDarkOther:Class;
        
        [Embed(source="data/sfx/steps1.mp3")]
        private var mp3Steps:Class;
        
        /**
         *These are the tiles locations where the DarkOther must pass. The DarkOther
         *will as well wait at these locations for the player.
        */
        public var wayPoints:Array;
        
        public var pathFinder:PathFinder;
        
        /**
         *This is the grid sent by the GameMap class. This grid contains the
         *representation of the game scenario. With it we now wich tiles are walkable
         *or unwalkable.
        */
        public var _originalGrid:Array;
        /**
         *This is the grid that we alter to reflect the unwalkable tiles that are near
         *the player. Because the player can move any time we update this grid to reflect
         *player's current position.
        */
        public var _alteredGrid:Array;
        
        /**
         *We use this var to store the current way point where the darkother is.
         *It's zero based.
        */
        public var currentWayPoint:int;
        
        /**
         *Helper vars.
        */
        public var _darkOtherPosition:FlxPoint;
        public var _playerPosition:FlxPoint;
        public var _nextPoint:FlxPoint;
        public var _nextWayPoint:FlxPoint;
        
        /**
         *The current path that the darkother must follow.
        */
        public var _path:Array;
        
        public var maxVelocityValue:int;
        
        /**
         *If true the darkother hasn't reached the end of the path, otherwise...
        */
        public var itsOver:Boolean;
        
        public var lastTimePlayedStep:Number = 0;
        public var currentTime:Number = 0;
        
        
        public function DarkOther(x:Number, y:Number, grid:Array) {
            super(x, y);
            _originalGrid = grid;
            _copyOriginalGrid();
            //makeGraphic(10,12,0x22bb1111);
            loadGraphic(imgDarkOther, true, true, 10, 12);
            addAnimation("idle", [4], 0, false);
            addAnimation("walk", [0, 1, 2, 3], 10, true);
            maxVelocityValue = NORMAL_MAX_VELOCITY;
            maxVelocity.x = maxVelocityValue;
            maxVelocity.y = maxVelocityValue;
            initWayPoints();
            initPathFinder();
            
            _darkOtherPosition = new FlxPoint();
            _playerPosition = new FlxPoint();
            _nextPoint = new FlxPoint();
            _nextWayPoint = new FlxPoint();
            
            _path = new Array();
        }
        
        public function _printAlteredGrid(theGrid:Array):void {
            trace('begin==========================');
            var numLines:int = theGrid.length;
            var numColumns:int = theGrid[0].length;
            var line:String = '';
            for(var i:int = 0; i < numLines; i++) {
                for(var j:int = 0; j < numColumns; j++) {
                    line += theGrid[i][j];
                }
                trace(line);
                line = '';
            }
            trace('end==========================');
        }
        
        public function _copyOriginalGrid():void {
            _alteredGrid = null;
            var cloner:ByteArray = new ByteArray();
            cloner.writeObject(_originalGrid);
            cloner.position = 0;
            _alteredGrid = cloner.readObject() as Array;
        }
        
        public function initPathFinder():void {
            pathFinder = new PathFinder(_alteredGrid);
        }
        
        public function initWayPoints():void {
            wayPoints = new Array();
            //the way
            wayPoints.push(new FlxPoint(34, 12));
            wayPoints.push(new FlxPoint(30, 18));
            wayPoints.push(new FlxPoint(25, 14));
            wayPoints.push(new FlxPoint(10, 11));
            wayPoints.push(new FlxPoint(4, 19));
            wayPoints.push(new FlxPoint(2, 23));
            wayPoints.push(new FlxPoint(19, 23));
            wayPoints.push(new FlxPoint(31, 24));
            wayPoints.push(new FlxPoint(38, 28));
            currentWayPoint = 0;
            itsOver = false;
        }
        
        public function isPlayerTooClose():Boolean {
            //here we consider the center of the sprite
            _darkOtherPosition.x = x + origin.x;
            _darkOtherPosition.y = y + origin.y;
            
            _playerPosition.x = PlayState.player.x + PlayState.player.origin.x;
            _playerPosition.y = PlayState.player.y + PlayState.player.origin.y;
            
            return FlxU.getDistance(_darkOtherPosition, _playerPosition) <= MIN_PLAYER_DISTANCE;
            
        }
        
        public function _calcPlayerTileX(playerX:Number, tileWidth:int):int {
            return Math.floor(playerX / tileWidth);
        }
        
        public function _calcPlayerTileY(playerY:Number, tileHeight:int):int {
            return Math.floor(playerY / tileHeight);
        }
        
        public function _calcTileX(x:Number, tileWidth:int):int {
            return Math.floor(x / tileWidth);
        }
        
        public function _calcTileY(y:Number, tileHeight:int):int {
            return Math.floor(y / tileHeight);
        }
        
        public function _updateGrid():void {
            _copyOriginalGrid();
            
            var playerCenterX:Number = PlayState.player.x + PlayState.player.origin.x;
            var playerCenterY:Number = PlayState.player.y + PlayState.player.origin.y;
            
            var playerTileX:int = _calcPlayerTileX(playerCenterX, GameMap.TILE_SIZE);
            var playerTileY:int = _calcPlayerTileY(playerCenterY, GameMap.TILE_SIZE);
            
            var colList:Array = [0];
            var rowList:Array = [0];
            
            //we expect this to always be 1
            var numNodes:int = colList.length;
            for(var i:int = 0; i < numNodes; i++) {
                var yPosition:int = playerTileY + rowList[i];
                if ((_alteredGrid[yPosition] == undefined) || (_alteredGrid[yPosition] == null)) {
                    //it means that this position is out of the screen so we don't need do update
                    continue;
                }
                var xPosition:int = playerTileX + colList[i];
                //here we mark this spot as unwalkable that can be any postion around the player and
                //the player's own position, by the way they are the tile positions
                _alteredGrid[yPosition][xPosition] = 1;
            }
        }
        
        public function _stop():void {
            velocity.x = 0;
            velocity.y = 0;
        }
        
        public function _move():void {
            //no path to move
            if (_path.length == 0) {
                _stop();
                return;
            }
            
            //just one node in the path, so we are already at this node
            if (_path.length == 1) {
                _path.splice(0, 1);
                _stop();
                return;
            }
            
            //removes the first because it's the actual node where the darkother is.
            _path.splice(0, 1);
            
            var node:Object = _path[0];
            //this is the point that the darkohter must reach
            _nextPoint.x = node.x * GameMap.TILE_SIZE + (GameMap.TILE_SIZE / 2);
            _nextPoint.y = node.y * GameMap.TILE_SIZE + (GameMap.TILE_SIZE / 2);
                
            _darkOtherPosition.x = x + origin.x;
            _darkOtherPosition.y = y + origin.y;
            
            //calculate the angle difference and set the velocity according to it
            var angleRadians:Number = Math.atan2(_nextPoint.y - _darkOtherPosition.y,
                _nextPoint.x - _darkOtherPosition.x);
            velocity.x = maxVelocityValue * Math.cos(angleRadians);
            velocity.y = maxVelocityValue * Math.sin(angleRadians);
            
        }
        
        public function _updateCurrentWayPoint():void {
            var numWayPoints:int = wayPoints.length;
            if (currentWayPoint < numWayPoints - 1) {
                currentWayPoint += 1;
            } else {
                //the penultimate wayPoint
                currentWayPoint = numWayPoints - 2;
            }
        }
        
        public function _getNextWayPoint():FlxPoint {
            _updateGrid();
            //let's take the first way point that is walkable
            do {
                //_printAlteredGrid();
                _updateCurrentWayPoint();
                var nextWayPoint:FlxPoint = wayPoints[currentWayPoint];
                var nextWayPointX:int = int(nextWayPoint.x);
                var nextWayPointY:int = int(nextWayPoint.y);
                
            } while(_alteredGrid[nextWayPointY][nextWayPointX] == 1);
            
            return nextWayPoint;
        }
        
        public function _calcPath():void {
            var nextWayPointPosition:Object = {x : int(_nextWayPoint.x), y : int(_nextWayPoint.y)};
            
            //creating the path
            pathFinder.grid = _alteredGrid;
            var tileX:int = _calcTileX(x + origin.x, GameMap.TILE_SIZE);
            var tileY:int = _calcTileY(y + origin.y, GameMap.TILE_SIZE);
            var darkOtherPosition:Object = {x : tileX, y : tileY};
            
            _path = pathFinder.calcPath(darkOtherPosition, nextWayPointPosition);
        }
        
        override public function update():void {
            super.update();
            
            if ((velocity.x != 0) || (velocity.y != 0)) {
                play("walk");
            } else {
                play("idle");
            }
            
            if ((velocity.x != 0) || (velocity.y != 0)) {
                currentTime += FlxG.elapsed;
                if ((currentTime - lastTimePlayedStep) >= INTERVAL_BETWEEN_STEPS_SOUND) {
                    FlxG.play(mp3Steps, .8, false);
                    lastTimePlayedStep = currentTime;
                }
            } else {
                currentTime += FlxG.elapsed;
                lastTimePlayedStep = currentTime;
            }
            
            if (velocity.x > 0) {
                facing = RIGHT;
            } else if (velocity.x < 0) {
                facing = LEFT;
            }
            
            _updateGrid();
            FlxG.collide(this, PlayState.player);
            
            if (_path.length > 0) {
                _calcPath();
                //if the player is too close we "boost" the darkother
                if (isPlayerTooClose()) {
                    maxVelocityValue = BOOST_MAX_VELOCITY;
                } else {
                    maxVelocityValue = NORMAL_MAX_VELOCITY;
                }
                _move();
                return;
            }
            
            //we reached the last way point
            if (currentWayPoint == 8) {
                itsOver = true;
                kill();
            }
            
            if (! isPlayerTooClose()) {
                return;
            }
            
            _nextWayPoint = _getNextWayPoint();
            _calcPath();
            _move();
            
        }
        
    }
    
}