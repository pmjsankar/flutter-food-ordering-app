import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:live_menu_flutter/popular.dart';
import 'package:http/http.dart' as http;

Future<List<Popular>> fetchCountry(http.Client client) async {
  final response = await client.get('https://demo3570707.mockable.io/livemenu');
  // Use the compute function to run parsePhotos in a separate isolate
  return compute(parseData, response.body);
}

// A function that will convert a response body into a List<Popular>
List<Popular> parseData(String responseBody) {
  final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();

  List<Popular> list =
      parsed.map<Popular>((json) => new Popular.fromJson(json)).toList();
  return list;
}
