package wgl.core {
internal final class ListenerInfo {
    private var _listener:Function;
    private var _type:String;
    private var _useCapture:Boolean;
    
    public function ListenerInfo(type:String = null, listener:Function = null, useCapture:Boolean = false) {
        _type = type;
        _listener = listener;
        _useCapture = useCapture;
    }
    
    public function get listener():Function {
        return _listener;
    }
    
    public function set listener(value:Function):void {
        _listener = value;
    }
    
    public function get type():String {
        return _type;
    }
    
    public function set type(value:String):void {
        _type = value;
    }
    
    public function get useCapture():Boolean {
        return _useCapture;
    }
    
    public function set useCapture(value:Boolean):void {
        _useCapture = value;
    }
    
    public function equalsTo(li:ListenerInfo):Boolean {
        return ((li.type == _type) && (li.listener == _listener) && (li.useCapture == _useCapture));
    }
}
}