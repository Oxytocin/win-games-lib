package wgl.utils.events {
public class Callback {
    private var _func:Function;
    private var _ctx:*;
    
    public function Callback(func:Function, context:* = null) {
        _func = func;
        _ctx = context;
    }
    
    public function call(args:Array = null):void {
        _func.apply(_ctx, args);
    }
    
    public function dispose():void {
        _func = null;
        _ctx = null;
    }
    
    public static function callback(func:Function, context:* = null):Callback {
        return new Callback(func, context);
    }
}
}