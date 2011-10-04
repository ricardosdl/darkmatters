package hipercodigo.util {
    
    public class RandomInterval {
        
        public static function randomInterval(start:Number, end:Number, floor:Boolean = false):Number {
            if (! floor) {
                return Math.random() * (end - start) + start;
            } else {
                return Math.floor(Math.random() * (end - start) + start);
            }
        }
        
    }
    
}