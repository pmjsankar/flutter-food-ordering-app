import 'dart:convert';

class LocationModel {
  final String title;
  final String address;
  final String type;
  final bool selected;

  LocationModel({
    required this.title,
    required this.address,
    required this.type,
    required this.selected,
  });

  factory LocationModel.fromJson(Map<String, dynamic> json) {
    return LocationModel(
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

  static Map<String, dynamic> toMap(LocationModel location) => {
        'title': location.title,
        'address': location.address,
        'type': location.type,
        'selected': location.selected,
      };

  static String encode(List<LocationModel> locations) => json.encode(
        locations
            .map<Map<String, dynamic>>((loc) => LocationModel.toMap(loc))
            .toList(),
      );

  static List<LocationModel> decode(String locations) =>
      (json.decode(locations) as List<dynamic>)
          .map<LocationModel>((item) => LocationModel.fromJson(item))
          .toList();
}
