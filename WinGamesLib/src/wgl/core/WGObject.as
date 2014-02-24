package wgl.core {
import wgl.core.api.IWGApp;
import wgl.core.api.IWGObject;

import flash.events.Event;

public class WGObject implements IWGObject {
    public function WGObject() {
    }

    protected var application:IWGApp;
    
    public function linkApp(app:IWGApp):void {
        application = app;
        onRegistered();
    }
    
    protected function onRegistered():void {
    }
    
    public function dispatch(event:Event):void {
        application.dispatch(event);
    }
    
    public function dispatchEventWith(type:String):void {
        application.dispatchEventWith(type);
    }
    
    public function dispose():void {
        application = null;
    }
}
}