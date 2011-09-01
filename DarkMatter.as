package {
    
    import org.flixel.*;
    import flash.display.Sprite;
    import flash.display.Graphics;
    import flash.display.BitmapData;
    import flash.geom.Matrix;
    
    public class DarkMatter extends FlxSprite {
        
        public static const MAX_RADIUS:uint = 50;
        public static const MIN_RAIDUS:uint = 1;
        
        public var _radius:Number = MIN_RAIDUS;
        
        /**
         *The amount of pixels per second that the darkmatter increate it's radius
        */
        public var _radiusStep:Number;
        /**
         *The current increase of the current frame it's used to draw the dark matter.
        */
        public var _currentRadiusStep:Number;
        
        public var spriteCircle:Sprite;
        
        public var matrix:Matrix;
        
        public var originalPosition:FlxPoint;
        
        public function DarkMatter(x:Number, y:Number, radiusStep:Number = 10):void {
            super(x, y);
            originalPosition = new FlxPoint(x, y);
            _radiusStep = radiusStep;
            spriteCircle = new Sprite();
            matrix = new Matrix();
        }
        
        public function clearCircle():void {
            makeGraphic(1, 1, 0x00000000);
        }
        
        public function drawCircle():void {
            spriteCircle.graphics.clear();
            spriteCircle.graphics.beginFill(0x00FF00);
            spriteCircle.graphics.drawCircle(0, 0, _radius);
            spriteCircle.graphics.endFill();
            var bitmapDataCircle:BitmapData = new BitmapData(spriteCircle.width, spriteCircle.height, true, 0x00000000);
            matrix.identity();
            matrix.translate(_radius, _radius);
            bitmapDataCircle.draw(spriteCircle, matrix);
            _pixels = bitmapDataCircle;
            width = frameWidth = _pixels.width;
            height = frameHeight = _pixels.height;
            resetHelpers();
            x = x - _currentRadiusStep;
            y = y - _currentRadiusStep;
        }
        
        override public function update():void {
            _currentRadiusStep = _radiusStep * FlxG.elapsed;
            _radius += _currentRadiusStep;
            drawCircle();
            if (_radius > MAX_RADIUS) {
                _radius = MIN_RAIDUS;
                clearCircle();
                x = originalPosition.x;
                y = originalPosition.y;
            }
            
            super.update();
        }
        
    }
    
}