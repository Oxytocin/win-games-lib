package wgl.core.arc {
public interface IARCContainer {
    function retain():*;
    function release():void;
    function get refCount():int;
}
}