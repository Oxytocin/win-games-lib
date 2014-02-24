package wgl.errors {
public class AbstractFunctionCalledError extends Error {
    
    public static const DEFAULT_MESSAGE:String = "Abstract function called";
    
    public function AbstractFunctionCalledError(message:* = DEFAULT_MESSAGE, id:* = 0) {
        super(message, id);
    }
}
}