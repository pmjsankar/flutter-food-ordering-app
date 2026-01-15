class DeliveryModel {
  final String title;
  final String price;
  final String rating;
  final String offer;
  final String address;
  final String desc;
  final String imageUrl;

  DeliveryModel({
    required this.title,
    required this.price,
    required this.rating,
    required this.offer,
    required this.address,
    required this.desc,
    required this.imageUrl,
  });

  factory DeliveryModel.fromJson(Map<String, dynamic> json) {
    return DeliveryModel(
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
