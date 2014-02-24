package wgl.utils.display {
import flash.display.BitmapData;

/**
 * Automatic Reference Counting BitmapData.
 * A wrapper for the BitmapData class.
 * In order to use it perform the following steps:
 * <ol>
 * <li>Create ARCBitmapData, passing the BitmapData instance and Dispose Callback (if needed) </li>
 * <li>In order to use BitmapData - use <code>var bData:BitmapData = arcBitmapData.retain()</code></li>
 * <li>When the BitmapData is not needed call <code>arcBitmapData.release()</code></li>
 * </ol>
 */
public class ARCBitmapData {
    
    private var _bitmapData:BitmapData;
    private var _refsCount:int;
    
    private var _disposeCallback:Function;
    
    public function ARCBitmapData(bitmapData:BitmapData, disposeCallback:Function = null) {
        _bitmapData = bitmapData;
        _refsCount = 0;
        _disposeCallback = disposeCallback;
    }
    
    public function retain():BitmapData {
        _refsCount++;
        return _bitmapData;
    }
    
    public function release():void {
        _refsCount--;
        if (_refsCount <= 0) {
            trace(">> [ARCBitmapData] Disposed");
            if (_disposeCallback) {
                _disposeCallback.call(null, this);
            }
            _bitmapData.dispose();
            _bitmapData = null;
        }
    }
}
}