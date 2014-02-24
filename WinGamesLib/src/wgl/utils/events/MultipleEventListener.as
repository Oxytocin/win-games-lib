package wgl.utils.events {
import flash.events.Event;
import flash.events.IEventDispatcher;

public class MultipleEventListener {
    
    private var params:Array;
    private var handler:Callback;
    private var callbackParams:Array;
    
    private var targets:Vector.<TargetInfo>;
    
    public function MultipleEventListener(params:Array, handler:Callback, callbackParams:Array = null) {
        targets = new Vector.<TargetInfo>();
        
        this.params = params;
        this.handler = handler;
        this.callbackParams = callbackParams;
        
        for (var i:int = 0; i < params.length; i++) {
            var obj:Array = params[i];
            var target:IEventDispatcher = obj[0];
            var eventType:String = obj[1];
            target.addEventListener(eventType, onSingleEventHandler);
            targets.push(new TargetInfo(target, eventType));
        }
    }
    
    private function onSingleEventHandler(event:Event):void {
        var target:IEventDispatcher = event.target as IEventDispatcher;
        var eventType:String = event.type;
        for (var i:int = 0; i < targets.length; i++) {
            if (targets[i].target == target && targets[i].eventType == eventType) {
                target.removeEventListener(eventType, onSingleEventHandler);
                targets.splice(i, 1);
                break;
            }
        }
        if (targets.length == 0) {
            handler.call(callbackParams);
            dispose();
        }
    }
    
    public function dispose():void {
        if (targets) {
            for (var i:int = 0; i < targets.length; i++) {
                targets[i].target.removeEventListener(targets[i].eventType, onSingleEventHandler);
            }
            targets = null;
        }
        params = null;
        handler = null;
    }
}
}

import flash.events.IEventDispatcher;

class TargetInfo {
    public var target:IEventDispatcher;
    public var eventType:String;
    
    public function TargetInfo(target:IEventDispatcher, eventType:String) {
        this.target = target;
        this.eventType = eventType;
    }
}