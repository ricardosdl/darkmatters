package {

    import org.flixel.*;
    
    public class LevelsCompleted {
        
        public static var _save:FlxSave;
        public static var _initialLevel:int = 0;
        public static var _loaded:Boolean = false;
        public static var _savedGame:Boolean = false;
        
        public static function updateSavedGame(newLevel:int):void {
            if (! _loaded) {
                return;
            }
            
            _save.data.currentLevel = newLevel;
            
        }
        
        public static function currentLevel():int {
            if (_savedGame) {
                return _save.data.currentLevel;
            }
            return 1;
        }
        
        public static function load():void {
            _save = new FlxSave();
            _loaded = _save.bind("levelData");
            _savedGame = _save.data.currentLevel != null;
        }
        
    }

}