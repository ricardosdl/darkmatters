package {
    
    import org.flixel.*;
    
    public class CreditsState extends FlxState {
        
        public var backButtonArea:FlxRect;
        public var backgroundBackButton:FlxSprite;
        public var txtBackButton:FlxText;
        
        override public function create():void {
            var xTitle:Number = 5;
            var yTitle:Number = 1;
            var txtTitle:FlxText = new FlxText(xTitle, yTitle, 160, "CREDITS");
            txtTitle.size = 20;
            txtTitle.alignment = 'center';
            add(txtTitle);
            
            var txtDesign:FlxText = new FlxText(5, 25, 160, "Design and Programming:");
            txtDesign.alignment = "center";
            add(txtDesign);
            
            var txtMyName:FlxText = new FlxText(5, 34, 160, "Ricardo Soares de Lima");
            txtMyName.alignment = "center";
            add(txtMyName);
            
            var txtEndOfGameSound:FlxText = new FlxText(0, 52, 160, "angels 2.wav");
            txtEndOfGameSound.alignment = "center";
            add(txtEndOfGameSound);
            
            var txtMusicAuthor:FlxText = new FlxText(0, 62, 160, "by ERH:freesound.org/people/ERH/sounds/29758");
            txtMusicAuthor.alignment = "center";
            add(txtMusicAuthor);
            
            var xBackButton:Number = 160 - 90;
            var yBackButton:Number = 100;
            
            backgroundBackButton = new FlxSprite(xBackButton, yBackButton + 1).makeGraphic(150, 11, 0xffe06000);
            backgroundBackButton.visible = false;
            
            txtBackButton = new FlxText(xBackButton, yBackButton, 160, "BACK");
            txtBackButton.shadow = 0xff000000;
            
            backButtonArea = new FlxRect(xBackButton, yBackButton, 160, yBackButton - 90);
            
            add(backgroundBackButton);
            add(txtBackButton);
            
            FlxG.mouse.show();
            
        }
        
        public function pointInFlxRect(pointX:int, pointY:int, rect:FlxRect):Boolean {
            return pointX >= rect.x && pointX <= rect.right && pointY >= rect.y && pointY <= rect.bottom
        }
        
        override public function update():void {
            if (pointInFlxRect(FlxG.mouse.screenX, FlxG.mouse.screenY, backButtonArea)) {
                backgroundBackButton.y = txtBackButton.y + 2;
                backgroundBackButton.visible = true;
                
                if (FlxG.mouse.justReleased()) {
                    FlxG.switchState(new MenuState());
                }
                
            } else {
                backgroundBackButton.visible = false;
            }
        }
        
    }

}