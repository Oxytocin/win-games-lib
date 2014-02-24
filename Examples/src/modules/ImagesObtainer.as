package modules {
import wgl.core.WGModule;
import wgl.utils.display.ImageHolder;
import wgl.utils.display.ImageLoader;

public class ImagesObtainer extends WGModule implements IImagesObtainer {
    private var _imageLoader:ImageLoader;
    
    public function ImagesObtainer() {
        super();
        _imageLoader = new ImageLoader();
    }

    
    public function set config(value:Object):void {
        _imageLoader.config = value;
    }
    
    public function getImgById(id:String):ImageHolder {
        return _imageLoader.getImgById(id);
    }
}
}