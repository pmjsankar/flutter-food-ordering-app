import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:livemenu/popular.dart';

import 'DiningModel.dart';

Future<List<Popular>> fetchCountry(http.Client client) async {
  final response =
      await client.get(Uri.parse('https://demo1784049.mockable.io/livemenu'));
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

Future<List<DiningModel>> getDining(http.Client client) async {
  final response =
      await client.get(Uri.parse('https://demo1784049.mockable.io/dining'));
  // Use the compute function to run parsePhotos in a separate isolate
  return compute(parseDiningData, response.body);
}

// A function that will convert a response body into a List<Popular>
List<DiningModel> parseDiningData(String responseBody) {
  final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();

  List<DiningModel> list = parsed
      .map<DiningModel>((json) => new DiningModel.fromJson(json))
      .toList();
  return list;
}
