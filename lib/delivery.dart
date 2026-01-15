import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:livemenu/model/delivery_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/location_model.dart';
import '../util/constants.dart';
import '../util/networklayer.dart';
import 'gridview.dart';
import 'main.dart';
import 'menu.dart';

final List<String> imgList = [
  'https://images.unsplash.com/photo-1571091718767-18b5b1457add?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1172&q=80',
  'https://images.unsplash.com/photo-1589301760014-d929f3979dbc?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1170&q=80',
  'https://images.unsplash.com/photo-1513104890138-7c749659a591?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1170&q=80',
  'https://images.unsplash.com/photo-1631452180539-96aca7d48617?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1170&q=80',
  'https://images.unsplash.com/photo-1504754524776-8f4f37790ca0?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1170&q=80',
];
List<LocationModel> locationList = List.empty(growable: true);

LocationModel location = LocationModel(
    title: 'Add address',
    address: 'Kakkanad, Kochi',
    type: 'Other',
    selected: true);

class Delivery extends StatefulWidget {
  Delivery({Key key}) : super(key: key);

  @override
  _Delivery createState() => _Delivery();
}

class _Delivery extends State<Delivery> {
  int _current = 0;
  final CarouselController _controller = CarouselController();
  int selectedIndex = 0;
  List<String> _chipsList = ["Home", "Work", "Other"];
  bool _validTitle = true;
  bool _validAddress = true;
  List<DeliveryModel> restaurantList = List.empty(growable: true);
  List<DeliveryModel> restaurantListFiltered = List.empty(growable: true);

  @override
  void initState() {
    savedLocation();
    fetchRestaurantList();
    super.initState();
  }

