import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopwithme/design_system/colors.dart';
import 'package:shopwithme/design_system/typography.dart';
import 'package:shopwithme/design_system/spacing.dart';
import 'package:shopwithme/common_widgets/product_card.dart';
import 'package:shopwithme/common_widgets/empty_state_widget.dart';
import 'package:shopwithme/models/product_model.dart';
import 'package:shopwithme/controllers/product_controller.dart';

class WishlistScreen extends StatelessWidget {
  const WishlistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.find<ProductController>();
    
    // Mock data - replace with actual wishlist items
    final List<Map<String, dynamic>> wishlistItems = [
      {
        'id': '1',
        'name': 'Classic White Sneakers',
        'price': 79.99,
        'image': 'https://example.com/sneakers.jpg',
        'rating': 4.5,
      },
      {
        'id': '2',
        'name': 'Leather Crossbody Bag',
        'price': 129.99,
        'image': 'https://example.com/bag.jpg',
        'rating': 4.8,
      },
    ];

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.surface,
        elevation: 0,
        title: Text(
          'Wishlist',
          style: AppTypography.titleLarge,
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.textPrimary),
          onPressed: () => Get.back(),
        ),
      ),
      body: wishlistItems.isEmpty
          ? const EmptyStateWidget(
              icon: Icons.favorite_border,
              title: 'Your Wishlist is Empty',
              message: 'Save items you love in your wishlist',
            )
          : GridView.builder(
              padding: EdgeInsets.all(Spacing.md),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.7,
                crossAxisSpacing: Spacing.md,
                mainAxisSpacing: Spacing.md,
              ),
              itemCount: wishlistItems.length,
              itemBuilder: (context, index) {
                final item = wishlistItems[index];
                return ProductCard(
                  product: Product(
                    id: item['id'],
                    title: item['name'],
                    price: item['price'],
                    image: item['image'],
                    rating: item['rating'],
                    category: 'Wishlist',  // Default category
                    colors: [],    // Required field
                    description: '', // Required field
                    brand: '',      // Required field
                    material: '',   // Required field
                  ),
                  onTap: () {
                    // Navigate to product details
                  },
                );
              },
            ),
    );
  }
} 