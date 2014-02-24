package wgl.core.arc {

/**
 * Automatic Reference Counting Container.
 * A wrapper for the Garbage Collected classes.
 * In order to use it perform the following steps:
 * <ol>
 * <li>Extend ARCContainer class and override <code>dispose</code> and <code>getInnerObject</code> functions</li>
 * <li>In order to use original object - use <code>var obj:* = arcContainer.retain()</code></li>
 * <li>When the original object is not needed call <code>arcContainer.release()</code></li>
 * </ol>
 * 
 * @author AntonY
 */

public class ARCContainer implements IARCContainer {
    
    private var _refCount:int;
    
    public function ARCContainer() {
        _refCount = 0;
    }
    
    public function retain():* {
        _refCount++;
        return getInnerObject();
    }
    
    public function release():void {
        _refCount--;
        if (_refCount <= 0) {
            dispose();
        }
    }
    
    public function get refCount():int {
        return _refCount;
    }
    
    // Functions to override in custom containers
    
    protected function dispose():void {
        // TODO: Dispose inner object
    }
    
    protected function getInnerObject():* {
        // TODO: Return inner object
        return null; 
    }
    
}
}