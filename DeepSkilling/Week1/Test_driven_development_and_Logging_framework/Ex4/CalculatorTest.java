import org.junit.Before;
import org.junit.After;
import org.junit.Test;

import static org.junit.Assert.assertEquals;

public class CalculatorTest {

    private Calculator calculator;

    @Before
    public void setUp() {
        calculator = new Calculator();
        System.out.println("Setup: Creating Calculator object");
    }

    @After
    public void tearDown() {
        calculator = null;
        System.out.println("Teardown: Destroying Calculator object");
    }

    @Test
    public void testAdd() {

        // Arrange
        int a = 10;
        int b = 20;

        // Act
        int result = calculator.add(a, b);

        // Assert
        assertEquals(30, result);
    }
}
