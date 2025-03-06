class Product {
  final String id;
  final String title;
  final double price;
  bool isFavorite;
  final String image;
  final String category;
  final List<String> colors;
  final String description;
  final bool isNetworkImage;
  final double? rating;
  final int? reviews;
  final List<String>? sizes;
  final String brand;
  final String material;
  final List<String> careInstructions;
  final List<String> features;
  final bool inStock;
  final String deliveryTime;

  Product({
    required this.id,
    required this.title,
    required this.price,
    this.isFavorite = false,
    required this.image,
    required this.category,
    required this.colors,
    required this.description,
    this.isNetworkImage = true,
    this.rating = 4.5,
    this.reviews = 0,
    this.sizes,
    required this.brand,
    required this.material,
    this.careInstructions = const [],
    this.features = const [],
    this.inStock = true,
    this.deliveryTime = "2-4 business days",
  });
}
