package {
    
    import org.flixel.*;
    import flash.display.Sprite;
    import flash.display.Graphics;
    import flash.display.BitmapData;
    import flash.geom.Matrix;
    
    public class DarkMatter extends FlxSprite {
        
        public static const MAX_RADIUS:uint = 50;
        public static const MIN_RAIDUS:uint = 1;
        
        public var radius:Number = MIN_RAIDUS;
        
        public var spriteCircle:Sprite;
        
        public var matrix:Matrix;
        
        public var originalPosition:FlxPoint;
        
        public function DarkMatter(x:Number, y:Number):void {
            super(x, y);
            originalPosition = new FlxPoint(x, y);
            spriteCircle = new Sprite();
            matrix = new Matrix();
        }
        
        public function clearCircle():void {
            makeGraphic(1, 1, 0x00ffffff);
        }
        
        public function drawCircle():void {
            spriteCircle.graphics.clear();
            spriteCircle.graphics.beginFill(0x00FF00);
            spriteCircle.graphics.drawCircle(0, 0, radius);
            spriteCircle.graphics.endFill();
            var bitmapDataCircle:BitmapData = new BitmapData(spriteCircle.width, spriteCircle.height, true, 0x00000000);
            matrix.identity();
            //matrix.translate(x - (spriteCircle.width / 2), y - (spriteCircle.height / 2));
            trace("sprite w:" + spriteCircle.width);
            trace("sprite h:" + spriteCircle.height);
            matrix.translate(radius, radius);
            bitmapDataCircle.draw(spriteCircle, matrix);
            //bitmapDataCircle.draw(spriteCircle);
            _pixels = bitmapDataCircle;
            width = frameWidth = _pixels.width;
            height = frameHeight = _pixels.height;
            resetHelpers();
            trace('x before:' + x);
            trace('y before:' + y);
            x = x - .3;
            y = y - .3;
            trace('x after:' + x);
            trace('y after:' + y);
        }
        
        override public function update():void {
            drawCircle();
            //trace("dark matter x:" + x);
            //trace("dark matter y:" + y);
            radius += .3;
            if (radius > MAX_RADIUS) {
                radius = MIN_RAIDUS;
                clearCircle();
                x = originalPosition.x;
                y = originalPosition.y;
            }
            
            super.update();
        }
        
    }
    
}