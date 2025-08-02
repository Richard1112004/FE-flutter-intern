import 'dart:ffi';

class Product {
  final int id;
  final String name;
  final double price;
  final String image;
  final String description;
  final int quantity;

  Product({
    this.id = 0,
    required this.name,
    required this.price,
    required this.image,
    required this.description,
    required this.quantity,
  });

  // Factory constructor for creating Product from Map
  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      id: map['id'] ?? 0,
      name: map['name'] ?? '',
      price: map['price']?.toDouble() ?? 0.0,
      image: map['image'] ?? '',
      description: map['description'] ?? '',
      quantity: map['quantity'] ?? 0,
    );
  }

  // Predefined products
  static final Product iphone15 = Product(
    id: 1,
    name: 'iPhone 15',
    price: 999,
    image: 'assets/products/iphone_15.png',
    description:
        '''Latest iPhone with 6.1-inch display, A16 Bionic chip, and 5G support. Available in multiple colors and storage options. Features a dual-camera system with improved low-light performance. Water and dust resistant with IP68 rating. Supports MagSafe accessories for easy attachment and wireless charging. Comes with iOS 17, offering new features and enhancements.''',
    quantity: 25,
  );

  static final Product iphone16 = Product(
    id: 2,
    name: 'iPhone 16',
    price: 1099,
    image: 'assets/products/iphone_16.png',
    description:
        'Latest iPhone with 6.1-inch display, A17 Bionic chip, and improved camera system. Available in multiple colors and storage options. Features a dual-camera system with enhanced low-light performance and new photographic styles. Water and dust resistant with IP68 rating. Supports MagSafe accessories for easy attachment and wireless charging. Comes with iOS 18, offering new features and enhancements. Includes advanced security features and improved battery life. Supports 5G connectivity for faster download and streaming speeds. Enhanced Face ID technology for secure facial recognition. Offers a range of accessories including cases, chargers, and AirPods.',
    quantity: 50,
  );

  static final Product carModel = Product(
    id: 3,
    name: 'Car Model',
    price: 20000,
    image: 'assets/products/Car.png',
    description:
        'A high-performance car with advanced safety features and luxury interior. Equipped with a powerful engine, state-of-the-art infotainment system, and premium sound system. Features include adaptive cruise control, lane-keeping assist, and automatic emergency braking. Offers spacious seating for five passengers and ample cargo space. Available in various colors and trims to suit your style. Comes with a comprehensive warranty and maintenance package. Includes advanced navigation system with real-time traffic updates and voice control. Supports smartphone integration for seamless connectivity. Offers a smooth and comfortable ride with responsive handling and performance. Environmentally friendly with low emissions and high fuel efficiency. Perfect for daily commuting or long road trips. Enjoy the latest in automotive technology and design with this exceptional car model. ',
    quantity: 30,
  );

  static final Product laptop = Product(
    id: 4,
    name: 'Laptop',
    price: 1500,
    image: 'assets/products/laptop.png',
    description:
        'High-performance laptop with 16GB RAM, 512GB SSD, and Intel i7 processor. Ample storage and memory for multitasking and running demanding applications. Features a 15.6-inch Full HD display with vibrant colors and sharp details. Backlit keyboard for comfortable typing in low-light conditions. Lightweight and portable design, perfect for on-the-go professionals and students. Long-lasting battery life for all-day productivity without needing to recharge. Equipped with multiple USB ports, HDMI output, and an SD card reader for versatile connectivity options. Includes a high-definition webcam and dual microphones for clear video calls and online meetings. Pre-installed with the latest operating system and productivity software. Ideal for work, study, or entertainment purposes. Offers a sleek and modern design that fits any environment. Enhanced cooling system for optimal performance during intensive tasks. Supports fast charging technology for quick power-ups. Comes with a one-year warranty and customer support for peace of mind.',
    quantity: 75,
  );

  // List of all predefined products
  static final List<Product> _allProducts = [
    iphone15,
    iphone16,
    carModel,
    laptop,
  ];

  // Mock data
  static List<Product> getMockProducts() {
    return _allProducts;
  }

  // Get a single mock product
  static Product getMockProduct() {
    return getMockProducts().first;
  }

  // Get mock product by ID
  static Product? getMockProductById(String productId) {
    try {
      return getMockProducts().firstWhere((product) => product.id.toString() == productId);
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
