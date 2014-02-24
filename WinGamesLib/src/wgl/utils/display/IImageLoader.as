package wgl.utils.display {
public interface IImageLoader {
    function set config(value:Object):void;
    function getImgById(id:String):ImageHolder;
}
}