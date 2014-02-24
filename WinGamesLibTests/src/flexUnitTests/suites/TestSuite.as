package flexUnitTests.suites {
import flexUnitTests.cases.AsyncTests;
import flexUnitTests.cases.UtilsTestCase;

[Suite]
[RunWith("org.flexunit.runners.Suite")]
public class TestSuite {
    public var t1:UtilsTestCase;
    public var t2:AsyncTests;
}
}