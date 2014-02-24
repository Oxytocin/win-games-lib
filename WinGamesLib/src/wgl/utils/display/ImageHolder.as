package wgl.utils.display {
import flash.display.Bitmap;
import flash.display.Sprite;

public class ImageHolder extends Sprite {
    
    private var _id:String;
    
    private var img:Bitmap;
    
    private var _maxWidth:int  = 0;
    private var _maxHeight:int = 0;
    
    public function ImageHolder() {
        super();
    }
    
    public function set id(value:String):void {
        _id = value;
    }
    
    public function get maxHeight():int {
        return _maxHeight;
    }

    public function set maxHeight(value:int):void {
        _maxHeight = value;
        resize();
    }

    public function get maxWidth():int {
        return _maxWidth;
    }

    public function set maxWidth(value:int):void {
        _maxWidth = value;
        resize();
    }

    private var _onDestroy:Function;
    
    public function set onDestroy(value:Function):void {
        _onDestroy = value;
    }
    
    private var arcBmp:ARCBitmapData;
    
    public function set image(bmp:ARCBitmapData):void {
        arcBmp = bmp;
        img = new Bitmap(bmp.retain());
        resize();
        addChild(img);
    }
    
    private function resize():void {
        if (!img) {
            return;
        }
        if ((_maxWidth > 0) && (img.width > _maxWidth)) {
            img.height *= _maxWidth / img.width;
            img.width  = _maxWidth;
            img.smoothing = true;
        }
        if ((_maxHeight > 0) && (img.height > _maxHeight)) {
            img.width *= _maxHeight / img.height;
            img.height   = _maxHeight;
            img.smoothing = true;
        }
    }
    
    public function notifyError():void {
        graphics.beginFill(0xFF0000, 0.5);
        graphics.drawRect(0, 0, maxWidth > 0 ? maxWidth : 10, maxHeight > 0 ? maxHeight : 10);
        graphics.endFill();
        throw new Error("Could not load image for id '" + _id + "'.");
    }
    
    public function dispose():void {
        if (arcBmp) {
            arcBmp.release();
            arcBmp = null;
        }
        if (img) {
            img = null;
        }
        if (parent) {
            parent.removeChild(this);
        }
        if (_onDestroy) {
            _onDestroy.call(null, _id, this);
            _onDestroy = null;
        }
    }
}
}