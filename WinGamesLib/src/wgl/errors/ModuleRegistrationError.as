package wgl.errors {
public class ModuleRegistrationError extends Error {
    
    public function ModuleRegistrationError(message:*="", id:*=0) {
        super(message, id);
    }
}
}