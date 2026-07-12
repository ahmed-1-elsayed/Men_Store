class CartModel {
  final List<CartItemModel> products;
  final double total;
  final double discountedTotal;

  CartModel({
    required this.products,
    required this.total,
    required this.discountedTotal,
  });

  factory CartModel.fromJson(Map<String, dynamic> json) {
    return CartModel(
      products: (json['products'] as List)
          .map((e) => CartItemModel.fromJson(e))
          .toList(),
      total: (json['total'] as num).toDouble(),
      discountedTotal: (json['discountedTotal'] as num).toDouble(),
    );
  }
}

class CartItemModel {
  final int id;
  final String title;
  final double price;
  final int quantity;
  final String thumbnail;

  CartItemModel({
    required this.id,
    required this.title,
    required this.price,
    required this.quantity,
    required this.thumbnail,
  });

  factory CartItemModel.fromJson(Map<String, dynamic> json) {
    return CartItemModel(
      id: json['id'],
      title: json['title'],
      price: (json['price'] as num).toDouble(),
      quantity: json['quantity'],
      thumbnail: json['thumbnail'],
    );
  }
}