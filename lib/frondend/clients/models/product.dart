/// Simple immutable product model used across Home / Cart screens.
class Product {
  final String name;
  final String subtitle;
  final double price;
  final double? originalPrice;
  final String imageUrl;
  final int? saleProgress; // 0-100, only used for flash-sale cards

  const Product({
    required this.name,
    required this.subtitle,
    required this.price,
    required this.imageUrl,
    this.originalPrice,
    this.saleProgress,
  });
}

/// Static sample catalog so the UI is fully functional out of the box.
/// Replace with data fetched from your backend/API layer.
class ProductCatalog {
  ProductCatalog._();

  static const List<Product> featured = [
    Product(
      name: 'PureStep Sneakers',
      subtitle: 'Footwear • Men',
      price: 185.00,
      imageUrl:
      'https://images.unsplash.com/photo-1595950653106-6c9ebd614d3a?w=600&q=80',
    ),
    Product(
      name: 'Echo Sphere Hub',
      subtitle: 'Tech • Smart Home',
      price: 210.00,
      imageUrl:
      'https://images.unsplash.com/photo-1543512214-318c7553f230?w=600&q=80',
    ),
    Product(
      name: 'Velocitron Pro 4',
      subtitle: 'Appliances • Kitchen',
      price: 540.00,
      imageUrl:
      'https://images.unsplash.com/photo-1570222094114-d054a817e56b?w=600&q=80',
    ),
    Product(
      name: 'Essence Ritual Set',
      subtitle: 'Beauty • Skincare',
      price: 85.00,
      imageUrl:
      'https://images.unsplash.com/photo-1556228720-195a672e8a03?w=600&q=80',
    ),
  ];

  static const List<Product> flashSale = [
    Product(
      name: 'Urban Chrono',
      subtitle: 'Watches',
      price: 129.00,
      originalPrice: 240.00,
      saleProgress: 65,
      imageUrl:
      'https://images.unsplash.com/photo-1524805444758-089113d48a6d?w=600&q=80',
    ),
    Product(
      name: 'Sonic Aura Gen 2',
      subtitle: 'Audio',
      price: 299.00,
      originalPrice: 450.00,
      saleProgress: 30,
      imageUrl:
      'https://images.unsplash.com/photo-1505740420928-5e560c06d30e?w=600&q=80',
    ),
    Product(
      name: 'Lumina Tote Bag',
      subtitle: 'Fashion',
      price: 450.00,
      originalPrice: 680.00,
      saleProgress: 85,
      imageUrl:
      'https://images.unsplash.com/photo-1584917865442-de89df76afd3?w=600&q=80',
    ),
  ];
}