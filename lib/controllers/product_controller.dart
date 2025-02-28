// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopwithme/constants/images.dart';
import 'package:shopwithme/models/product_model.dart';

class ProductController extends GetxController {
  var quantity = 1.obs;
  var colorIndex = 0.obs;
  var currentProductTitle = ''.obs;
  var currentProductPrice = 0.0.obs;
  var favorites = <int>[].obs;
  var currentProduct = Rx<Product?>(null);
  var currentCategory = ''.obs;

  final Map<String, List<Product>> categoryProducts = {
    'Women Clothing': [
      Product(
        title: "Summer Floral Dress",
        price: 49.99,
        image:
            "https://imgs.search.brave.com/TNYS0wybINaMF9Z-5ZRRvwyc9ZWpDyogq1Z2B64a43Q/rs:fit:860:0:0:0/g:ce/aHR0cHM6Ly9pLnBp/bmltZy5jb20vb3Jp/Z2luYWxzL2M5Lzk0/LzNiL2M5OTQzYjdi/YzM2MTFjNjg0ZDRi/ZWU2N2UyNDgxMjU5/LmpwZw",
        category: "Women Clothing",
        colors: ["Red", "Blue", "Green"],
        description: "Beautiful floral summer dress perfect for any occasion",
      ),
      Product(
        title: "Evening Gown",
        price: 129.99,
        image:
            "https://i.pinimg.com/564x/89/c9/1f/89c91f991e599c81195b04e487e4f4f4.jpg",
        category: "Women Clothing",
        colors: ["Black", "Navy", "Burgundy"],
        description: "Elegant evening gown for formal occasions",
      ),
      Product(
        title: "Casual Maxi Dress",
        price: 59.99,
        image:
            "https://i.pinimg.com/564x/42/44/09/4244097d369d9fe2a38b1a9a8a60b786.jpg",
        category: "Women Clothing",
        colors: ["Yellow", "Pink", "White"],
        description: "Comfortable maxi dress for everyday wear",
      ),
      Product(
        title: "Cocktail Dress",
        price: 89.99,
        image:
            "https://i.pinimg.com/564x/d5/0a/c8/d50ac8558111b5187e92f249571e01c4.jpg",
        category: "Women Clothing",
        colors: ["Red", "Black", "Silver"],
        description: "Stylish cocktail dress for special events",
      ),
      Product(
        title: "Wrap Dress",
        price: 69.99,
        image:
            "https://i.pinimg.com/564x/15/7d/c0/157dc0947d02d54c92b3f0f7916b66c4.jpg",
        category: "Women Clothing",
        colors: ["Green", "Blue", "Purple"],
        description: "Versatile wrap dress suitable for work and leisure",
      ),
      Product(
        title: "Bohemian Maxi Dress",
        price: 79.99,
        image:
            "https://i.pinimg.com/564x/a8/f5/4f/a8f54f727a5d6391b8618a9dc2b38891.jpg",
        category: "Women Clothing",
        colors: ["Orange", "Yellow", "Red"],
        description: "Flowy bohemian style maxi dress perfect for summer",
      ),
      Product(
        title: "Business Pencil Dress",
        price: 89.99,
        image: imgP1,
        category: "Women Clothing",
        colors: ["Black", "Navy", "Grey"],
        description: "Professional pencil dress for office wear",
      ),
      Product(
        title: "Party Sequin Dress",
        price: 119.99,
        image: imgP1,
        category: "Women Clothing",
        colors: ["Gold", "Silver", "Rose Gold"],
        description: "Glamorous sequin dress for special occasions",
      ),
      Product(
        title: "Casual T-shirt Dress",
        price: 39.99,
        image: imgP1,
        category: "Women Clothing",
        colors: ["Grey", "Black", "Navy"],
        description: "Comfortable t-shirt dress for everyday wear",
      ),
      Product(
        title: "Summer Mini Dress",
        price: 49.99,
        image: imgP1,
        category: "Women Clothing",
        colors: ["Pink", "Blue", "White"],
        description: "Light and breezy mini dress for hot days",
      ),
    ],
    'Men Clothing': [
      Product(
        title: "Casual Denim Jacket",
        price: 79.99,
        image:
            "https://i.pinimg.com/564x/8d/c5/0e/8dc50e533b8c8117b7f8f6d8f5349f7b.jpg",
        category: "Men Clothing",
        colors: ["Blue", "Black", "Grey"],
        description: "Stylish denim jacket for a casual look",
      ),
      Product(
        title: "Classic White Shirt",
        price: 45.99,
        image:
            "https://i.pinimg.com/564x/dd/b7/1b/ddb71b88c2428170c7236f5f9f615cbe.jpg",
        category: "Men Clothing",
        colors: ["White", "Light Blue", "Pink"],
        description: "Essential cotton dress shirt for formal occasions",
      ),
      Product(
        title: "Slim Fit Chinos",
        price: 59.99,
        image:
            "https://i.pinimg.com/564x/91/f8/1b/91f81b11f5e9c3962b3c9d524f8f60c4.jpg",
        category: "Men Clothing",
        colors: ["Khaki", "Navy", "Olive"],
        description: "Comfortable slim fit chinos perfect for business casual",
      ),
      Product(
        title: "Wool Blend Sweater",
        price: 89.99,
        image:
            "https://i.pinimg.com/564x/d7/a3/ae/d7a3ae5c686f6e7c88889c4c6b1d2c88.jpg",
        category: "Men Clothing",
        colors: ["Navy", "Charcoal", "Burgundy"],
        description: "Warm wool blend sweater for cold weather",
      ),
      Product(
        title: "Leather Belt",
        price: 34.99,
        image: imgP2,
        category: "Men Clothing",
        colors: ["Brown", "Black", "Tan"],
        description: "Genuine leather belt with classic buckle",
      ),
      Product(
        title: "Casual Polo Shirt",
        price: 39.99,
        image: imgP2,
        category: "Men Clothing",
        colors: ["Navy", "White", "Grey"],
        description: "Classic polo shirt for casual wear",
      ),
      Product(
        title: "Formal Suit",
        price: 299.99,
        image: imgP2,
        category: "Men Clothing",
        colors: ["Black", "Navy", "Charcoal"],
        description: "Premium wool blend suit for formal occasions",
      ),
      Product(
        title: "Sports Shorts",
        price: 29.99,
        image: imgP2,
        category: "Men Clothing",
        colors: ["Black", "Grey", "Navy"],
        description: "Comfortable athletic shorts with pockets",
      ),
      Product(
        title: "Winter Jacket",
        price: 129.99,
        image: imgP2,
        category: "Men Clothing",
        colors: ["Black", "Navy", "Olive"],
        description: "Warm winter jacket with water-resistant finish",
      ),
      Product(
        title: "Dress Shoes",
        price: 89.99,
        image: imgP2,
        category: "Men Clothing",
        colors: ["Black", "Brown", "Tan"],
        description: "Classic leather dress shoes for formal wear",
      ),
    ],
    'Electronics': [
      Product(
        title: "Wireless Mouse",
        price: 29.99,
        image:
            "https://i.pinimg.com/564x/2c/e3/c7/2ce3c7c6c52f9c5283fadae0e309ae3e.jpg",
        category: "Electronics",
        colors: ["Black", "White", "Grey"],
        description: "Ergonomic wireless mouse with long battery life",
      ),
      Product(
        title: "Mechanical Keyboard",
        price: 89.99,
        image:
            "https://i.pinimg.com/564x/f9/6e/fc/f96efc11ed6f1ff8aa4f706159b9df3b.jpg",
        category: "Electronics",
        colors: ["Black", "White", "RGB"],
        description: "Premium mechanical keyboard with customizable switches",
      ),
      Product(
        title: "Gaming Headset",
        price: 69.99,
        image:
            "https://i.pinimg.com/564x/7c/85/c9/7c85c9b58647e2d5b1a9b2ca6c0c5992.jpg",
        category: "Electronics",
        colors: ["Black", "Red", "Blue"],
        description: "Immersive gaming headset with surround sound",
      ),
      Product(
        title: "USB-C Hub",
        price: 45.99,
        image:
            "https://i.pinimg.com/564x/8b/c9/2a/8bc92a9f3289be1834f4f2c564515b6b.jpg",
        category: "Electronics",
        colors: ["Silver", "Space Grey", "Black"],
        description: "Multi-port USB-C hub with power delivery",
      ),
      Product(
        title: "Laptop Stand",
        price: 29.99,
        image:
            "https://i.pinimg.com/564x/4c/52/d4/4c52d4e48451431f25fc3470c6ebf8e4.jpg",
        category: "Electronics",
        colors: ["Silver", "Black", "Rose Gold"],
        description: "Adjustable ergonomic laptop stand for better posture",
      ),
      Product(
        title: "4K Monitor",
        price: 299.99,
        image:
            "https://i.pinimg.com/564x/6b/45/51/6b4551c4f8b58e0f6fc12179c0cfb0c0.jpg",
        category: "Electronics",
        colors: ["Black", "Silver"],
        description: "32-inch 4K Ultra HD monitor with HDR",
      ),
      Product(
        title: "Wireless Keyboard",
        price: 79.99,
        image: imgP3,
        category: "Electronics",
        colors: ["White", "Black", "Grey"],
        description: "Slim wireless keyboard with long battery life",
      ),
      Product(
        title: "External SSD",
        price: 129.99,
        image: imgP3,
        category: "Electronics",
        colors: ["Black", "Blue"],
        description: "1TB portable SSD with USB-C connection",
      ),
      Product(
        title: "Webcam HD",
        price: 59.99,
        image: imgP3,
        category: "Electronics",
        colors: ["Black"],
        description: "1080p HD webcam with built-in microphone",
      ),
      Product(
        title: "Gaming Mouse Pad",
        price: 19.99,
        image: imgP3,
        category: "Electronics",
        colors: ["Black", "RGB"],
        description: "Extended gaming mouse pad with RGB lighting",
      ),
    ],
    'Cars': [
      Product(
        title: "Car Phone Mount",
        price: 19.99,
        image:
            "https://i.pinimg.com/564x/3d/44/54/3d4454624c4354a8956c5474c8baa5c3.jpg",
        category: "Cars",
        colors: ["Black", "Grey", "Silver"],
        description: "Universal car phone mount with strong suction",
      ),
      Product(
        title: "Car Air Freshener",
        price: 9.99,
        image:
            "https://i.pinimg.com/564x/d2/f1/66/d2f166f7edf8596f1c60f2c5ea4ac410.jpg",
        category: "Cars",
        colors: ["Ocean", "Lavender", "Pine"],
        description: "Long-lasting car air freshener with natural scents",
      ),
      Product(
        title: "Tire Pressure Gauge",
        price: 15.99,
        image:
            "https://i.pinimg.com/564x/e5/bd/6e/e5bd6e2e8887646f14b16df4f3e7f9d5.jpg",
        category: "Cars",
        colors: ["Black", "Blue", "Red"],
        description: "Digital tire pressure gauge with LCD display",
      ),
      Product(
        title: "Car Vacuum Cleaner",
        price: 39.99,
        image: imgP4,
        category: "Cars",
        colors: ["Black", "Grey", "White"],
        description: "Portable car vacuum with strong suction power",
      ),
      Product(
          title: "Car Seat Cover",
          price: 49.99,
          image: imgP4,
          category: "Cars",
          colors: ["Black", "Beige", "Grey"],
          description: "Universal fit car seat covers with premium materials"),
      Product(
        title: "Car Dash Cam",
        price: 89.99,
        image:
            "https://i.pinimg.com/564x/b5/c6/ca/b5c6caa3f5c2b18573e7c8e5fcf595c2.jpg",
        category: "Cars",
        colors: ["Black"],
        description: "1080p dash cam with night vision",
      ),
      Product(
        title: "Car Jump Starter",
        price: 79.99,
        image: imgP4,
        category: "Cars",
        colors: ["Red", "Black"],
        description: "Portable jump starter with built-in flashlight",
      ),
      Product(
        title: "Car Floor Mats",
        price: 49.99,
        image: imgP4,
        category: "Cars",
        colors: ["Black", "Beige", "Grey"],
        description: "All-weather floor mats set of 4",
      ),
      Product(
        title: "Car Bluetooth Adapter",
        price: 25.99,
        image: imgP4,
        category: "Cars",
        colors: ["Black"],
        description: "Bluetooth adapter for car audio system",
      ),
      Product(
        title: "Car Trunk Organizer",
        price: 34.99,
        image: imgP4,
        category: "Cars",
        colors: ["Black", "Grey"],
        description: "Collapsible trunk organizer with multiple compartments",
      ),
    ],
    'Kids Clothing': [
      Product(
        title: "Educational Building Blocks",
        price: 34.99,
        image: imgP5,
        category: "Kids Clothing",
        colors: ["Multicolor", "Primary", "Pastel"],
        description: "Educational building blocks for creative play",
      ),
      Product(
        title: "Building Block Robot Kit",
        price: 49.99,
        image: imgP5,
        category: "Kids Clothing",
        colors: ["Blue", "Red", "Yellow"],
        description: "Interactive robot building kit with remote control",
      ),
      Product(
        title: "Art Supply Set",
        price: 29.99,
        image: imgP5,
        category: "Kids Clothing",
        colors: ["Rainbow", "Basic", "Metallic"],
        description: "Complete art set with paints, crayons, and markers",
      ),
      Product(
        title: "Plush Animal Collection",
        price: 19.99,
        image: imgP5,
        category: "Kids Clothing",
        colors: ["Brown", "White", "Grey"],
        description: "Soft and cuddly stuffed animal collection",
      ),
      Product(
          title: "Science Experiment Kit",
          price: 39.99,
          image: imgP5,
          category: "Kids Clothing",
          colors: ["Green", "Blue", "Orange"],
          description: "Educational science kit with 50+ experiments"),
      Product(
        title: "Remote Control Car",
        price: 44.99,
        image: imgP5,
        category: "Kids Clothing",
        colors: ["Red", "Blue", "Green"],
        description: "High-speed RC car with rechargeable battery",
      ),
      Product(
        title: "Board Game Set",
        price: 29.99,
        image: imgP5,
        category: "Kids Clothing",
        colors: ["Multicolor"],
        description: "Classic board games collection",
      ),
      Product(
        title: "Musical Keyboard",
        price: 39.99,
        image: imgP5,
        category: "Kids Clothing",
        colors: ["Pink", "Blue"],
        description: "Kids musical keyboard with learning mode",
      ),
      Product(
        title: "Puzzle Set",
        price: 19.99,
        image: imgP5,
        category: "Kids Clothing",
        colors: ["Multicolor"],
        description: "Set of 4 educational puzzles",
      ),
      Product(
        title: "Drawing Tablet",
        price: 24.99,
        image: imgP5,
        category: "Kids Clothing",
        colors: ["Blue", "Pink", "Green"],
        description: "Digital drawing tablet for kids",
      ),
    ],
    'Sports': [
      Product(
        title: "Basketball",
        price: 19.99,
        image: imgP6,
        category: "Sports",
        colors: ["Red", "White", "Black"],
        description: "Official NBA basketball",
      ),
      Product(
        title: "Tennis Racket",
        price: 129.99,
        image: imgP6,
        category: "Sports",
        colors: ["Black", "White", "Green"],
        description: "Professional tennis racket",
      ),
      Product(
        title: "Football",
        price: 29.99,
        image: imgP6,
        category: "Sports",
        colors: ["Red", "White", "Blue"],
        description: "Official NFL football",
      ),
      Product(
        title: "Treadmill",
        price: 499.99,
        image: imgP6,
        category: "Sports",
        colors: ["Black", "Silver", "Grey"],
        description: "Commercial-grade treadmill for home use",
      ),
      Product(
        title: "Yoga Mat",
        price: 19.99,
        image: imgP6,
        category: "Sports",
        colors: ["Black", "Grey", "Green"],
        description: "Non-slip yoga mat for home workouts",
      ),
      Product(
        title: "Bicycle",
        price: 299.99,
        image: imgP6,
        category: "Sports",
        colors: ["Red", "Black", "White"],
        description: "High-quality bicycle for all terrains",
      ),
      Product(
        title: "Swimming Goggles",
        price: 14.99,
        image: imgP6,
        category: "Sports",
        colors: ["Clear"],
        description: "Clear swimming goggles for water activities",
      ),
      Product(
        title: "Running Shoes",
        price: 89.99,
        image: imgP6,
        category: "Sports",
        colors: ["Black", "White", "Grey"],
        description: "High-performance running shoes",
      ),
      Product(
        title: "Gym Bag",
        price: 29.99,
        image: imgP6,
        category: "Sports",
        colors: ["Black", "Grey", "Red"],
        description: "Durable gym bag for workout essentials",
      ),
      Product(
        title: "Weight Bench",
        price: 199.99,
        image: imgP6,
        category: "Sports",
        colors: ["Black", "Grey", "Red"],
        description: "Adjustable weight bench for home workouts",
      ),
    ],
    'Home Garden': [
      Product(
        title: "Garden Tool Set",
        price: 49.99,
        image: imgP7,
        category: "Home Garden",
        colors: ["Green", "Black"],
        description: "Complete garden tool set with carrying case",
      ),
      Product(
        title: "Plant Pots Set",
        price: 29.99,
        image: imgP7,
        category: "Home Garden",
        colors: ["Terracotta", "White", "Grey"],
        description: "Set of 5 decorative plant pots with drainage",
      ),
      Product(
        title: "Lawn Mower",
        price: 299.99,
        image: imgP7,
        category: "Home Garden",
        colors: ["Green", "Black"],
        description: "Electric lawn mower with grass collection bag",
      ),
      Product(
        title: "Garden Hose",
        price: 34.99,
        image: imgP7,
        category: "Home Garden",
        colors: ["Green", "Blue"],
        description: "50ft expandable garden hose with spray nozzle",
      ),
      Product(
        title: "Solar Garden Lights",
        price: 39.99,
        image: imgP7,
        category: "Home Garden",
        colors: ["Silver", "Bronze", "Black"],
        description: "Set of 8 solar-powered pathway lights",
      ),
      Product(
        title: "Bird Feeder",
        price: 24.99,
        image: imgP7,
        category: "Home Garden",
        colors: ["Brown", "Green"],
        description: "Decorative bird feeder with rain guard",
      ),
      Product(
        title: "Pruning Shears",
        price: 19.99,
        image: imgP7,
        category: "Home Garden",
        colors: ["Red", "Black"],
        description: "Professional grade pruning shears",
      ),
      Product(
        title: "Watering Can",
        price: 15.99,
        image: imgP7,
        category: "Home Garden",
        colors: ["Green", "Blue", "Pink"],
        description: "2-gallon decorative watering can",
      ),
      Product(
        title: "Compost Bin",
        price: 59.99,
        image: imgP7,
        category: "Home Garden",
        colors: ["Black", "Green"],
        description: "Outdoor compost bin with lid",
      ),
      Product(
        title: "Garden Bench",
        price: 129.99,
        image: imgP7,
        category: "Home Garden",
        colors: ["White", "Brown", "Green"],
        description: "Weather-resistant garden bench",
      ),
    ],
    'Beauty': [
      Product(
        title: "Face Cream",
        price: 29.99,
        image: imgP8,
        category: "Beauty",
        colors: ["White", "Pink"],
        description: "Hydrating face cream with vitamin E",
      ),
      Product(
        title: "Lipstick Set",
        price: 39.99,
        image: imgP8,
        category: "Beauty",
        colors: ["Red", "Pink", "Nude"],
        description: "Set of 5 long-lasting lipsticks",
      ),
      Product(
        title: "Hair Dryer",
        price: 79.99,
        image: imgP8,
        category: "Beauty",
        colors: ["Black", "Pink", "White"],
        description: "Professional ionic hair dryer",
      ),
      Product(
        title: "Makeup Brushes",
        price: 49.99,
        image: imgP8,
        category: "Beauty",
        colors: ["Rose Gold", "Black"],
        description: "12-piece makeup brush set with case",
      ),
      Product(
        title: "Perfume",
        price: 89.99,
        image: imgP8,
        category: "Beauty",
        colors: ["Gold", "Silver"],
        description: "Luxury perfume with floral notes",
      ),
      Product(
        title: "Face Mask Set",
        price: 24.99,
        image: imgP8,
        category: "Beauty",
        colors: ["Multi"],
        description: "Set of 10 sheet masks",
      ),
      Product(
        title: "Nail Polish Set",
        price: 34.99,
        image: imgP8,
        category: "Beauty",
        colors: ["Multi"],
        description: "Set of 12 nail polishes",
      ),
      Product(
        title: "Hair Straightener",
        price: 59.99,
        image: imgP8,
        category: "Beauty",
        colors: ["Black", "Pink"],
        description: "Ceramic hair straightener with LCD display",
      ),
      Product(
        title: "Eye Shadow Palette",
        price: 44.99,
        image: imgP8,
        category: "Beauty",
        colors: ["Multi"],
        description: "18-color eyeshadow palette",
      ),
      Product(
        title: "Beauty Mirror",
        price: 69.99,
        image: imgP8,
        category: "Beauty",
        colors: ["White", "Rose Gold"],
        description: "LED lighted makeup mirror",
      ),
    ],
    'Furniture': [
      Product(
        title: "Sofa Set",
        price: 999.99,
        image: imgP9,
        category: "Furniture",
        colors: ["Grey", "Beige", "Blue"],
        description: "3-piece modern sofa set",
      ),
      Product(
        title: "Dining Table",
        price: 599.99,
        image: imgP9,
        category: "Furniture",
        colors: ["Brown", "White", "Black"],
        description: "6-seater wooden dining table",
      ),
      Product(
        title: "Bed Frame",
        price: 499.99,
        image: imgP9,
        category: "Furniture",
        colors: ["Grey", "Brown", "White"],
        description: "Queen size bed frame with headboard",
      ),
      Product(
        title: "Wardrobe",
        price: 399.99,
        image: imgP9,
        category: "Furniture",
        colors: ["White", "Brown", "Black"],
        description: "3-door wardrobe with mirror",
      ),
      Product(
        title: "Coffee Table",
        price: 199.99,
        image: imgP9,
        category: "Furniture",
        colors: ["Walnut", "White", "Black"],
        description: "Modern coffee table with storage",
      ),
      Product(
        title: "Bookshelf",
        price: 149.99,
        image: imgP9,
        category: "Furniture",
        colors: ["White", "Brown", "Black"],
        description: "5-tier bookshelf with adjustable shelves",
      ),
      Product(
        title: "TV Stand",
        price: 249.99,
        image: imgP9,
        category: "Furniture",
        colors: ["Black", "White", "Brown"],
        description: "TV stand with cable management",
      ),
      Product(
        title: "Office Desk",
        price: 299.99,
        image: imgP9,
        category: "Furniture",
        colors: ["White", "Brown", "Black"],
        description: "Computer desk with drawers",
      ),
      Product(
        title: "Accent Chair",
        price: 199.99,
        image: imgP9,
        category: "Furniture",
        colors: ["Grey", "Blue", "Yellow"],
        description: "Modern accent chair with ottoman",
      ),
      Product(
        title: "Side Table",
        price: 89.99,
        image: imgP9,
        category: "Furniture",
        colors: ["White", "Black", "Natural"],
        description: "Wooden side table with shelf",
      ),
    ],
  };

  void increaseQuantity() {
    if (quantity.value < 99) {
      quantity.value++;
    }
  }

  void decreaseQuantity() {
    if (quantity.value > 1) {
      quantity.value--;
    }
  }

  void setColorIndex(int index) {
    colorIndex.value = index;
  }

  void setCurrentCategory(String category) {
    currentCategory.value = category;
  }

  List<Product> getCurrentCategoryProducts() {
    return categoryProducts[currentCategory.value] ?? [];
  }

  void setCurrentProduct({
    required String title,
    required double price,
  }) {
    currentProductTitle.value = title;
    currentProductPrice.value = price;
    // Reset quantity and color when viewing new product
    quantity.value = 1;
    colorIndex.value = 0;
  }

  void toggleFavorite(int index) {
    if (favorites.contains(index)) {
      favorites.remove(index);
    } else {
      favorites.add(index);
    }
  }

  bool isFavorite(int index) {
    return favorites.contains(index);
  }
}
