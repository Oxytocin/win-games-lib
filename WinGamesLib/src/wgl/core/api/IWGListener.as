package wgl.core.api {
public interface IWGListener extends IWGObject {
    
    
    /**
     * Register context event listener
     * 
     * @param type The type of event.
     * @param listener The listener function that processes the event.
     * @param useCapture Determines whether the listener works in the capture phase or the target and bubbling phases.
     * @param priority The priority level of the event listener.
     * @param useWeakReference Determines whether the reference to the listener is strong or weak.
     * 
     */
    function addContextListener(type:String, listener:Function, useCapture:Boolean = false, priority:int = 0, useWeakReference:Boolean = false):void;
    
    /**
     * Removes registered context event listener 
     * @param type The type of event.
     * @param listener The listener function that processes the event.
     * @param useCapture Determines whether the listener works in the capture phase or the target and bubbling phases.
     * 
     */
    function removeContextListener(type:String, listener:Function, useCapture:Boolean = false):void;
    
    
    /**
     * Removes all added context event listeners. 
     */
    function removeAllContextListeners():void;
}
}