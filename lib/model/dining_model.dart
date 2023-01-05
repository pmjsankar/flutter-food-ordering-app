class DiningModel {
  String title;
  String rating;
  String offer;
  String address;
  String timing;
  String map;
  String desc;
  String imageUrl;

  DiningModel(
      {this.title,
      this.rating,
      this.offer,
      this.address,
      this.timing,
      this.map,
      this.desc,
      this.imageUrl});

  factory DiningModel.fromJson(Map<String, dynamic> json) {
    return new DiningModel(
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
