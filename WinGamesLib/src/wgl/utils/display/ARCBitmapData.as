package wgl.utils.display {
import flash.display.BitmapData;

import wgl.core.arc.ARCContainer;
import wgl.core.arc.IARCContainer;

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
public class ARCBitmapData extends ARCContainer implements IARCContainer {
    
    private var _bitmapData:BitmapData;
    private var _disposeCallback:Function;
    
    public function ARCBitmapData(bitmapData:BitmapData, disposeCallback:Function = null) {
        _bitmapData = bitmapData;
        _disposeCallback = disposeCallback;
    }

    override protected function dispose():void {
        trace(">> [ARCBitmapData] Disposed");
        if (_disposeCallback) {
            _disposeCallback.call(null, this);
            _disposeCallback = null;
        }
        _bitmapData.dispose();
        _bitmapData = null;
    }
    
    override protected function getInnerObject():* {
        return _bitmapData;
    }
}
}