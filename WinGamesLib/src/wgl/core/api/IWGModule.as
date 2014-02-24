package wgl.core.api {
public interface IWGModule extends IWGListener {
    function initialize(id:String, params:* = null):IWGModule;
    function get id():String;
}
}