class LocationModel {
  String title;
  String address;
  String type;
  bool selected;

  LocationModel({
    this.title,
    this.address,
    this.type,
    this.selected,
  });

  factory LocationModel.fromJson(Map<String, dynamic> json) {
    return new LocationModel(
      title: json['title'] as String,
      address: json['address'] as String,
      type: json['type'] as String,
      selected: json['selected'] as bool,
    );
  }

  Map<String, dynamic> toJson() => {
        'title': title,
        'address': address,
        'type': type,
        'selected': selected,
      };
}
