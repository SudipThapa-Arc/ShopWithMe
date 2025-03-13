class Order {
  final List<dynamic> items;
  final Map<String, dynamic> shippingAddress;
  final Map<String, dynamic> paymentMethod;
  final String status;
  final DateTime createdAt;
  String? id;

  Order({
    required this.items,
    required this.shippingAddress,
    required this.paymentMethod,
    required this.status,
    required this.createdAt,
    this.id,
  });

  Map<String, dynamic> toJson() {
    return {
      'items': items,
      'shippingAddress': shippingAddress,
      'paymentMethod': paymentMethod,
      'status': status,
      'createdAt': createdAt.toIso8601String(),
      'id': id,
    };
  }

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      items: json['items'] as List<dynamic>,
      shippingAddress: json['shippingAddress'] as Map<String, dynamic>,
      paymentMethod: json['paymentMethod'] as Map<String, dynamic>,
      status: json['status'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      id: json['id'] as String?,
    );
  }
} 