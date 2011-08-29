package {
    
    import org.flixel.*;
    import flash.display.Sprite;
    import flash.display.Graphics;
    import flash.display.BitmapData;
    
    public class DarkMatter extends FlxSprite {
        
        public static const MAX_RADIUS:uint = 50;
        public static const MIN_RAIDUS:uint = 1;
        
        public var radius:uint = MIN_RAIDUS;
        
        public function DarkMatter(x:Number, y:Number):void {
            super(x, y);
        }
        
        public function drawCircle():void {
            var spriteCircle:Sprite = new Sprite();
            spriteCircle.graphics.beginFill(0x00FF00);
            spriteCircle.graphics.drawCircle(0, 0, radius);
            spriteCircle.graphics.endFill();
            trace("width:" + spriteCircle.width);
            trace("height:" + spriteCircle.height);
            var bitmapDataCircle:BitmapData = new BitmapData(spriteCircle.width, spriteCircle.height, true, 0x00000000);
            bitmapDataCircle.draw(spriteCircle);
            _pixels = bitmapDataCircle;
            width = frameWidth = _pixels.width;
            height = frameHeight = _pixels.height;
            resetHelpers();
        }
        
        override public function update():void {
            radius += 1;
            if (radius > MAX_RADIUS) {
                radius = MIN_RAIDUS;
            }
            drawCircle();
            super.update();
        }
        
    }
    
}