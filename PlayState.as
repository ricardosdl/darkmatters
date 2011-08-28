package {
    
    import org.flixel.*;
    
    public class PlayState extends FlxState {
        
        override public function create():void {
            trace('created');
        }
        
        override public function update():void {
            trace('updated');
        }
        
    }
    
}