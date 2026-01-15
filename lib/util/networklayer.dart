import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_tabs/flutter_custom_tabs.dart';
import 'package:http/http.dart' as http;
import 'package:livemenu/model/delivery_model.dart';
import 'package:livemenu/util/constants.dart';

import '../model/dining_model.dart';
import '../model/menu_model.dart';
import '../model/offers_model.dart';

Future<List<DeliveryModel>> fetchDeliveryDetails(http.Client client) async {
  final response = await client.get(Uri.parse(ApiEndPoint.liveMenu));
  // Use the compute function to run parsePhotos in a separate isolate
  return compute(parseData, response.body);
}

// A function that will convert a response body into a List
List<DeliveryModel> parseData(String responseBody) {
  final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();

  List<DeliveryModel> list = parsed
      .map<DeliveryModel>((json) => DeliveryModel.fromJson(json))
      .toList();
  return list;
}

Future<List<DiningModel>> getDining(http.Client client) async {
  final response = await client.get(Uri.parse(ApiEndPoint.dining));
  // Use the compute function to run parsePhotos in a separate isolate
  return compute(parseDiningData, response.body);
}

// A function that will convert a response body into a List
List<DiningModel> parseDiningData(String responseBody) {
  final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();

  List<DiningModel> list =
      parsed.map<DiningModel>((json) => DiningModel.fromJson(json)).toList();
  return list;
}

Future<List<MenuModel>> getMenu(http.Client client) async {
  final response = await client.get(Uri.parse(ApiEndPoint.menu));
  // Use the compute function to run parsePhotos in a separate isolate
  return compute(parseDiningMenu, response.body);
}

// A function that will convert a response body into a List
List<MenuModel> parseDiningMenu(String responseBody) {
  final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();

  List<MenuModel> list =
      parsed.map<MenuModel>((json) => MenuModel.fromJson(json)).toList();
  return list;
}

Future<List<OfferModel>> getOffers(http.Client client) async {
  final response = await client.get(Uri.parse(ApiEndPoint.offers));
  // Use the compute function to run parsePhotos in a separate isolate
  return compute(parseOffers, response.body);
}

// A function that will convert a response body into a List
List<OfferModel> parseOffers(String responseBody) {
  final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();

  List<OfferModel> list =
      parsed.map<OfferModel>((json) => OfferModel.fromJson(json)).toList();
  return list;
}

Future<void> launchURL(BuildContext context, String url) async {
  final theme = Theme.of(context);
  try {
    await launchUrl(
      Uri.parse(url),
      customTabsOptions: CustomTabsOptions(
        colorSchemes: CustomTabsColorSchemes.defaults(
          toolbarColor: theme.primaryColor,
        ),
        shareState: CustomTabsShareState.on,
        urlBarHidingEnabled: true,
        showTitle: true,
        animations: CustomTabsSystemAnimations.slideIn(),
        browser: const CustomTabsBrowserConfiguration(
          fallbackCustomTabs: [
            'org.mozilla.firefox',
            'com.microsoft.emmx',
          ],
        ),
      ),
      safariVCOptions: SafariViewControllerOptions(
        preferredBarTintColor: theme.primaryColor,
        preferredControlTintColor: Colors.white,
        barCollapsingEnabled: true,
        entersReaderIfAvailable: false,
        dismissButtonStyle: SafariViewControllerDismissButtonStyle.close,
      ),
    );
  } catch (e) {
    // An exception is thrown if browser app is not installed on Android device.
    debugPrint(e.toString());
  }
}
