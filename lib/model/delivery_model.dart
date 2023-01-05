class DeliveryModel {
  String title;
  String price;
  String rating;
  String offer;
  String address;
  String desc;
  String imageUrl;

  DeliveryModel(
      {this.title,
      this.price,
      this.rating,
      this.offer,
      this.address,
      this.desc,
      this.imageUrl});

  factory DeliveryModel.fromJson(Map<String, dynamic> json) {
    return new DeliveryModel(
      title: json['title'] as String,
      price: json['price'] as String,
      rating: json['rating'] as String,
      offer: json['offer'] as String,
      address: json['address'] as String,
      desc: json['desc'] as String,
      imageUrl: json['imageUrl'] as String,
    );
  }
}
