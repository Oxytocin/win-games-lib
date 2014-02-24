package flexUnitTests.cases {
import flash.events.Event;
import flash.events.EventDispatcher;
import flash.events.IEventDispatcher;

import org.flexunit.async.Async;

import wgl.utils.events.Callback;
import wgl.utils.events.MultipleEventListener;
import wgl.utils.events.waitForMultipleEvents;

public class AsyncTests {		
    [Before]
    public function setUp():void {
    }
    
    [After]
    public function tearDown():void {
    }
    
    [BeforeClass]
    public static function setUpBeforeClass():void {
    }
    
    [AfterClass]
    public static function tearDownAfterClass():void {
    }
    
    [Test(async)]
    public function multipleEventListener_test():void {
        var dispatcher1:EventDispatcher = new EventDispatcher();
        var event1:String = "event1";
        
        var dispatcher2:EventDispatcher = new EventDispatcher();
        var event2:String = "event2";
        
        var asyncHandler:Function = Async.asyncHandler(this, onMultipleEvents, 100);
        
        waitForMultipleEvents(
            [
                [dispatcher1, event1],
                [dispatcher2, event2]
            ],
            Callback.callback(asyncHandler)
        );
        
        dispatcher1.dispatchEvent(new Event(event1));
        dispatcher2.dispatchEvent(new Event(event2));
    }
    
    private function onMultipleEvents(event:Event, passThroughData:Object):void {
    }
    
    [Test(async)]
    public function multipleEventListenerDispose_test():void {
        var dispatcher1:EventDispatcher = new EventDispatcher();
        var event1:String = "event1";
        
        var dispatcher2:EventDispatcher = new EventDispatcher();
        var event2:String = "event2";

        var testDispatcher:EventDispatcher = new EventDispatcher();
        var failEvent:String = "failEvent";
        
        var listener:MultipleEventListener = waitForMultipleEvents(
            [
                [dispatcher1, event1],
                [dispatcher2, event2]
            ],
            Callback.callback(
                function():void {
                    var disp:IEventDispatcher = this["dispatcher"] as IEventDispatcher;
                    var eType:String = this["eventType"];
                    disp.dispatchEvent(new Event(eType));
                }, 
                { dispatcher:testDispatcher, eventType:failEvent }
            )
        );
        
        listener.dispose();
        
        Async.failOnEvent(this, testDispatcher, failEvent);
        
        dispatcher1.dispatchEvent(new Event(event1));
        dispatcher2.dispatchEvent(new Event(event2));
    }
}
}