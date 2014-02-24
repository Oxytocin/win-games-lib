package wgl.utils.display {
import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.LoaderInfo;
import flash.events.Event;
import flash.events.IOErrorEvent;
import flash.net.URLRequest;

import wgl.utils.DynamicLoader;
import wgl.utils.ObjectUtils;

/**
 * This module implements logic which can be used to operate with dynamicaly loaded images.
 * Usage:
 * <ol>
 * <li>Create an instance of the class</li>
 * <li>[Optional] Load <code>config</code> which describes pairs "id" -> "image url"</li>
 * <li>To get image use <code>imageLoader.getImgById("some_id_or_url")</code></li>
 * <li>If <code>id</code> is present in <code>config</code> - ImageLoader will load using corresponding URL.</li>
 * <li>If <code>id</code> is <b>NOT</b> present in <code>config</code> - ImageLoader will try to load image using <code>id</code> as URL.</li>
 * </ol>
 * 
 * @author AntonY 
 */
public class ImageLoader implements IImageLoader {
    
    /**
     * Key-Value pairs of [id] - [path]
     * 
     * <pre>
     * {
     *     "id_1"  : "res/images/img_01.png",
     *     "id_2"  : "res/images/img_02.png",
     * } 
     * </pre>
     */
    private var _config:Object;
    
    public function ImageLoader() {
        super();
    }
    
    public function set config(value:Object):void {
        _config = value;
    }
    
    /**
     * <pre>
     * {
     * "id1" : 
     * {
     *     "loader" : {},
     *     "holders": []
     * },
     * "id2":
     * {
     *     "loader" : {},
     *     "holders": []
     * }
     * }
     * </pre> 
     */
    private var requests:Object = {};
    
    /**
     * <p>
     * Loads image using image id. If <code>config</code> is loaded and it contains specified <code>id</code>,
     * then the corresponding <code>path</code> is taken from the <code>config</code>. Otherwise the module tries
     * to load an image using <code>id</code> as a <code>path</code>.
     * </p> 
     * @param id - id in config or path to the image.
     * @return ImageHolder instance.
     * 
     */
    public function getImgById(id:String):ImageHolder {
        var res:ImageHolder = new ImageHolder();
        res.onDestroy = onImgHolderDestoyed;
        res.id = id;
        var path:String; 
        if (_config) {
            path = ObjectUtils.valueForPath(_config, id);
        }
        if (!path) {
            path = id;
        }
        if (_cachedARCBMP.hasOwnProperty(id)) {
            trace("[ImageLoader] Found cached image");
            res.image = _cachedARCBMP[id];
        } else {
            trace("[ImageLoader] Loading image");
            if (!requests.hasOwnProperty(id)) {
                var oReq:Object = {};
                var loader:DynamicLoader = getLoader();
                oReq["loader"]  = loader;
                oReq["holders"] = [];
                loader["id"] = id;
                var req:URLRequest = new URLRequest(path);
                loader.load(req);
                requests[id] = oReq;
            }
            requests[id]["holders"].push(res);
        }
        return res;
    }
    
    private function onLoaderEvent(event:Event):void {
        var loaderInfo:LoaderInfo = event.target as LoaderInfo;
        var loader:DynamicLoader = loaderInfo.loader as DynamicLoader;
        var id:String = loader.id;
        var aReq:Array = requests[id]["holders"];
        var i:int;
        switch (event.type) {
            case Event.COMPLETE: {
                var bData:BitmapData = (loader.content as Bitmap).bitmapData;
                var arcBmp:ARCBitmapData = new ARCBitmapData(bData, onARCBitmapDataDisposed);
                _cachedARCBMP[id] = arcBmp;
                for (i = 0; i < aReq.length; i++) {
                    var imgHolder:ImageHolder = aReq[i];
                    imgHolder.image = arcBmp;
                }
                disposeRequest(id);
                break;
            }
            case IOErrorEvent.IO_ERROR: {
                for (i = 0; i < aReq.length; i++) {
                    var item:ImageHolder = aReq[i];
                    item.notifyError();
                }
                disposeRequest(id);
                break;
            }
        }
    }
    
    private var _cachedARCBMP:Object = {};
    
    private function onARCBitmapDataDisposed(arcBmp:ARCBitmapData):void {
        for (var key:String in _cachedARCBMP) {
            if (_cachedARCBMP[key] == arcBmp) {
                trace(">> Remove image from cache. ID = '" + key + "'.");
                delete _cachedARCBMP[key];
            }
        }
    }
    
    private function disposeRequest(id:String):void {
        var req:Object = requests[id];
        var loader:DynamicLoader = req["loader"];
        releaseLoader(loader);
        delete requests[id];
    }
    
    private function onImgHolderDestoyed(id:String, imgHolder:ImageHolder):void {
        var item:Object = requests[id];
        if (!item) {
            return;
        }
        var aReq:Array = requests[id]["holders"];
        if (aReq) {
            aReq.splice(aReq.indexOf(imgHolder), 1);
            if (!aReq.length) {
                trace("--- dispose request with id " + id);
                disposeRequest(id);
            }
        }
    }
    
    private function getLoader():DynamicLoader {
        var res:DynamicLoader;
        res = new DynamicLoader();
        res.contentLoaderInfo.addEventListener(Event.COMPLETE, onLoaderEvent);
        res.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, onLoaderEvent);
        return res;
    }
    
    private function releaseLoader(loader:DynamicLoader):void {
        loader.contentLoaderInfo.removeEventListener(Event.COMPLETE, onLoaderEvent);
        loader.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR, onLoaderEvent);
    }
}
}