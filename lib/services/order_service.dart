import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import '../models/order.dart' as models;

class OrderService extends GetxService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<models.Order> createOrder(models.Order order) async {
    final docRef = await _firestore.collection('orders').add(order.toJson());
    order.id = docRef.id;
    return order;
  }

  Future<List<models.Order>> getUserOrders(String userId) async {
    final snapshot = await _firestore
        .collection('orders')
        .where('userId', isEqualTo: userId)
        .orderBy('createdAt', descending: true)
        .get();

    return snapshot.docs
        .map((doc) => models.Order.fromJson({...doc.data(), 'id': doc.id}))
        .toList();
  }

  Future<models.Order?> getOrderById(String orderId) async {
    final doc = await _firestore.collection('orders').doc(orderId).get();
    if (!doc.exists) return null;
    return models.Order.fromJson({...doc.data()!, 'id': doc.id});
  }

  Future<void> updateOrderStatus(String orderId, String status) async {
    await _firestore.collection('orders').doc(orderId).update({
      'status': status,
    });
  }
} 