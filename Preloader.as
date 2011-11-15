package
{
	import org.flixel.system.FlxPreloader;
	import org.flixel.FlxG;
	import flash.net.LocalConnection;
	
	public class Preloader extends FlxPreloader
	{
		public function Preloader():void
		{
			className = "Darkness";
			super();
			
			var myhost:LocalConnection = new LocalConnection();
			var domain:String = myhost.domain;
			
			if (! (domain.search("localhost") > -1)) {
			    FlxG.debug = false;
			}
			
		}
	}
}
