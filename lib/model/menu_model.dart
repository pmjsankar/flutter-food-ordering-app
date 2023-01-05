class MenuModel {
  String title;
  String rating;
  int price;
  bool veg;
  bool available;
  String imageUrl;

  MenuModel(
      {this.title,
      this.rating,
      this.price,
      this.veg,
      this.available,
      this.imageUrl});

  factory MenuModel.fromJson(Map<String, dynamic> json) {
    return new MenuModel(
      title: json['title'] as String,
      rating: json['rating'] as String,
      price: json['price'] as int,
      veg: json['veg'] as bool,
      available: json['available'] as bool,
      imageUrl: json['imageUrl'] as String,
    );
  }
}
