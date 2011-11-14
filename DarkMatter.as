package {
    
    import org.flixel.*;
    import flash.display.Sprite;
    import flash.display.Graphics;
    import flash.display.BitmapData;
    import flash.geom.Matrix;
    
    public class DarkMatter extends FlxSprite {
        
        public static const MAX_RADIUS:uint = 50;
        public static const MIN_RAIDUS:uint = 1;
        
        [Embed(source="data/sfx/darkMatterGrow3.mp3")]
        private var mp3DarkMatterGrow:Class;
        
        public var currentRadius:Number = 0;
        
        /**
         *The amount of pixels per second that the darkmatter increate it's radius
        */
        public var radiusStep:Number;
        /**
         *The current increase of the current frame it's used to draw the dark matter.
        */
        public var _currentRadiusStep:Number;
        /**
         *The amount to add or subtract(in this case a negative amount) from the radius.
        */
        public var _amountToChangeRadius:Number;
        /**
         *Determinates the radius that the dark matter must have.
        */
        public var _nextRadius:Number;
        
        public var spriteCircle:Sprite;
        
        public var matrix:Matrix;
        
        public var originalPosition:FlxPoint;
        
        public var _darkMatterBehavior:Function;
        
        public var _darkMatterGrowSound:FlxSound;
        
        public var _isGameOverDarkMatter:Boolean = false;
        
        public function DarkMatter(x:Number, y:Number,
            darkMatterBehavior:Function, radiusStep:Number = 10):void {
            
            super(x, y);
            originalPosition = new FlxPoint(x, y);
            this.radiusStep = radiusStep;
            _darkMatterBehavior = darkMatterBehavior;
            _nextRadius = currentRadius;
            spriteCircle = new Sprite();
            matrix = new Matrix();
            clearCircle();
            _initGrowSound();
        }
        
        public function _initGrowSound():void {
            _darkMatterGrowSound = new FlxSound();
            _darkMatterGrowSound.loadEmbedded(mp3DarkMatterGrow);
        }
        
        public function isChangingRadius():Boolean {
            return _nextRadius != currentRadius;
        }
        
        public function changeRadius(amountToChangeRadius:Number):void {
            _amountToChangeRadius = amountToChangeRadius;
            _nextRadius = currentRadius + _amountToChangeRadius;
            if (_nextRadius <= 0) {
                _nextRadius = 0;
            }
            //trace("_nextRadius:" + _nextRadius);
            //trace("_currentRadius:" + _currentRadius);
        }
        
        public function clearCircle():void {
            makeGraphic(1, 1, 0x00000000);
        }
        
        public function drawCircle():void {
            spriteCircle.graphics.clear();
            spriteCircle.graphics.beginFill(0x000000);
            spriteCircle.graphics.drawCircle(0, 0, currentRadius);
            spriteCircle.graphics.endFill();
            var bitmapDataCircle:BitmapData = new BitmapData(spriteCircle.width, spriteCircle.height, true, 0x00000000);
            matrix.identity();
            matrix.translate(currentRadius, currentRadius);
            bitmapDataCircle.draw(spriteCircle, matrix);
            _pixels = bitmapDataCircle;
            width = frameWidth = _pixels.width;
            height = frameHeight = _pixels.height;
            resetHelpers();
            x = x - _currentRadiusStep;
            y = y - _currentRadiusStep;
        }
        
        public function calcCurrentRadiusStep(amountToChangeRadius:Number):Number {
            if (_amountToChangeRadius < 0) {
                return radiusStep * FlxG.elapsed * -1;
            }
            return radiusStep * FlxG.elapsed;
        }
        
        /**
         *Tells if the darkMatter is shrinking.
        */
        public function isShrinking():Boolean {
            return _nextRadius < currentRadius;
        }
        
        public function _playDarkMatterGrowSound():void {
            if (_isGameOverDarkMatter) {
                return;
            }
            _darkMatterGrowSound.play();
        }
        
        public function stopDarkMatterGrowSound():void {
            _darkMatterGrowSound.stop();
        }
        
        override public function update():void {
            _darkMatterBehavior(this);
            if (isChangingRadius()) {
                _currentRadiusStep = calcCurrentRadiusStep(_amountToChangeRadius);
                currentRadius += _currentRadiusStep;
                
                if ((_currentRadiusStep < 0) && (currentRadius <= _nextRadius)) {
                    currentRadius = _nextRadius;
                } else if ((_currentRadiusStep > 0) && (currentRadius >= _nextRadius)) {
                    currentRadius = _nextRadius;
                }
                
                if (currentRadius < 1) {
                    clearCircle();
                } else {
                    drawCircle();
                }
            }
            
            if ((isChangingRadius()) && (_currentRadiusStep > 0)) {
                _playDarkMatterGrowSound();
            } else {
                stopDarkMatterGrowSound();
            }
            
            super.update();
        }
        
    }
    
}