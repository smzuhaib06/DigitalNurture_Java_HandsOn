import org.junit.Test;
import static org.junit.Assert.assertEquals;

public class CalculatorTest {

    @Test
    public void testAdd() {
        Calculator calc = new Calculator();

        int result = calc.add(10, 20);

        assertEquals(30, result);
    }

    @Test
    public void testMultiply() {
        Calculator calc = new Calculator();

        int result = calc.multiply(5, 4);

        assertEquals(20, result);
    }
}
