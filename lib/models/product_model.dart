//model classes for Product and ProductCategory, with factory constructors to create instances from JSON data returned by the API.
class Product {
  final int id;
  final String title;
  final double price;
  final String description;
  final String category;
  final String image;
  final double rating;
  final int stock;

  Product({
    required this.id,
    required this.title,
    required this.price,
    required this.description,
    required this.category,
    required this.image,
    required this.rating,
    required this.stock,
  });

  factory Product.fromJson(Map<String, dynamic>? json) {
    return Product(
      id: (json?['id'] as num?)?.toInt() ?? 0,
      title: json?['title'] as String? ?? '',
      price: (json?['price'] as num?)?.toDouble() ?? 0.0,
      description: json?['description'] as String? ?? '',
      category: json?['category'] as String? ?? '',
      image: json?['thumbnail'] as String? ?? '',
      rating: (json?['rating'] as num?)?.toDouble() ?? 0.0,
      stock: (json?['stock'] as num?)?.toInt() ?? 0,
    );
  }
}

class ProductCategory {
  final String slug;
  final String name;

  ProductCategory({
    required this.slug,
    required this.name,
  });

  factory ProductCategory.fromJson(Map<String, dynamic>? json) {
    return ProductCategory(
      slug: json?['slug'] as String? ?? '',
      name: json?['name'] as String? ?? '',
    );
  }
}