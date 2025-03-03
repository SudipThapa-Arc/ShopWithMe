class Product {
  final String title;
  final double price;
  final String image;
  final String category;
  final List<String> colors;
  final String description;
  final bool isNetworkImage;
  final double? rating;
  final List<String>? sizes;

  Product({
    required this.title,
    required this.price,
    required this.image,
    required this.category,
    required this.colors,
    required this.description,
    this.isNetworkImage = true,
    this.rating = 4.5,
    this.sizes,
  });
}
