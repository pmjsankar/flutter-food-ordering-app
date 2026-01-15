class MenuModel {
  final String title;
  final String rating;
  final int price;
  final bool veg;
  final bool available;
  final String imageUrl;

  MenuModel({
    required this.title,
    required this.rating,
    required this.price,
    required this.veg,
    required this.available,
    required this.imageUrl,
  });

  factory MenuModel.fromJson(Map<String, dynamic> json) {
    return MenuModel(
      title: json['title'] as String,
      rating: json['rating'] as String,
      price: json['price'] as int,
      veg: json['veg'] as bool,
      available: json['available'] as bool,
      imageUrl: json['imageUrl'] as String,
    );
  }
}
