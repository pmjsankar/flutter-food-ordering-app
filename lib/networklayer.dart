import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:livemenu/delivery_model.dart';

import 'dining_model.dart';
import 'menu_model.dart';

Future<List<DeliveryModel>> fetchDeliveryDetails(http.Client client) async {
  final response =
      await client.get(Uri.parse('https://demo1784049.mockable.io/livemenu'));
  // Use the compute function to run parsePhotos in a separate isolate
  return compute(parseData, response.body);
}

// A function that will convert a response body into a List
List<DeliveryModel> parseData(String responseBody) {
  final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();

  List<DeliveryModel> list = parsed
      .map<DeliveryModel>((json) => new DeliveryModel.fromJson(json))
      .toList();
  return list;
}

Future<List<DiningModel>> getDining(http.Client client) async {
  final response =
      await client.get(Uri.parse('https://demo1784049.mockable.io/dining'));
  // Use the compute function to run parsePhotos in a separate isolate
  return compute(parseDiningData, response.body);
}

// A function that will convert a response body into a List
List<DiningModel> parseDiningData(String responseBody) {
  final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();

  List<DiningModel> list = parsed
      .map<DiningModel>((json) => new DiningModel.fromJson(json))
      .toList();
  return list;
}

Future<List<MenuModel>> getMenu(http.Client client) async {
  final response =
      await client.get(Uri.parse('https://demo1784049.mockable.io/menu'));
  // Use the compute function to run parsePhotos in a separate isolate
  return compute(parseDiningMenu, response.body);
}

// A function that will convert a response body into a List
List<MenuModel> parseDiningMenu(String responseBody) {
  final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();

  List<MenuModel> list =
      parsed.map<MenuModel>((json) => new MenuModel.fromJson(json)).toList();
  return list;
}
