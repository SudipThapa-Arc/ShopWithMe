import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class ProductService extends GetxService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<Map<String, dynamic>>> searchProducts({
    required String query,
    String? sortBy,
  }) async {
    Query productsQuery = _firestore.collection('products');

    // Apply search query
    if (query.isNotEmpty) {
      productsQuery = productsQuery.where(
        'searchKeywords',
        arrayContains: query.toLowerCase(),
      );
    }

    // Apply sorting
    switch (sortBy) {
      case 'price_asc':
        productsQuery = productsQuery.orderBy('price', descending: false);
        break;
      case 'price_desc':
        productsQuery = productsQuery.orderBy('price', descending: true);
        break;
      case 'rating':
        productsQuery = productsQuery.orderBy('rating', descending: true);
        break;
      case 'newest':
        productsQuery = productsQuery.orderBy('createdAt', descending: true);
        break;
      default:
        // Default sorting by relevance (if no sort specified)
        break;
    }

    final snapshot = await productsQuery.get();
    return snapshot.docs.map((doc) => {
      'id': doc.id,
      ...doc.data() as Map<String, dynamic>,
    }).toList();
  }

  Future<Map<String, dynamic>?> getProductById(String productId) async {
    final doc = await _firestore.collection('products').doc(productId).get();
    if (!doc.exists) return null;
    return {
      'id': doc.id,
      ...doc.data()!,
    };
  }

  Future<List<Map<String, dynamic>>> getProductsByCategory(String category) async {
    final snapshot = await _firestore
        .collection('products')
        .where('category', isEqualTo: category)
        .get();

    return snapshot.docs.map((doc) => {
      'id': doc.id,
      ...doc.data(),
    }).toList();
  }

  Future<List<Map<String, dynamic>>> getFeaturedProducts() async {
    final snapshot = await _firestore
        .collection('products')
        .where('featured', isEqualTo: true)
        .limit(10)
        .get();

    return snapshot.docs.map((doc) => {
      'id': doc.id,
      ...doc.data(),
    }).toList();
  }

  Future<List<String>> getCategories() async {
    final snapshot = await _firestore.collection('categories').get();
    return snapshot.docs.map((doc) => doc.id).toList();
  }
} 