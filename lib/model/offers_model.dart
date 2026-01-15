class OfferModel {
  final String code;
  final String title;
  final String desc;
  final bool available;
  final String imageUrl;

  OfferModel({
    required this.code,
    required this.title,
    required this.desc,
    required this.available,
    required this.imageUrl,
  });

  factory OfferModel.fromJson(Map<String, dynamic> json) {
    return OfferModel(
      code: json['code'] as String,
      title: json['title'] as String,
      desc: json['desc'] as String,
      available: json['available'] as bool,
      imageUrl: json['imageUrl'] as String,
    );
  }
}
