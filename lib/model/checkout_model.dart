class CheckoutModel {
  String title;
  int price;
  int quantity;
  bool veg;
  String imageUrl;

  CheckoutModel(
      {this.title, this.price, this.quantity, this.veg, this.imageUrl});

  factory CheckoutModel.fromJson(Map<String, dynamic> json) {
    return new CheckoutModel(
      title: json['title'] as String,
      price: json['price'] as int,
      quantity: json['quantity'] as int,
      veg: json['veg'] as bool,
      imageUrl: json['imageUrl'] as String,
    );
  }
}
