package {
    
    import org.flixel.*;
    
    [SWF(width="320", height="240", backgroundColor="#ff0000")]
    [Frame(factoryClass="Preloader")]
    
    public class Darkness extends FlxGame {
        
        public function Darkness():void {
            super(160, 120, MenuState, 2, 50, 50);
            forceDebugger = true;
        }
        
    }
    
}