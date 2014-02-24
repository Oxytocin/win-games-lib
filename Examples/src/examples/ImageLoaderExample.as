package examples
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	import wgl.utils.display.ImageHolder;
	import wgl.utils.display.ImageLoader;
	
	public class ImageLoaderExample extends Sprite
	{
		public function ImageLoaderExample()
		{
			addEventListener(Event.ADDED_TO_STAGE, onStageAvailable);
		}
		
		private var imagesLoader:ImageLoader;
		
		private function onStageAvailable(event:Event):void {
			removeEventListener(Event.ADDED_TO_STAGE, onStageAvailable);
			imagesLoader = new ImageLoader();
			var cfg:Object = 
				{
					images:
					{
						common:
						{
							i0  : "http://nathanbarry.com/wp-content/uploads/2011/08/minox_c4d.png",
							i1  : "http://duggalconnect.com/wp-content/uploads/2013/06/Landscape-Nature-for-Wallpaper-Dekstop-.jpg"
						}
					}
				};
			imagesLoader.config = cfg;
			
			stage.addEventListener(MouseEvent.CLICK, onClick);
			
			var tf:TextField = new TextField();
			tf.width  = stage.stageWidth;
			tf.height = stage.stageHeight;
			addChild(tf);
			var format:TextFormat = new TextFormat(null, 20);
			tf.defaultTextFormat = format;
			tf.text = "Image Loader example:\n" +
				"\t1. Click on the empty space to place image.\n" +
				"\t2. Click on image to remove it.\n" +
				"\t3. Enjoy :)";
			tf.mouseEnabled = false;
			tf.selectable = false;
		}
		
		private function onClick(event:MouseEvent):void {
			// Get Image by id 
			var img:ImageHolder = imagesLoader.getImgById("images/common/i0");
			img.x = event.stageX;
			img.y = event.stageY;
			img.alpha = Math.random() + .5;
			img.maxWidth = img.maxHeight = 100;
			img.addEventListener(MouseEvent.CLICK, onImgClick);
			addChild(img);
		}
		
		private function onImgClick(event:MouseEvent):void {
			event.stopImmediatePropagation();
			var img:ImageHolder = event.currentTarget as ImageHolder;
			img.dispose();
		}
		
	}
}