package wgl.utils.events {
/**
 * Usage:
 * <pre>
 *  waitForMultipleEvents(
 *  [ 
 *      [target_1:IEventDispatcher, eventType_1:String, {eventParams}],
 *      [target_2:IEventDispatcher, eventType_2:String, {eventParams}],
 *      ...
 *      [target_n:IEventDispatcher, eventType_n:String, {eventParams}],
 *    ]
 *  );
 * </pre>
 * @author AntonY
 */
public function waitForMultipleEvents(params:Array, handler:Callback, callbackParams:Array = null):MultipleEventListener {
    var res:MultipleEventListener = new MultipleEventListener(params, handler, callbackParams);
    return res;
}	
}