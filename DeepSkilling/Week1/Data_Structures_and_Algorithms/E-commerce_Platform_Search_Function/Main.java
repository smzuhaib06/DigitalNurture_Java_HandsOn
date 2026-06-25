package A5;

class Product {
    int productId;
    String productName;
    String category;

    Product(int productId, String productName, String category) {
        this.productId = productId;
        this.productName = productName;
        this.category = category;
    }

    void display() {
        System.out.println("Product ID: " + productId);
        System.out.println("Product Name: " + productName);
        System.out.println("Category: " + category);
    }
}

class LinearSearch {
    static Product search(Product[] products, int targetId) {
        for (Product product : products) {
            if (product.productId == targetId) {
                return product;
            }
        }
        return null;
    }
}

class BinarySearch {
    static Product search(Product[] products, int targetId) {
        int low = 0;
        int high = products.length - 1;

        while (low <= high) {
            int mid = (low + high) / 2;

            if (products[mid].productId == targetId) {
                return products[mid];
            } else if (products[mid].productId < targetId) {
                low = mid + 1;
            } else {
                high = mid - 1;
            }
        }

        return null;
    }
}

public class Main {
    public static void main(String[] args) {

        Product[] products = {
            new Product(101, "Laptop", "Electronics"),
            new Product(102, "Mouse", "Electronics"),
            new Product(103, "Keyboard", "Electronics"),
            new Product(104, "Shoes", "Fashion"),
            new Product(105, "Watch", "Accessories")
        };

        int targetId = 104;

        System.out.println("Linear Search Result:");
        Product linearResult = LinearSearch.search(products, targetId);

        if (linearResult != null) {
            linearResult.display();
        } else {
            System.out.println("Product not found");
        }

        System.out.println("\nBinary Search Result:");
        Product binaryResult = BinarySearch.search(products, targetId);

        if (binaryResult != null) {
            binaryResult.display();
        } else {
            System.out.println("Product not found");
        }
    }
}
