package {
    
    import org.flixel.*;
    import hipercodigo.util.RandomInterval;
    
    public class GameMap2 extends GameMap {
        
        public var numberOfDarkMatters:uint = 2;
        public var darkMatterPositions:Array;
        
        public function GameMap2(level:uint, playState:FlxState) {
            super(level, playState);
            initDarkMatterPositions();
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
            //poistion is tileX = 18 and tileY = 1
            this.initialPlayerPosition = new FlxPoint(18 * GameMap.TILE_SIZE, 1 * GameMap.TILE_SIZE);
        }
        
        public function initPortal():void {
            //always tileY = 29 and tileX = 17
            var portalPosition:FlxPoint = new FlxPoint();
            portalPosition.y = 28 * GameMap.TILE_SIZE;
            portalPosition.x = 16 * GameMap.TILE_SIZE;
            
            this.portal = new FlxSprite(portalPosition.x, portalPosition.y, this.pngPortal);
            this.playState.add(this.portal);
        }
        
        public function initDarkMatters():void {
            var position1:FlxPoint = darkMatterPositions[0];
            var darkMatter1:DarkMatter = new DarkMatter(position1.x, position1.y,
                darkMatter1Behavior(), 15);
            
            darkMatters.add(darkMatter1);
            
            var darkMatter2:DarkMatter = new DarkMatter(0, 0, darkMatter2Behavior());
            
            darkMatters.add(darkMatter2);
            
        }
        
        public function generateDarkMatterPosition(player:FlxSprite, darkMatterRadius:Number):FlxPoint {
            var playerXVelocity:Number = player.velocity.x;
            var playerYVelocity:Number = player.velocity.y;
            
            var direction:String = '';
            if ((playerXVelocity <= 0) && (playerYVelocity <= 0)) {
                direction = 'topLeft';
            } else if ((playerXVelocity > 0) && (playerYVelocity <= 0)) {
                direction = 'topRight';
            } else if ((playerXVelocity > 0) && (playerYVelocity > 0)) {
                direction = 'bottomRight';
            } else if ((playerXVelocity <= 0) && (playerYVelocity > 0)) {
                direction = 'bottomLeft';
            }
            
            //this the min distance that the full grown darkMatter will have from the player
            var minDistanceFromDarkMatterBorder:Number = GameMap.TILE_SIZE / 2;
            
            var xDarkMatter:Number;
            var yDarkMatter:Number;
            
            switch(direction) {
                case 'topLeft':
                    xDarkMatter = (player.x + player.origin.x) - minDistanceFromDarkMatterBorder - darkMatterRadius;
                    yDarkMatter = (player.y + player.origin.y) - minDistanceFromDarkMatterBorder - darkMatterRadius;
                    break;
                case 'topRight':
                    xDarkMatter = (player.x + player.origin.x) + minDistanceFromDarkMatterBorder + darkMatterRadius;
                    yDarkMatter = (player.y + player.origin.y) - minDistanceFromDarkMatterBorder - darkMatterRadius;
                    break;
                case 'bottomRight':
                    xDarkMatter = (player.x + player.origin.x) + minDistanceFromDarkMatterBorder + darkMatterRadius;
                    yDarkMatter = (player.y + player.origin.y) + minDistanceFromDarkMatterBorder + darkMatterRadius;
                    break;
                case 'bottomLeft':
                    trace('bottom left');
                    xDarkMatter = (player.x + player.origin.x) - minDistanceFromDarkMatterBorder - darkMatterRadius;
                    yDarkMatter = (player.y + player.origin.y) + minDistanceFromDarkMatterBorder + darkMatterRadius;
                    break;
            }
            
            trace('player origing x:' + player.origin.x);
            trace('player origing y:' + player.origin.y);
            trace('min distance:' + minDistanceFromDarkMatterBorder);
            trace('darMatterRadius:' + darkMatterRadius);
            
            return new FlxPoint(xDarkMatter, yDarkMatter);
            
        }
        
        public function darkMatter2Behavior():Function {
            var waitTime:Number = RandomInterval.randomInterval(1, 4, true);
            var currentTime:Number = 0;
            var lastTime:Number = 0;
            var timeToGrow:Boolean;
            var expanding:Boolean;
            
            return function(darkMatter:DarkMatter):void {
                //trace('called behavior');
                //if the darkMatter is changing the radius either expanding or shrinking
                //we wait
                if (darkMatter.isChangingRadius()) {
                    //we must update the currentTime
                    currentTime += FlxG.elapsed;
                    lastTime = currentTime;
                    //trace('currentTime:' + currentTime);
                    //trace('lastTime:' + lastTime);
                    return;
                } else {
                    //if the darkMatter was expanding, we need to tell it to shrink
                    if (expanding) {
                        darkMatter.changeRadius(-1 * darkMatter.currentRadius);
                        expanding = false;
                        //we must update the currentTime
                        currentTime += FlxG.elapsed;
                        lastTime = currentTime;
                        return;
                    }
                    
                    //here we check if it's time to tell the darkMatter to grow(expanding = true)
                    timeToGrow = currentTime > lastTime + waitTime;
                    //trace('timeToGrow:' + timeToGrow);
                }
                
                if (timeToGrow) {
                    trace('grow motherfucker');
                    _changeDarkMatterRadius(darkMatter);
                    //new waitTime!
                    waitTime = RandomInterval.randomInterval(1, 4, true);
                    expanding = true;
                    //we must update the currentTime
                    currentTime += FlxG.elapsed;
                    lastTime = currentTime;
                    return;
                }
                currentTime += FlxG.elapsed;
                
            }
        }
        
        public function _changeDarkMatterRadius(darkMatter:DarkMatter):void {
            
            var darkMatterRadius:Number = RandomInterval.randomInterval(10, 100);
            darkMatter.radiusStep = darkMatterRadius / 2;
            var darkMatterPosition:FlxPoint = generateDarkMatterPosition(PlayState.player,
                darkMatterRadius);
            trace('darMatter position x:' + darkMatterPosition.x);
            trace('darMatter position y:' + darkMatterPosition.y);
            darkMatter.x = darkMatterPosition.x;
            darkMatter.y = darkMatterPosition.y;
            darkMatter.changeRadius(darkMatterRadius);
        }
        
        public function darkMatter1Behavior():Function {
            var currentTime:Number = 0;
            var lastTime:Number = 0;
            
            return function(darkMatter:DarkMatter):void {
                var timeToGrow:Boolean = currentTime > lastTime + 5;
                if (timeToGrow) {
                    darkMatter.changeRadius(25);
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