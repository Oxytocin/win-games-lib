package wgl.core.api {
public interface IWGConfig {
    function initialize(config:Object):IWGConfig;
    function isInialized():Boolean;
    function getVar(name:String):*;
    function getBoolVar(name:String):Boolean;
}
}