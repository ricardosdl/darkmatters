package {
    
    import org.flixel.*;
    
    [SWF(width="640", height="480", backgroundColor="#000000")]
    [Frame(factoryClass="Preloader")]
    
    public class Darkness extends FlxGame {
        
        public function Darkness():void {
            super(160, 120, PlayState, 2, 50, 50);
            forceDebugger = true;
        }
        
    }
    
}