package {
    
    import org.flixel.*;
    import org.flixel.plugin.photonstorm.*;
    
    public class MenuState extends FlxState {
        
        public var gameTitle:String = "Darkness";
        public var menuOptions:Array;
        
        public var menuOptionsBackGround:FlxSprite;
        
        public var menuGroup:FlxGroup;
        
        public var menuArea:FlxRect;
        
        public function MenuState() {
            menuOptions = new Array();
            menuOptions.push("NEW GAME");
            menuOptions.push("LOAD GAME");
            menuOptions.push("CREDITS");
            
            menuGroup = new FlxGroup();
        }
        
        override public function create():void {
            var xTitle:Number = 20;
            var yTitle:Number = 10;
            var txtTitle:FlxText = new FlxText(xTitle, yTitle, 160, gameTitle);
            txtTitle.size = 20;
            add(txtTitle);
            
            var xMenu:Number = 160 - 90;
            var yMenu:Number = 120 - 80;
            
            menuOptionsBackGround = new FlxSprite(xMenu, yMenu + 1).makeGraphic(150, 11, 0xffe06000);
            menuOptionsBackGround.visible = false;
            
            for each(var menuOption:String in menuOptions) {
                var txt:FlxText = new FlxText(xMenu, yMenu, 160, menuOption);
                txt.shadow = 0xff000000;
                menuGroup.add(txt);
                yMenu += 12;
            }
            
            menuArea = new FlxRect(xMenu, 120 - 80, 160, yMenu - 36);
            
            add(menuOptionsBackGround)
            add(menuGroup);
            
            FlxG.mouse.show();
            
        }
        
        public function pointInFlxRect(pointX:int, pointY:int, rect:FlxRect):Boolean {
            return pointX >= rect.x && pointX <= rect.right && pointY >= rect.y && pointY <= rect.bottom
        }
        
        override public function update():void {
            if (pointInFlxRect(FlxG.mouse.screenX, FlxG.mouse.screenY, menuArea)) {
                //get which option is bellow the mouse
                var mx:int = (FlxG.mouse.screenY - menuArea.top) / 12;
                if (menuGroup.members[mx]) {
                    menuOptionsBackGround.y = menuGroup.members[mx].y + 2;
                    menuOptionsBackGround.visible = true;
                }
            } else {
                menuOptionsBackGround.visible = false;
            }
        }
        
    }

}