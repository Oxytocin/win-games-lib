package wgl.core {
import wgl.core.api.IWGApp;
import wgl.core.api.IWGConfig;
import wgl.core.api.IWGModule;
import wgl.core.api.IWGObject;
import wgl.errors.ModuleRegistrationError;

import flash.display.MovieClip;
import flash.events.Event;
import flash.events.EventDispatcher;
import flash.utils.getQualifiedClassName;

/**
 * Base Application Class. <br>
 * Extend it in your main application class. 
 */
public class WGApplication extends MovieClip implements IWGApp {
    
    /**
     * HashMap of the registered modules. 
     */
    private var _modulesMap:Object = {};
    
    
    /**
     * Application Event Bus. All context events are dispatched through it. 
     */
    private var _eventBus:EventDispatcher;
    
    public function WGApplication() {
        _eventBus = new EventDispatcher();
        super();
    }
    
    public function linkApp(app:IWGApp):void {
    }
    
    public function get appConfig():IWGConfig {
        return null;
    }
    
    public function disposeModule(id:String):void {
        var module:IWGModule = getModule(id);
        if (module) {
            delete _modulesMap[id];
            module.dispose();
        }
    }
    
    public function getModule(id:String):IWGModule {
        return _modulesMap[id];
    }
    
    public function registerModule(id:String, iFace:Class, cls:Class, params:*=null):IWGModule {
        if (_modulesMap.hasOwnProperty(id)) {
            throw new ModuleRegistrationError(["Module with id '", id, "' is already registered!"].join(""));
            return null;
        }
        var module:IWGModule = new cls();
        if (!module) {
            throw new ModuleRegistrationError(["Could not create module of class '", getQualifiedClassName(cls), "'."].join(""));
            return null;
        }
        if (!(module is iFace)) {
            throw new ModuleRegistrationError("Class '" + getQualifiedClassName(cls) + 
                "' does not implement interface '" + getQualifiedClassName(iFace) + "'.");
            return null;
        }
        module.initialize(id, params);
        registerWGObject(module);
        _modulesMap[id] = module;
        trace(["Module '", id, "' of class '", getQualifiedClassName(cls), "' was added."].join(""));
        return module;
    }

    /**
     * The Vector of currently added context listeners.  
     */
    private var _listeners:Vector.<ListenerInfo>;
    
    public function addContextListener(type:String, listener:Function, useCapture:Boolean=false, priority:int=0, useWeakReference:Boolean=false):void {
        if (hasListener(type, listener, useCapture)) {
            return;
        }
        _eventBus.addEventListener(type, listener, useCapture, priority, useWeakReference);
        if (!_listeners) {
            _listeners = new Vector.<ListenerInfo>();
        }
        _listeners.push(new ListenerInfo(type, listener, useCapture));
    }
    
    public function removeAllContextListeners():void {
        if (_listeners) {
            for (var i:uint = 0; i < _listeners.length; i++) {
                var li:ListenerInfo = _listeners[i];
                _eventBus.removeEventListener(li.type, li.listener, li.useCapture);
            }
        }
        _listeners = null;
    }
    
    private static const HELPER_LISTENER_INFO:ListenerInfo = new ListenerInfo();
    
    public function removeContextListener(type:String, listener:Function, useCapture:Boolean=false):void {
        _eventBus.removeEventListener(type, listener, useCapture);
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
    
    public function dispatch(event:Event):void {
        _eventBus.dispatchEvent(event);
    }
    
    private var _eventsPool:Object = {};
    
    public function dispatchEventWith(type:String):void {
        var event:Event;
        if (_eventsPool.hasOwnProperty(type)) {
            event = _eventsPool[type];
        } else {
            trace("\t>> Created new Event instance");
            event = new Event(type);
            _eventsPool[type] = event;
        }
        dispatch(event);
    }
    
    public function dispose():void {
    }
    
    public function registerWGObject(wgObj:IWGObject):void {
        wgObj.linkApp(this);
    }
}
}
