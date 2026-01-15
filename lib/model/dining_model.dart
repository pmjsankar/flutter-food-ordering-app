class DiningModel {
  final String title;
  final String rating;
  final String offer;
  final String address;
  final String timing;
  final String map;
  final String desc;
  final String imageUrl;

  DiningModel({
    required this.title,
    required this.rating,
    required this.offer,
    required this.address,
    required this.timing,
    required this.map,
    required this.desc,
    required this.imageUrl,
  });

  factory DiningModel.fromJson(Map<String, dynamic> json) {
    return DiningModel(
      title: json['title'] as String,
      rating: json['rating'] as String,
      offer: json['offer'] as String,
      address: json['address'] as String,
      timing: json['timing'] as String,
      map: json['map'] as String,
      desc: json['desc'] as String,
      imageUrl: json['imageUrl'] as String,
    );
  }
}
