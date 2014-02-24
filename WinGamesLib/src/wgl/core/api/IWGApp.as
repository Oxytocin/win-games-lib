package wgl.core.api {
import flash.display.Stage;

/**
 * Interface of the application facade class.
 * 
 * @author AntonY
 */
public interface IWGApp extends IWGListener {
    
    
    /**
     * @return Application main configuration object.
     * 
     */
    function get appConfig():IWGConfig;
    
    
    /**
     * @return Application's stage. 
     * 
     */
    function get stage():Stage;
    
    /**
     * Cretes module of specified class and adds it to modules list of WGApplication. 
     * @param id The id of the module.
     * @param iFace Interface, which the added module should implement.
     * @param cls The class of the module.
     * @param params Optional parameters of the module.
     * @return Created module.
     * 
     * @throws com.win.errors.ModuleRegistrationError
     * 
     */
    function registerModule(id:String, iFace:Class, cls:Class, params:* = null):IWGModule;
    
    function registerWGObject(wgObj:IWGObject):void;
    
    /**
     * Removes module from modules list and calls dispose() on module. 
     * @param id ID of the module to be disposed.
     * 
     */
    function disposeModule(id:String):void;
    
    
    /**
     * Returns module with specified id or <code>null</code> if it was not registered. 
     * @param id ID of the module to get
     * @return Module with id or <code>null</code>
     * 
     */
    function getModule(id:String):IWGModule;
}
}