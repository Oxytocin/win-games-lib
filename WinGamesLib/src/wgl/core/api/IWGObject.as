package wgl.core.api {
import flash.events.Event;

public interface IWGObject {
    
    /**
     * Called from application when <code>IWGObject</code> was registered in <code>IWGApp</code>.  
     * @param app
     * 
     */
    function linkApp(app:IWGApp):void;
    
    /**
     * Dispatch event through Event Bus 
     * @param event - Event to be dispatched
     * 
     */
    function dispatch(event:Event):void;
    
    
    /**
     * Dispatch event of specified type through Event Bus<br>
     * @param type - Type of the event to be dispatched
     * 
     */
    function dispatchEventWith(type:String):void;
    
    /**
     * Release all resources  
     */
    function dispose():void;
}
}