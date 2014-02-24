package wgl.core {
import wgl.core.api.IWGListener;

public class WGListener extends WGObject implements IWGListener {
    public function WGListener() {
    }
    
    /**
     * The Vector of currently added context listeners.  
     */
    private var _listeners:Vector.<ListenerInfo>;
    
    private static const HELPER_LISTENER_INFO:ListenerInfo = new ListenerInfo();
    
    public function addContextListener(type:String, listener:Function, useCapture:Boolean=false, priority:int=0, useWeakReference:Boolean=false):void {
        if (hasListener(type, listener, useCapture)) {
            return;
        }
        if (!_listeners) {
            _listeners = new Vector.<ListenerInfo>();
        }
        _listeners.push(new ListenerInfo(type, listener, useCapture));
        application.addContextListener(type, listener, useCapture, priority, useWeakReference);
    }
    
    public function removeContextListener(type:String, listener:Function, useCapture:Boolean=false):void {
        application.removeContextListener(type, listener, useCapture);
        HELPER_LISTENER_INFO.type = type;
        HELPER_LISTENER_INFO.listener = listener;
        HELPER_LISTENER_INFO.useCapture = useCapture;
        for (var i:uint = 0; i < _listeners.length; i++) {
            if (_listeners[i].equalsTo(HELPER_LISTENER_INFO)) {
                _listeners.splice(i, 1);
                break;
            }
        }
    }
    
    public function removeAllContextListeners():void {
        if (_listeners) {
            for (var i:uint = 0; i < _listeners.length; i++) {
                var li:ListenerInfo = _listeners[i];
                application.removeContextListener(li.type, li.listener, li.useCapture);
            }
        }
        _listeners = null;
    }
    
    
    private function hasListener(type:String, listener:Function, useCapture:Boolean=false):Boolean {
        var res:Boolean = false;
        if (_listeners) {
            HELPER_LISTENER_INFO.type = type;
            HELPER_LISTENER_INFO.listener = listener;
            HELPER_LISTENER_INFO.useCapture = useCapture;
            for (var i:int = 0; i < _listeners.length; i++) {
                if (HELPER_LISTENER_INFO.equalsTo(_listeners[i])) {
                    res = true;
                    break;
                }
            }
        }
        return res;
    }
    
    override public function dispose():void {
        removeAllContextListeners();
        super.dispose();
    }
}
}