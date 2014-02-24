package flexUnitTests.cases {
import org.flexunit.asserts.assertEquals;
import org.flexunit.asserts.assertNull;

import wgl.utils.ObjectUtils;

public class UtilsTestCase {		
    [Before]
    public function setUp():void {
    }
    
    [After]
    public function tearDown():void {
    }
    
    [BeforeClass]
    public static function setUpBeforeClass():void {
    }
    
    [AfterClass]
    public static function tearDownAfterClass():void {
    }
    
    [Test]
    public function objectUtils_valueForPathTest():void {
        
        var obj:Object = 
            {
                users:
                [
                    {
                        name: "Anton",
                        age: 22,
                        male: true
                    },
                    {
                        name : "Helen",
                        age  : 20,
                        male : false
                    }
                ]
            };

        var name1:String = ObjectUtils.valueForPath(obj, "users/0/name");
        assertEquals("Anton", name1);
        
        var null_value1:String = ObjectUtils.valueForPath(obj, "users/45/name");
        assertNull(null_value1);
        
        var null_value2:* = ObjectUtils.valueForPath(obj, "users/0/age/month");
        assertNull(null_value2);
    }
}
}