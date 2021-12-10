class Popular {
  String title;
  String price;
  String rating;
  String imageUrl;

  Popular({this.title, this.price, this.rating, this.imageUrl});

  factory Popular.fromJson(Map<String, dynamic> json) {
    return new Popular(
      title: json['title'] as String,
      price: json['price'] as String,
      rating: json['rating'] as String,
      imageUrl: json['imageUrl'] as String,
    );
  }
}
