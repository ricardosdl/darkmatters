package {
    
    import org.flixel.*;
    
    public class PlayState extends FlxState {
        
        public var player:Player;
        
        override public function create():void {
            player = new Player(FlxG.width / 2, FlxG.height / 2);
            add(player);
            
        }
        
        override public function update():void {
            super.update();
            trace('updated');
        }
        
    }
    
}