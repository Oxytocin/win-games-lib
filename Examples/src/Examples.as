package
{
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	
	import examples.ImageLoaderExample;
	
	public class Examples extends Sprite
	{
		private static const EXAMPLES:Object =
			{
				"Image Loader" : ImageLoaderExample
			};
		
		public function Examples()
		{
			super();
			
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			
			var exampleId:String = "Image Loader";
			var exampleClass:Class = EXAMPLES[exampleId];
			
			addChild(new exampleClass());
		}
	}
}