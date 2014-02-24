package wgl.core {
import wgl.core.api.IWGModule;

public class WGModule extends WGListener implements IWGModule {
    
    private var _id:String;
    
    public function WGModule() {
        super();
    }
    
    public function get id():String {
        return _id;
    }
    
    public function initialize(id:String, params:*=null):IWGModule {
        _id = id;
        parseParams(params);
        return this;
    }
    
    protected function parseParams(params:*):void {
    }
}
}