class Product {
  final String id;
  final String name;
  final double price;
  final String image;
  final String description;
  final int quantity;

  Product({
    required this.id,
    required this.name,
    required this.price,
    required this.image,
    required this.description,
    required this.quantity,
  });

  // Factory constructor for creating Product from Map
  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      price: map['price']?.toDouble() ?? 0.0,
      image: map['image'] ?? '',
      description: map['description'] ?? '',
      quantity: map['quantity'] ?? 0,
    );
  }

  // Mock data
  static List<Product> getMockProducts() {
    return [
      Product(
        id: 'prod_1',
        name: 'Laptop Pro 15"',
        price: 1299.99,
        image: 'https://example.com/images/laptop-pro.jpg',
        description:
            'High-performance laptop with 15-inch display, Intel i7 processor, 16GB RAM, and 512GB SSD.',
        quantity: 25,
      ),
      Product(
        id: 'prod_2',
        name: 'Wireless Headphones',
        price: 149.99,
        image: 'https://example.com/images/wireless-headphones.jpg',
        description:
            'Premium wireless headphones with noise cancellation and 30-hour battery life.',
        quantity: 50,
      ),
      Product(
        id: 'prod_3',
        name: 'Smartphone 128GB',
        price: 699.99,
        image: 'https://example.com/images/smartphone.jpg',
        description:
            'Latest smartphone with 6.1-inch display, 128GB storage, and advanced camera system.',
        quantity: 30,
      ),
      Product(
        id: 'prod_4',
        name: 'Gaming Mouse',
        price: 79.99,
        image: 'https://example.com/images/gaming-mouse.jpg',
        description:
            'High-precision gaming mouse with RGB lighting and programmable buttons.',
        quantity: 75,
      ),
      Product(
        id: 'prod_5',
        name: 'Monitor 27" 4K',
        price: 449.99,
        image: 'https://example.com/images/monitor-4k.jpg',
        description:
            '27-inch 4K UHD monitor with HDR support and USB-C connectivity.',
        quantity: 20,
      ),
      Product(
        id: 'prod_6',
        name: 'Mechanical Keyboard',
        price: 129.99,
        image: 'https://example.com/images/mechanical-keyboard.jpg',
        description:
            'RGB mechanical gaming keyboard with Cherry MX switches and aluminum frame.',
        quantity: 40,
      ),
      Product(
        id: 'prod_7',
        name: 'Tablet 10"',
        price: 299.99,
        image: 'https://example.com/images/tablet.jpg',
        description:
            '10-inch tablet with 64GB storage, WiFi connectivity, and all-day battery.',
        quantity: 35,
      ),
      Product(
        id: 'prod_8',
        name: 'External SSD 1TB',
        price: 89.99,
        image: 'https://example.com/images/external-ssd.jpg',
        description:
            'Portable 1TB SSD with USB 3.2 interface and transfer speeds up to 1000MB/s.',
        quantity: 60,
      ),
    ];
  }

  // Get a single mock product
  static Product getMockProduct() {
    return getMockProducts().first;
  }

  // Get mock product by ID
  static Product? getMockProductById(String productId) {
    try {
      return getMockProducts().firstWhere((product) => product.id == productId);
    } catch (e) {
      return null;
    }
  }

  // Get mock products by name (for cart item matching)
  static Product? getMockProductByName(String productName) {
    try {
      return getMockProducts().firstWhere(
        (product) => product.name == productName,
      );
    } catch (e) {
      return null;
    }
  }
}
