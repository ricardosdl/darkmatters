package {
    
    import org.flixel.*;
    
    public class GameMap1 extends GameMap {
        
        public var numberOfDarkMatters:uint = 2;
        public var darkMattersPositions:Array;
        
        public function GameMap1(level:uint) {
            super(level);
            init();
        }
        
        public function init():void {
            initDarkMattersPositions();
            initDarkMatters();
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
            var currentTime:Number = 0;
            var lastTime:Number = 0;
            
            return function(darkMatter:DarkMatter):void {
                var timeToGrow:Boolean = currentTime > lastTime + 15;
                if (timeToGrow) {
                    darkMatter.changeRadius(10);
                    lastTime = currentTime;
                    return;
                }
                currentTime += FlxG.elapsed;
            }
        }
        
        public function darkMatter1Behavior():Function {
            var currentTime:Number = 0;
            var lastTime:Number = 0;
            
            return function(darkMatter:DarkMatter):void {
                var justPassedTenSeconds:Boolean = currentTime > lastTime + 10;
                if (justPassedTenSeconds) {
                    darkMatter.changeRadius(10);
                    lastTime = currentTime;
                    return;
                }
                currentTime += FlxG.elapsed;
            }
        }
        
        public function initDarkMatters():void {
            var position1:FlxPoint = darkMattersPositions[0];
            var darkMatter1:DarkMatter = new DarkMatter(position1.x, position1.y,
                darkMatter1Behavior(), 10);
            
            darkMatters.add(darkMatter1);
            
            var position2:FlxPoint = darkMattersPositions[1];
            var darkMatter2:DarkMatter = new DarkMatter(position2.x, position2.y,
                darkMatter2Behavior(), 10);
            
            darkMatters.add(darkMatter2);
            
        }
        
        public function initDarkMattersPositions():void {
            //upper right corner
            var position1:FlxPoint = new FlxPoint(320, 0);
            //
            var position2:FlxPoint = new FlxPoint(FlxG.width / 2, FlxG.height / 2);
            darkMattersPositions = new Array();
            darkMattersPositions.push(position1);
            darkMattersPositions.push(position2);
            
        }
        
    }
    
}