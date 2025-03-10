import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopwithme/controllers/product_controller.dart';
import 'package:shopwithme/design_system/colors.dart';
import 'package:shopwithme/design_system/spacing.dart';
import 'package:shopwithme/design_system/typography.dart';
import 'package:shopwithme/common_widgets/shimmer_loading.dart';
import 'package:shopwithme/common_widgets/error_widgets.dart' as app_errors;
import 'package:shopwithme/views/category_screen/product_details.dart';
import 'package:shopwithme/models/product_model.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  final ProductController _productController = Get.find<ProductController>();
  final RxList<String> _recentSearches = <String>[].obs;
  final RxList<String> _popularSearches = <String>[
    'Summer Dress',
    'Smartphone',
    'Headphones',
    'Running Shoes',
    'Coffee Maker',
  ].obs;
  final RxString _query = ''.obs;
  final RxBool _isSearching = false.obs;
  final RxList<Product> _searchResults = <Product>[].obs;
  final RxBool _isLoading = false.obs;
  final RxBool _hasError = false.obs;

  @override
  void initState() {
    super.initState();
    _loadRecentSearches();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _loadRecentSearches() {
    // In a real app, you would load these from local storage
    _recentSearches.value = [
      'Black Dress',
      'Wireless Earbuds',
      'Kitchen Gadgets',
    ];
  }

  void _saveSearch(String query) {
    if (query.isNotEmpty && !_recentSearches.contains(query)) {
      _recentSearches.insert(0, query);
      if (_recentSearches.length > 5) {
        _recentSearches.removeLast();
      }
      // In a real app, save to local storage here
    }
  }

  void _clearRecentSearches() {
    _recentSearches.clear();
    // In a real app, clear from local storage here
  }

  void _performSearch(String query) {
    if (query.isEmpty) return;
    
    _query.value = query;
    _isSearching.value = true;
    _isLoading.value = true;
    _hasError.value = false;
    
    // Save search query
    _saveSearch(query);
    
    // Simulate network delay
    Future.delayed(Duration(milliseconds: 800), () {
      try {
        // Search across all categories
        List<Product> results = [];
        _productController.categoryProducts.forEach((category, products) {
          results.addAll(products.where((product) => 
            product.title.toLowerCase().contains(query.toLowerCase()) ||
            product.description.toLowerCase().contains(query.toLowerCase()) ||
            product.category.toLowerCase().contains(query.toLowerCase()) ||
            product.brand.toLowerCase().contains(query.toLowerCase())
          ));
        });
        
        _searchResults.value = results;
        _isLoading.value = false;
      } catch (e) {
        _hasError.value = true;
        _isLoading.value = false;
        print('Search error: $e');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.surface,
        elevation: 0,
        title: TextField(
          controller: _searchController,
          decoration: InputDecoration(
            hintText: 'Search products...',
            hintStyle: TextStyle(color: AppColors.textSecondary),
            border: InputBorder.none,
            contentPadding: EdgeInsets.symmetric(vertical: 15),
          ),
          style: AppTypography.bodyLarge,
          textInputAction: TextInputAction.search,
          onSubmitted: _performSearch,
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: AppColors.textPrimary),
          onPressed: () => Get.back(),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.clear, color: AppColors.textPrimary),
            onPressed: () {
              _searchController.clear();
              _query.value = '';
              _isSearching.value = false;
            },
          ),
          IconButton(
            icon: Icon(Icons.search, color: AppColors.primary),
            onPressed: () => _performSearch(_searchController.text),
          ),
        ],
      ),
      body: Obx(() {
        // Show loading state
        if (_isLoading.value) {
          return _buildLoadingState();
        }
        
        // Show error state
        if (_hasError.value) {
          return app_errors.ErrorWidget.network(
            onRetry: () => _performSearch(_query.value),
          );
        }
        
        // Show search results
        if (_isSearching.value) {
          if (_searchResults.isEmpty) {
            return app_errors.EmptyStateWidget.search(
              onAction: () {
                _isSearching.value = false;
                _searchController.clear();
              },
            );
          }
          
          return _buildSearchResults();
        }
        
        // Show search suggestions
        return _buildSearchSuggestions();
      }),
    );
  }

  Widget _buildLoadingState() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(Spacing.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Search results loading shimmer
          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: 3,
            itemBuilder: (context, index) => Padding(
              padding: EdgeInsets.only(bottom: Spacing.md),
              child: Row(
                children: [
                  ShimmerLoading.rectangular(
                    width: 80,
                    height: 80,
                    shapeBorder: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  SizedBox(width: Spacing.md),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ShimmerLoading.rectangular(height: 16),
                        SizedBox(height: Spacing.sm),
                        ShimmerLoading.rectangular(height: 14, width: 100),
                        SizedBox(height: Spacing.sm),
                        ShimmerLoading.rectangular(height: 14, width: 60),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchResults() {
    return ListView.builder(
      padding: EdgeInsets.all(Spacing.md),
      itemCount: _searchResults.length,
      itemBuilder: (context, index) {
        final product = _searchResults[index];
        return InkWell(
          onTap: () {
            _productController.currentProduct.value = product;
            Get.to(() => ItemDetails(title: product.title));
          },
          child: Container(
            margin: EdgeInsets.only(bottom: Spacing.md),
            padding: EdgeInsets.all(Spacing.md),
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              children: [
                // Product Image
                Hero(
                  tag: 'search_${product.id}_image',
                  child: Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      image: DecorationImage(
                        image: NetworkImage(product.image),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: Spacing.md),
                
                // Product Details
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        product.title,
                        style: Theme.of(context).textTheme.titleMedium,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: Spacing.xs),
                      Text(
                        product.category,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AppColors.textSecondary,
                        ),
                      ),
                      SizedBox(height: Spacing.xs),
                      Text(
                        '\$${product.price.toStringAsFixed(2)}',
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          color: AppColors.primary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                
                // Arrow icon
                Icon(
                  Icons.arrow_forward_ios,
                  size: 16,
                  color: AppColors.textSecondary,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildSearchSuggestions() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(Spacing.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Recent searches
          if (_recentSearches.isNotEmpty) ...[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Recent Searches',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                TextButton(
                  onPressed: _clearRecentSearches,
                  child: Text(
                    'Clear',
                    style: Theme.of(context).textTheme.labelMedium?.copyWith(
                      color: AppColors.primary,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: Spacing.sm),
            Wrap(
              spacing: Spacing.sm,
              runSpacing: Spacing.sm,
              children: _recentSearches.map((search) => InkWell(
                onTap: () {
                  _searchController.text = search;
                  _performSearch(search);
                },
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: Spacing.md,
                    vertical: Spacing.sm,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.surface,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: AppColors.neutral),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.history,
                        size: 16,
                        color: AppColors.textSecondary,
                      ),
                      SizedBox(width: Spacing.xs),
                      Text(
                        search,
                        style: AppTypography.bodyMedium,
                      ),
                    ],
                  ),
                ),
              )).toList(),
            ),
            SizedBox(height: Spacing.lg),
          ],
          
          // Popular searches
          Text(
            'Popular Searches',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          SizedBox(height: Spacing.sm),
          Wrap(
            spacing: Spacing.sm,
            runSpacing: Spacing.sm,
            children: _popularSearches.map((search) => InkWell(
              onTap: () {
                _searchController.text = search;
                _performSearch(search);
              },
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: Spacing.md,
                  vertical: Spacing.sm,
                ),
                decoration: BoxDecoration(
                  color: AppColors.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.trending_up,
                      size: 16,
                      color: AppColors.primary,
                    ),
                    SizedBox(width: Spacing.xs),
                    Text(
                      search,
                      style: AppTypography.bodyMedium.copyWith(
                        color: AppColors.primary,
                      ),
                    ),
                  ],
                ),
              ),
            )).toList(),
          ),
          
          // Categories
          SizedBox(height: Spacing.lg),
          Text(
            'Browse Categories',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          SizedBox(height: Spacing.md),
          GridView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 1.5,
              crossAxisSpacing: Spacing.md,
              mainAxisSpacing: Spacing.md,
            ),
            itemCount: _productController.categoryProducts.length,
            itemBuilder: (context, index) {
              final category = _productController.categoryProducts.keys.elementAt(index);
              return InkWell(
                onTap: () {
                  _searchController.text = category;
                  _performSearch(category);
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColors.surface,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 10,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        _getCategoryIcon(category),
                        size: 32,
                        color: AppColors.primary,
                      ),
                      SizedBox(height: Spacing.sm),
                      Text(
                        category,
                        style: Theme.of(context).textTheme.titleSmall,
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  IconData _getCategoryIcon(String category) {
    switch (category.toLowerCase()) {
      case 'women clothing':
        return Icons.woman;
      case 'men clothing':
        return Icons.man;
      case 'electronics':
        return Icons.devices;
      case 'accessories':
        return Icons.watch;
      case 'home & kitchen':
        return Icons.kitchen;
      case 'beauty':
        return Icons.face;
      case 'kids':
        return Icons.child_care;
      case 'sports':
        return Icons.sports_soccer;
      default:
        return Icons.category;
    }
  }
} 