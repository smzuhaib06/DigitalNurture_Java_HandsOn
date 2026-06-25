public class FinancialForecast {

    public static double futureValue(double principal, double growthRate, int years) {

        if (years == 0) {
            return principal;
        }

        return futureValue(principal, growthRate, years - 1) * (1 + growthRate);
    }

    public static double power(double x, int n) {

        if (n == 0) {
            return 1;
        }

        double half = power(x, n / 2);

        if (n % 2 == 0) {
            return half * half;
        } else {
            return x * half * half;
        }
    }

    public static void main(String[] args) {

        double principal = 10000;
        double growthRate = 0.10; 
        int years = 5;

        double recursiveResult = futureValue(principal, growthRate, years);

        double optimizedResult = principal * power(1 + growthRate, years);

        System.out.println("Financial Forecasting");
        System.out.println("----------------------");
        System.out.println("Initial Value : " + principal);
        System.out.println("Growth Rate   : " + (growthRate * 100) + "%");
        System.out.println("Years         : " + years);

        System.out.println("\nUsing Basic Recursion:");
        System.out.println("Future Value = " + recursiveResult);

        System.out.println("\nUsing Optimized Recursion (Fast Exponentiation):");
        System.out.println("Future Value = " + optimizedResult);

        System.out.println("\nAnalysis:");
        System.out.println("Basic Recursion Time Complexity  : O(n)");
        System.out.println("Basic Recursion Space Complexity : O(n)");
        System.out.println("Optimized Time Complexity        : O(log n)");
        System.out.println("Optimized Space Complexity       : O(log n)");
    }
}
