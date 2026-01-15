class CheckoutModel {
  final String title;
  final int price;
  int quantity;
  final bool veg;
  final String imageUrl;

  CheckoutModel({
    required this.title,
    required this.price,
    required this.quantity,
    required this.veg,
    required this.imageUrl,
  });

  factory CheckoutModel.fromJson(Map<String, dynamic> json) {
    return CheckoutModel(
      title: json['title'] as String,
      price: json['price'] as int,
      quantity: json['quantity'] as int,
      veg: json['veg'] as bool,
      imageUrl: json['imageUrl'] as String,
    );
  }
}
