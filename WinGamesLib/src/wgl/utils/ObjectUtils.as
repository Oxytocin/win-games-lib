package wgl.utils {
public class ObjectUtils {
    
    
    
    /**
     * Get value from the obj using path.
     * path examples:
     * <ul>
     * <li>"volume"</li>
     * <li>"config/sound/volume"</li>
     * <ul> 
     * @param obj - source
     * @param path - path to the value.
     * @return Value if it is found or null.
     * 
     */
    public static function valueForPath(obj:Object, path:String):* {
        if (!obj || !path) {
            return null;
        }
        var res:* = null;
        var aPath:Array = path.split("/");
        var tmpRes:* = obj;
        for (var i:int = 0; i < aPath.length; i++) {
            if (tmpRes != null) {
                if (typeof tmpRes != "object") {
                    tmpRes = null;
                    break;
                } else {
                    tmpRes = tmpRes[aPath[i]];
                }
            } else {
                break;
            }
        }
        return tmpRes;
    }
    
}
}