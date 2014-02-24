package wgl.utils {
import flash.desktop.NativeApplication;

/**
 * Auxiliary class which provides easy acces to the most frequently accessed values in AIR application descriptor XML file. 
 */
final public class AppDescriptor {
    public function AppDescriptor() {
        throw new Error("Can't instantiate a static class");
    }
    
    private static var $_version:String;
    public static function get version():String {
        if (!$_version) {
            var appXML:XML = NativeApplication.nativeApplication.applicationDescriptor;
            var xmlns:Namespace = appXML.namespace();
            var ver:XMLList = appXML.xmlns::versionNumber;
            if (ver.length() > 0) {
                $_version = ver.toString();
            }
        }
        return $_version; 
    }
    
    private static var $_supportedLanguages:Vector.<String>;
    public static function get supportedLanguages():Vector.<String> {
        if (!$_supportedLanguages) {
            var appXML:XML = NativeApplication.nativeApplication.applicationDescriptor;
            var xmlns:Namespace = appXML.namespace();
            var sl:XMLList = appXML.xmlns::supportedLanguages;
            if (sl.length() > 0) {
                var val:String = sl.toString();
                $_supportedLanguages = Vector.<String>(val.split(" "));
            }
        }
        return $_supportedLanguages;
    }
}
}