  fetchRestaurantList() async {
    List deliveryList = await fetchDeliveryDetails(new http.Client());
    setState(() {
      restaurantList = deliveryList;
    });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: Colors.white,
        statusBarIconBrightness: Brightness.dark));
    return Scaffold(
      body: Column(
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: const EdgeInsets.only(left: 10.0, top: 50.0, bottom: 0),
              child: TextButton.icon(
                  onPressed: () {
                    if (location.title == 'Add address') {
                      _addAddress(context);
                    } else {
                      _selectLocation(context);
                    }
                  },
                  icon: Icon(
                    Icons.location_on_rounded,
                    color: Colors.red,
                    size: 32,
                  ),
                  label: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        location != null && location.title != null
                            ? location.title
                            : locationList.isNotEmpty
                                ? locationList[0].title
                                : "",
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 15),
                      ),
                      Text(
                        location != null && location.address != null
                            ? location.address
                            : locationList.isNotEmpty
                                ? locationList[0].address
                                : "",
                        style: TextStyle(
                            color: Colors.blueGrey,
                            fontWeight: FontWeight.normal,
                            fontSize: 12),
                      )
                    ],
                  )),
            ),
          ),
          Expanded(
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(
                      left: 10.0, top: 8.0, right: 10.0, bottom: 10.0),
                  child: TextField(
                    onChanged: (text) {
                      filterRestaurantList(text.toLowerCase());
                    },
                    decoration: InputDecoration(
                      labelText: "Search",
                      hintText: "Search",
                      isDense: true,
                      // now you can customize it here or add padding widget
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                      prefixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10.0),
                        ),
                      ),
                    ),
                  ),
                ),
                CarouselSlider(
                  items: imageSliders,
                  carouselController: _controller,
                  options: CarouselOptions(
                      autoPlay: false,
                      enlargeCenterPage: false,
                      aspectRatio: 2.0,
                      onPageChanged: (index, reason) {
                        setState(() {
                          _current = index;
                        });
                      }),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: imgList.asMap().entries.map((entry) {
                    return GestureDetector(
                      onTap: () => _controller.animateToPage(entry.key),
                      child: Container(
                        width: 6.0,
                        height: 6.0,
                        margin: EdgeInsets.symmetric(
                            vertical: 8.0, horizontal: 4.0),
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color:
                                (Theme.of(context).brightness == Brightness.dark
                                        ? Colors.white
                                        : Colors.black)
                                    .withOpacity(
                                        _current == entry.key ? 0.9 : 0.4)),
                      ),
                    );
                  }).toList(),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 20.0, top: 15.0, right: 10.0, bottom: 5.0),
                  child: Text(
                    'Popular',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      InkWell(
                        child: Container(
                            margin:
                                EdgeInsets.only(top: 20, left: 17, right: 6),
                            width: 75.0,
                            height: 75.0,
                            padding: const EdgeInsets.only(
                                left: 10.0,
                                top: 20.0,
                                right: 10.0,
                                bottom: 10.0),
                            decoration: new BoxDecoration(
                                color: Colors.black12,
                                shape: BoxShape.circle,
                                image: new DecorationImage(
                                    fit: BoxFit.scaleDown,
                                    image: new AssetImage(
                                        "assets/images/burger.png")))),
                        onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => Menu(obj: restaurantList[0]))),
                      ),
                      InkWell(
                        child: Container(
                            margin: EdgeInsets.only(top: 20, right: 6),
                            width: 75.0,
                            height: 75.0,
                            padding: const EdgeInsets.only(
                                left: 10.0,
                                top: 20.0,
                                right: 10.0,
                                bottom: 10.0),
                            decoration: new BoxDecoration(
                                color: Colors.black12,
                                shape: BoxShape.circle,
                                image: new DecorationImage(
                                    fit: BoxFit.scaleDown,
                                    image: new AssetImage(
                                        "assets/images/masala.png")))),
                        onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => Menu(obj: restaurantList[0]))),
                      ),
                      InkWell(
                        child: Container(
                            margin: EdgeInsets.only(top: 20, right: 6),
                            width: 75.0,
                            height: 75.0,
                            padding: const EdgeInsets.only(
                                left: 10.0,
                                top: 20.0,
                                right: 10.0,
                                bottom: 10.0),
                            decoration: new BoxDecoration(
                                color: Colors.black12,
                                shape: BoxShape.circle,
                                image: new DecorationImage(
                                    fit: BoxFit.scaleDown,
                                    image: new AssetImage(
                                        "assets/images/pizza.png")))),
                        onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => Menu(obj: restaurantList[0]))),
                      ),
                      InkWell(
                        child: Container(
                            margin: EdgeInsets.only(top: 20, right: 17),
                            width: 75.0,
                            height: 75.0,
                            padding: const EdgeInsets.only(
                                left: 10.0,
                                top: 20.0,
                                right: 10.0,
                                bottom: 10.0),
                            decoration: new BoxDecoration(
                                color: Colors.black12,
                                shape: BoxShape.circle,
                                image: new DecorationImage(
                                    fit: BoxFit.scaleDown,
                                    image: new AssetImage(
                                        "assets/images/biriyani.png")))),
                        onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => Menu(obj: restaurantList[0]))),
                      ),
                    ]),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 20.0, top: 20.0, right: 10.0, bottom: 10.0),
                  child: Text(
                    'Top offers!',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 6.0, top: 0.0, right: 6.0, bottom: 10.0),
                  child: RestaurantGridView(
                      restaurantList: restaurantListFiltered.isNotEmpty
                          ? restaurantListFiltered
                          : restaurantList),
                )
              ],
            ),
          )),
        ],
      ),
    );
  }

  void _selectLocation(context) {
    showModalBottomSheet(
        context: context,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        builder: (BuildContext bc) {
          return StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
            return SafeArea(
              child: Wrap(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0, top: 20.0),
                    child: Text(
                      'Select a location',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  ListView.builder(
                      physics: BouncingScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: locationList.length,
                      itemBuilder: (context, index) {
                        return getListItem(locationList[index], index, context);
                      }),
                  Divider(
                    height: 1,
                    indent: 6,
                    endIndent: 6,
                  ),
                  Visibility(
                    visible: locationList.length < 3 ? true : false,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8.0, bottom: 10),
                      child: TextButton.icon(
                          onPressed: () {
                            Navigator.of(context).pop();
                            _addAddress(context);
                          },
                          icon: Icon(
                            Icons.add,
                            color: Colors.red,
                            size: 24,
                          ),
                          label: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Add address',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15),
                              ),
                            ],
                          )),
                    ),
                  ),
                ],
              ),
            );
          });
        });
  }

  ListTile getListItem(LocationModel obj, int index, BuildContext context) {
    return ListTile(
      leading: new Icon(
        obj.type == 'Home'
            ? Icons.home
            : obj.type == 'Work'
                ? Icons.work
                : Icons.place,
        color: Colors.teal,
      ),
      title: new Text(
        obj.title,
        style: TextStyle(
            color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold),
      ),
      subtitle: new Text(obj.address),
      trailing: Visibility(
          visible: obj.title == location?.title ? true : false,
          child: Icon(
            Icons.check_circle_outline,
            color: Colors.red,
          )),
      onTap: () async {
        Navigator.of(context).pop();
        saveSelectedLocation(obj);
      },
    );
  }

  void _addAddress(context) {
    TextEditingController titleController = new TextEditingController();
    TextEditingController addressController = new TextEditingController();
    setState(() {
      _validTitle = true;
      _validAddress = true;
    });

    showModalBottomSheet(
        isScrollControlled: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        builder: (BuildContext context) {
          return StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
            return SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Container(
                    padding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).viewInsets.bottom),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Padding(
                          padding:
                              EdgeInsets.only(top: 20, right: 20, left: 20),
                          child: Text(
                            'Add address',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Padding(
                          padding:
                              EdgeInsets.only(top: 20, right: 20, left: 20),
                          child: TextField(
                            controller: titleController,
                            decoration: InputDecoration(
                              hintText: "House No., Building Name (Required)",
                              errorText:
                                  _validTitle ? null : 'This field is required',
                              isDense: true,
                              // now you can customize it here or add padding widget
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 10),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(5.0),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding:
                              EdgeInsets.only(top: 20, right: 20, left: 20),
                          child: TextField(
                            controller: addressController,
                            decoration: InputDecoration(
                              hintText: "Road name, Area (Required)",
                              errorText: _validAddress
                                  ? null
                                  : 'This field is required',
                              isDense: true,
                              // now you can customize it here or add padding widget
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 10),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(5.0),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding:
                              EdgeInsets.only(top: 20, right: 20, left: 20),
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: "Nearby Landmark (Optional)",
                              isDense: true,
                              // now you can customize it here or add padding widget
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 10),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(5.0),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              top: 20, right: 20, left: 20, bottom: 10),
                          child: Wrap(
                            spacing: 6,
                            direction: Axis.horizontal,
                            children: locationChips(),
                          ),
                        ),
                        Padding(
                            padding: EdgeInsets.only(
                                top: 20, right: 20, left: 20, bottom: 25),
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                minimumSize: Size.fromHeight(
                                    40), // fromHeight use double.infinity as width and 40 is the height
                              ),
                              child: Text(
                                'Save address',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold),
                              ),
                              onPressed: () async {
                                var title = titleController.text;
                                var address = addressController.text;
                                setState(() {
                                  _validTitle = title.isNotEmpty;
                                  _validAddress = address.isNotEmpty;
                                });
                                if (title.isNotEmpty && address.isNotEmpty) {
                                  Navigator.of(context).pop();
                                  LocationModel obj = LocationModel(
                                    title: title,
                                    address: address,
                                    type: _chipsList[selectedIndex],
                                    selected: false,
                                  );
                                  saveSelectedLocation(obj);
                                  saveLocationList(obj);
                                  setState(() {
                                    _validTitle = true;
                                    _validAddress = true;
                                  });
                                }
                              },
                            )),
                      ],
                    )));
          });
        },
        context: context);
  }

  List<Widget> locationChips() {
    List<Widget> chips = [];
    for (int i = 0; i < _chipsList.length; i++) {
      Widget item = Padding(
        padding: const EdgeInsets.only(left: 10, right: 5),
        child: ChoiceChip(
          label: Text(_chipsList[i]),
          labelStyle: TextStyle(color: Colors.white),
          backgroundColor: Colors.black26,
          selectedColor: Colors.cyan,
          selected: selectedIndex == i,
          onSelected: (bool value) {
            setState(() {
              selectedIndex = i;
            });
          },
        ),
      );
      chips.add(item);
    }
    return chips;
  }

  savedLocation() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String locationJson = prefs.getString(Constants.SELECTED_LOCATION);
    if (locationJson != null) {
      Map decode_options = jsonDecode(locationJson);
      LocationModel locationOj = LocationModel.fromJson(decode_options);
      setState(() {
        location = locationOj;
      });
    }

    final String locationListString =
        await prefs.getString(Constants.LOCATION_LIST);
    if (locationListString != null) {
      List<LocationModel> locations = List.empty(growable: true);
      locations = LocationModel.decode(locationListString);
      setState(() {
        locationList = locations;
      });
    }
  }

  saveLocationList(LocationModel selectedLocation) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    locationList.add(selectedLocation);
    final String encodedData = LocationModel.encode(locationList);
    await prefs.setString(Constants.LOCATION_LIST, encodedData);
  }

  saveSelectedLocation(LocationModel selectedLocation) async {
    setState(() {
      location = selectedLocation;
    });
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(Constants.SELECTED_LOCATION, jsonEncode(selectedLocation));
  }

  filterRestaurantList(String searchText) {
    restaurantListFiltered.clear();
    if (searchText != null && searchText.isNotEmpty) {
      List<DeliveryModel> restaurantListLatest = List.empty(growable: true);
      for (int i = 0; i < restaurantList.length; i++) {
        if (restaurantList[i].title.toLowerCase().contains(searchText) ||
            restaurantList[i].desc.toLowerCase().contains(searchText)) {
          restaurantListLatest.add(restaurantList[i]);
        }
      }
      setState(() {
        restaurantListFiltered = restaurantListLatest;
      });
    }
  }
}
