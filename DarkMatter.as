package {
    
    import org.flixel.*;
    import flash.display.Sprite;
    import flash.display.Graphics;
    import flash.display.BitmapData;
    import flash.geom.Matrix;
    
    public class DarkMatter extends FlxSprite {
        
        public static const MAX_RADIUS:uint = 50;
        public static const MIN_RAIDUS:uint = 1;
        
        public var _currentRadius:Number = 0;
        
        /**
         *The amount of pixels per second that the darkmatter increate it's radius
        */
        public var _radiusStep:Number;
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
        
        public function DarkMatter(x:Number, y:Number, radiusStep:Number = 10):void {
            super(x, y);
            originalPosition = new FlxPoint(x, y);
            _radiusStep = radiusStep;
            _nextRadius = _currentRadius;
            spriteCircle = new Sprite();
            matrix = new Matrix();
            clearCircle();
        }
        
        public function isChangingRadius():Boolean {
            return _nextRadius != _currentRadius;
        }
        
        public function changeRadius(amountToChangeRadius:Number):void {
            _amountToChangeRadius = amountToChangeRadius;
            _nextRadius = _currentRadius + _amountToChangeRadius;
            if (_nextRadius <= 0) {
                _nextRadius = 0;
            }
            trace("_nextRadius:" + _nextRadius);
            trace("_currentRadius:" + _currentRadius);
        }
        
        public function clearCircle():void {
            makeGraphic(1, 1, 0x00000000);
        }
        
        public function drawCircle():void {
            spriteCircle.graphics.clear();
            spriteCircle.graphics.beginFill(0x00FF00);
            spriteCircle.graphics.drawCircle(0, 0, _currentRadius);
            spriteCircle.graphics.endFill();
            var bitmapDataCircle:BitmapData = new BitmapData(spriteCircle.width, spriteCircle.height, true, 0x00000000);
            matrix.identity();
            matrix.translate(_currentRadius, _currentRadius);
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
                return _radiusStep * FlxG.elapsed * -1;
            }
            return _radiusStep * FlxG.elapsed;
        }
        
        override public function update():void {
            if (isChangingRadius()) {
                _currentRadiusStep = calcCurrentRadiusStep(_amountToChangeRadius);
                _currentRadius += _currentRadiusStep;
                
                if ((_currentRadiusStep < 0) && (_currentRadius <= _nextRadius)) {
                    _currentRadius = _nextRadius;
                } else if ((_currentRadiusStep > 0) && (_currentRadius >= _nextRadius)) {
                    _currentRadius = _nextRadius;
                }
                
                if (_currentRadius < 1) {
                    clearCircle();
                } else {
                    drawCircle();
                }
            }
            super.update();
        }
        
    }
    
}