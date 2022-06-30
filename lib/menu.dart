import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:livemenu/checkout.dart';
import 'package:livemenu/delivery_model.dart';

import 'checkout_model.dart';
import 'menu_model.dart';
import 'networklayer.dart';

class Menu extends StatefulWidget {
  final DeliveryModel obj;

  Menu({Key key, this.obj}) : super(key: key);

  @override
  _Menu createState() => _Menu();
}

class _Menu extends State<Menu> {
  final List<CheckoutModel> _selectedItems = <CheckoutModel>[];
  var _starred = false;
  var _switchValueVeg = false;
  var _switchValueNonVeg = false;
  var itemAddedToCart = false;
  var totalPrice = 0;
  var itemCount = 0;

  _onSelected(int index) {
    setState(() {
      if (_starred) {
        _starred = false;
      } else {
        _starred = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark));

    return Scaffold(
        body: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Padding(
                padding:
                    const EdgeInsets.only(left: 10.0, right: 10, top: 60.0),
                child: InkWell(
                  child: Icon(
                    Icons.arrow_back,
                    color: Colors.black54,
                    size: 32,
                  ),
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                )),
            Expanded(
              child: new Padding(
                padding: const EdgeInsets.only(left: 3.0, top: 60.0),
                child: Text(
                  widget.obj.title,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 10.0, top: 60.0, bottom: 10, right: 16),
              child: ClipOval(
                child: Material(
                  child: InkWell(
                    splashColor: Colors.grey, // Splash color
                    onTap: () {
                      _onSelected(100);
                    },
                    child: SizedBox(
                        width: 26,
                        height: 26,
                        child: Icon(
                          _starred ? Icons.favorite : Icons.favorite_outline,
                          size: 26,
                          color: _starred ? Colors.redAccent : Colors.grey,
                        )),
                  ),
                ),
              ),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                      padding: EdgeInsets.only(
                          bottom: 5, left: 20, right: 10, top: 6),
                      child: Flexible(
                        child: Text(
                          widget.obj.desc,
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            fontSize: 14.0,
                            color: Colors.black38,
                            fontWeight: FontWeight.normal,
                          ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 3,
                        ),
                      )),
                  Padding(
                    padding:
                        EdgeInsets.only(bottom: 5, left: 20, right: 10, top: 2),
                    child: Text(
                      widget.obj.address,
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        fontSize: 14.0,
                        color: Colors.black54,
                        fontWeight: FontWeight.normal,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
              flex: 4,
            ),
            Flexible(
              child: Padding(
                  padding:
                      EdgeInsets.only(bottom: 6, left: 6, right: 12, top: 0),
                  child: Card(
                    elevation: 3,
                    color: Colors.green,
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Container(
                          padding: EdgeInsets.all(2.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Icon(
                                Icons.star,
                                color: Colors.white,
                                size: 14,
                              ),
                              Text(
                                widget.obj.rating,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16.0,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding:
                              EdgeInsets.only(left: 4, right: 4, bottom: 6),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                '2,456',
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                  fontSize: 10.0,
                                  color: Colors.white,
                                  fontWeight: FontWeight.normal,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                              Text(
                                'Reviews',
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                  fontSize: 10.0,
                                  color: Colors.white,
                                  fontWeight: FontWeight.normal,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  )),
              flex: 1,
            ),
          ],
        ),
        Padding(
            padding: EdgeInsets.only(bottom: 5, left: 20, right: 10, top: 2),
            child: Container(
                decoration: new BoxDecoration(
                  color: Colors.black12,
                  shape: BoxShape.rectangle,
                  borderRadius: new BorderRadius.all(Radius.circular(8.0)),
                ),
                child: InkWell(
                  child: Padding(
                    padding: EdgeInsets.all(6),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.timer_rounded,
                          color: Colors.red,
                          size: 16,
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 4, right: 4),
                          child: Text(
                            '20 mins',
                            style: TextStyle(
                              fontWeight: FontWeight.normal,
                              fontSize: 14.0,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  onTap: () {},
                ))),
        Divider(
          indent: 10,
          endIndent: 10,
          color: Colors.grey,
        ),
        Padding(
            padding: EdgeInsets.only(left: 17),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Switch(
                      value: _switchValueVeg,
                      activeColor: Colors.green,
                      onChanged: (value) {
                        setState(() {
                          _switchValueVeg = value;
                        });
                      },
                    ),
                    Text(
                      'Veg',
                      style: TextStyle(
                        fontWeight: FontWeight.normal,
                        fontSize: 14.0,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(
                      width: 30,
                    ),
                    Switch(
                      value: _switchValueNonVeg,
                      activeColor: Colors.red,
                      onChanged: (value) {
                        setState(() {
                          _switchValueNonVeg = value;
                        });
                      },
                    ),
                    Text(
                      'Non-Veg',
                      style: TextStyle(
                        fontWeight: FontWeight.normal,
                        fontSize: 14.0,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10),
                  child: Text(
                    'Recommended',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0,
                      color: Colors.black,
                    ),
                  ),
                )
              ],
            )),
        Expanded(
          child: new FutureBuilder<List<MenuModel>>(
            future: getMenu(new http.Client()),
            builder: (context, snapshot) {
              if (snapshot.hasError) print(snapshot.error);

              return snapshot.hasData
                  ? new SingleChildScrollView(
                      padding: EdgeInsets.all(0),
                      physics: ScrollPhysics(),
                      child: Column(
                        children: <Widget>[
                          ListView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              padding: EdgeInsets.only(top: 20),
                              itemCount: snapshot.data.length,
                              itemBuilder: (context, index) {
                                return getListItem(
                                    snapshot.data[index], index, context);
                              })
                        ],
                      ),
                    )
                  : new Center(child: new CircularProgressIndicator());
            },
          ),
        ),
        if (itemAddedToCart == true)
          InkWell(
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.all(20),
                color: Colors.lightGreen,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      (itemCount > 1)
                          ? '$itemCount ITEMS  |  $totalPrice'
                          : '$itemCount ITEM  |  $totalPrice',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16.0,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      'VIEW CART >',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16.0,
                        color: Colors.white,
                      ),
                    )
                  ],
                ),
              ),
              onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => Checkout(
                          obj: widget.obj,
                          selectedItems: _selectedItems,
                          totalPrice: totalPrice))))
      ],
    ));
  }

  Visibility getListItem(MenuModel menuObj, int index, BuildContext context) {
    bool visible;
    if (_switchValueVeg != true && _switchValueNonVeg != true ||
        _switchValueVeg == true && _switchValueNonVeg == true) {
      visible = true;
    } else if (_switchValueVeg == true) {
      if (menuObj.veg == true) {
        visible = true;
      } else {
        visible = false;
      }
    } else if (_switchValueNonVeg == true) {
      if (menuObj.veg != true) {
        visible = true;
      } else {
        visible = false;
      }
    }
    return Visibility(
        visible: visible,
        child: Container(
          decoration: BoxDecoration(
            border: Border(bottom: BorderSide(color: Colors.black12)),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                flex: 6,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 12, left: 16),
                      padding: EdgeInsets.all(2),
                      decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.circular(3),
                          border: Border.all(
                              width: 2,
                              color: menuObj.veg ? Colors.green : Colors.red)),
                      child: Icon(
                        Icons.circle,
                        color: menuObj.veg ? Colors.green : Colors.red,
                        size: 8,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          bottom: 6, left: 16, right: 10, top: 8),
                      child: Text(
                        menuObj.title,
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          fontSize: 17.0,
                          color: Colors.black87,
                          fontWeight: FontWeight.bold,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          bottom: 5, left: 16, right: 10, top: 0),
                      child: Text(
                        '₹' + menuObj.price.toString(),
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          fontSize: 14.0,
                          color: Colors.black87,
                          fontWeight: FontWeight.normal,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          bottom: 5, left: 16, right: 10, top: 0),
                      child: OutlinedButton(
                        onPressed: () {
                          setState(() {
                            totalPrice = totalPrice + menuObj.price;
                            itemAddedToCart = true;
                            if (_selectedItems.isEmpty) {
                              var slNew = CheckoutModel(
                                  title: menuObj.title,
                                  price: menuObj.price,
                                  quantity: 1,
                                  veg: menuObj.veg,
                                  imageUrl: menuObj.imageUrl);
                              _selectedItems.add(slNew);
                            } else {
                              var alreadyExist = false;
                              for (int i = 0; i < _selectedItems.length; i++) {
                                var sl = _selectedItems[i];
                                if (sl.title == menuObj.title) {
                                  sl.quantity = sl.quantity + 1;
                                  alreadyExist = true;
                                  break;
                                }
                              }
                              if (!alreadyExist) {
                                var slNew = CheckoutModel(
                                    title: menuObj.title,
                                    price: menuObj.price,
                                    quantity: 1,
                                    veg: menuObj.veg,
                                    imageUrl: menuObj.imageUrl);
                                _selectedItems.add(slNew);
                              }
                            }
                            itemCount = _selectedItems.length;
                          });
                        },
                        style: OutlinedButton.styleFrom(
                          side: BorderSide(width: 1.0, color: Colors.red),
                        ),
                        child: const Text(
                          "+ ADD",
                          style: TextStyle(
                            fontSize: 14.0,
                            color: Colors.red,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Expanded(
                flex: 3,
                child: Container(
                  margin:
                      EdgeInsets.only(top: 14, bottom: 14, left: 10, right: 10),
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Image.network(menuObj.imageUrl,
                        width: 100, height: 110, fit: BoxFit.fill),
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
