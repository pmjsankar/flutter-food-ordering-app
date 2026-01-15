import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:livemenu/model/delivery_model.dart';
import 'package:livemenu/offers.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/checkout_model.dart';
import '../model/location_model.dart';
import '../util/constants.dart';

class Checkout extends StatefulWidget {
  final DeliveryModel obj;
  final int totalPrice;
  final int deliveryFee = 24;
  final int tax = 8;
  final List<CheckoutModel> selectedItems;

  const Checkout(
      {super.key,
      required this.obj,
      required this.selectedItems,
      required this.totalPrice});

  @override
  _Checkout createState() => _Checkout();
}

class _Checkout extends State<Checkout> {
  var itemAddedToCart = false;
  LocationModel location = LocationModel(
      title: '5C, Sunrise Apartments',
      address: 'Kakkanad, Kochi',
      type: 'Other',
      selected: true);

  @override
  void initState() {
    savedLocation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark));

    int totalPay = widget.totalPrice + widget.deliveryFee + widget.tax;
    return Scaffold(
        body: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Padding(
                padding:
                    const EdgeInsets.only(left: 10.0, right: 10, top: 60.0),
                child: InkWell(
                  child: const Icon(
                    Icons.arrow_back,
                    color: Colors.black54,
                    size: 32,
                  ),
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                )),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 3.0, top: 60.0),
                child: Text(
                  widget.obj.title,
                  style: const TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Padding(
                padding:
                    const EdgeInsets.only(left: 10.0, right: 10, top: 60.0),
                child: InkWell(
                  child: const Icon(
                    Icons.local_offer,
                    color: Colors.orange,
                    size: 24,
                  ),
                  onTap: () => Navigator.push(context,
                      MaterialPageRoute(builder: (_) => const Offers())),
                )),
          ],
        ),
        const Padding(
          padding: EdgeInsets.only(top: 10, bottom: 10),
          child: Divider(
            height: 1,
            indent: 6,
            endIndent: 6,
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding:
                  const EdgeInsets.only(bottom: 5, left: 16, right: 2, top: 2),
              child: InkWell(
                child: const Icon(
                  Icons.location_on_rounded,
                  color: Colors.red,
                ),
                onTap: () {},
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(bottom: 5, left: 6, right: 2, top: 2),
              child: Text(
                'Delivery at ',
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontSize: 14.0,
                  color: Colors.black54,
                  fontWeight: FontWeight.normal,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Flexible(
                child: Padding(
              padding:
                  const EdgeInsets.only(bottom: 5, left: 14, right: 10, top: 2),
              child: Text(
                '${location.title}, ${location.address}',
                textAlign: TextAlign.start,
                style: const TextStyle(
                  fontSize: 14.0,
                  color: Colors.black,
                  fontWeight: FontWeight.normal,
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: 3,
              ),
            )),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding:
                  const EdgeInsets.only(bottom: 5, left: 16, right: 2, top: 2),
              child: InkWell(
                child: const Icon(
                  Icons.timer,
                  color: Colors.green,
                ),
                onTap: () {},
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(bottom: 5, left: 7, right: 16, top: 2),
              child: Text(
                'Delivery in ',
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontSize: 14.0,
                  color: Colors.black54,
                  fontWeight: FontWeight.normal,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const Text(
              '26 mins',
              textAlign: TextAlign.start,
              style: TextStyle(
                fontSize: 14.0,
                color: Colors.black,
                fontWeight: FontWeight.normal,
              ),
            ),
          ],
        ),
        const Divider(
          indent: 10,
          endIndent: 10,
          color: Colors.grey,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding:
                  const EdgeInsets.only(bottom: 5, left: 16, right: 2, top: 20),
              child: InkWell(
                child: const Icon(
                  Icons.fastfood,
                  color: Colors.green,
                ),
                onTap: () {},
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(bottom: 5, left: 7, right: 16, top: 20),
              child: Text(
                'Your Order',
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontSize: 18.0,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 200,
          child: ListView.builder(
              physics: const ScrollPhysics(),
              shrinkWrap: true,
              padding: const EdgeInsets.only(top: 6),
              itemCount: widget.selectedItems.length,
              itemBuilder: (context, index) {
                return getListItem(widget.selectedItems[index], index, context);
              }),
        ),
        const Divider(
          thickness: 1,
          indent: 16,
          endIndent: 16,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Padding(
              padding: EdgeInsets.only(bottom: 5, left: 48, right: 16, top: 0),
              child: Text(
                'Delivery Fee',
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontSize: 14.0,
                  color: Colors.black,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  bottom: 5, left: 16, right: 20, top: 14),
              child: Text(
                '₹${widget.deliveryFee}',
                textAlign: TextAlign.start,
                style: const TextStyle(
                  fontSize: 14.0,
                  color: Colors.black54,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Padding(
              padding: EdgeInsets.only(bottom: 5, left: 48, right: 16, top: 0),
              child: Text(
                'Taxes & Charges',
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontSize: 14.0,
                  color: Colors.black,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  bottom: 5, left: 16, right: 20, top: 14),
              child: Text(
                '₹${widget.tax}',
                textAlign: TextAlign.start,
                style: const TextStyle(
                  fontSize: 14.0,
                  color: Colors.black54,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        const Divider(
          thickness: 1,
          indent: 16,
          endIndent: 16,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Padding(
              padding: EdgeInsets.only(bottom: 5, left: 48, right: 16, top: 0),
              child: Text(
                'To Pay',
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  bottom: 5, left: 16, right: 20, top: 14),
              child: Text(
                '₹$totalPay',
                textAlign: TextAlign.start,
                style: const TextStyle(
                  fontSize: 16.0,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        const Divider(
          thickness: 5,
          indent: 16,
          endIndent: 16,
        ),
        Expanded(
          child: Align(
            alignment: FractionalOffset.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                        bottom: 5, left: 48, right: 8, top: 0),
                    child: Text(
                      '₹$totalPay',
                      textAlign: TextAlign.start,
                      style: const TextStyle(
                        fontSize: 18.0,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        bottom: 15, left: 8, right: 20, top: 14),
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        foregroundColor: Colors.white,
                      ),
                      onPressed: () {
                        // Respond to button press
                      },
                      label: const Padding(
                        padding: EdgeInsets.only(
                            top: 12, bottom: 12, left: 10, right: 10),
                        child: Text(
                          "MAKE PAYMENT",
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      icon: const Icon(
                        Icons.done,
                        size: 18,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    ));
  }

  Container getListItem(CheckoutModel obj, int index, BuildContext context) {
    return Container(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 12, left: 16),
                    padding: const EdgeInsets.all(2),
                    decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.circular(3),
                        border: Border.all(width: 2, color: Colors.green)),
                    child: const Icon(
                      Icons.circle,
                      color: Colors.green,
                      size: 8,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        bottom: 5, left: 16, right: 16, top: 20),
                    child: Text(
                      obj.title,
                      textAlign: TextAlign.start,
                      style: const TextStyle(
                        fontSize: 16.0,
                        color: Colors.black,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(
                    bottom: 5, left: 16, right: 20, top: 20),
                child: Text(
                  obj.quantity.toString(),
                  textAlign: TextAlign.start,
                  style: const TextStyle(
                    fontSize: 14.0,
                    color: Colors.black,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                    bottom: 5, left: 48, right: 16, top: 0),
                child: Text(
                  '₹${obj.price}',
                  textAlign: TextAlign.start,
                  style: const TextStyle(
                    fontSize: 14.0,
                    color: Colors.black,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    bottom: 5, left: 16, right: 20, top: 0),
                child: Text(
                  '₹${obj.price * obj.quantity}',
                  textAlign: TextAlign.start,
                  style: const TextStyle(
                    fontSize: 14.0,
                    color: Colors.black87,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  savedLocation() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? locationJson = prefs.getString(Constants.selectedLocation);
    if (locationJson != null) {
      Map<String, dynamic> decodeOptions = jsonDecode(locationJson);
      LocationModel locationOj = LocationModel.fromJson(decodeOptions);
      setState(() {
        location = locationOj;
      });
    }
  }
}
