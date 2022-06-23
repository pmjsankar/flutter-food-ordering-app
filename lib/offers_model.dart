class OfferModel {
  String code;
  String title;
  String desc;
  bool available;
  String imageUrl;

  OfferModel({this.code, this.title, this.desc, this.available, this.imageUrl});

  factory OfferModel.fromJson(Map<String, dynamic> json) {
    return new OfferModel(
      code: json['code'] as String,
      title: json['title'] as String,
      desc: json['desc'] as String,
      available: json['available'] as bool,
      imageUrl: json['imageUrl'] as String,
    );
  }
}
