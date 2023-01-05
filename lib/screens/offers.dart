import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:livemenu/model/offers_model.dart';
import 'package:livemenu/util/networklayer.dart';

class Offers extends StatefulWidget {
  Offers({Key key}) : super(key: key);

  @override
  _Offers createState() => _Offers();
}

class _Offers extends State<Offers> {
  bool _couponValid = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFFf2f2f2),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Padding(
                    padding:
                        const EdgeInsets.only(left: 10.0, right: 0, top: 60.0),
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
                    padding: const EdgeInsets.only(left: 10.0, top: 60.0),
                    child: Text(
                      'Offers',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 10.0, top: 20.0, right: 10.0, bottom: 0.0),
              child: TextField(
                textCapitalization: TextCapitalization.characters,
                keyboardType: TextInputType.name,
                inputFormatters: [
                  FilteringTextInputFormatter.deny(RegExp(r'\s')),
                ],
                onChanged: (text) {
                  setState(() {
                    _couponValid = text.trim().length >= 6;
                  });
                },
                decoration: InputDecoration(
                    labelText: "Enter coupon code",
                    suffix: Padding(
                      padding: EdgeInsets.only(
                        right: 10,
                      ),
                      child: InkWell(
                        onTap: () => _couponValid
                            ? ScaffoldMessenger.of(context)
                                .showSnackBar(SnackBar(
                                    backgroundColor: Colors.green,
                                    content: Text(
                                      "Yay! Offer applied",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.normal),
                                    )))
                            : {},
                        child: Text('APPLY',
                            style: TextStyle(
                              fontSize: 14.0,
                              color:
                                  _couponValid ? Colors.redAccent : Colors.grey,
                              fontWeight: FontWeight.bold,
                            )),
                      ),
                    )),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 25, left: 15, bottom: 16),
              child: Text('Available Coupons',
                  style: TextStyle(
                    fontSize: 18.0,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  )),
            ),
            Expanded(
              child: new FutureBuilder<List<OfferModel>>(
                future: getOffers(http.Client()),
                builder: (context, snapshot) {
                  if (snapshot.hasError) print(snapshot.error);

                  return snapshot.hasData
                      ? new SingleChildScrollView(
                          padding: EdgeInsets.all(0),
                          physics: BouncingScrollPhysics(),
                          child: Column(
                            children: <Widget>[
                              ListView.builder(
                                  physics: BouncingScrollPhysics(),
                                  shrinkWrap: true,
                                  padding: EdgeInsets.only(top: 0),
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
          ],
        ));
  }

  Container getListItem(OfferModel obj, int index, BuildContext context) {
    return Container(
      child: Card(
        margin: EdgeInsets.only(
          bottom: 10,
          top: 0,
          left: 10,
          right: 10,
        ),
        elevation: 2,
        child: InkWell(
          onTap: () => {},
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Expanded(
                    flex: 2,
                    child: Padding(
                      padding: EdgeInsets.only(
                          left: 10, right: 25, top: 20, bottom: 10),
                      child: Image.network(obj.imageUrl,
                          width: 20, height: 40, fit: BoxFit.fill),
                    ),
                  ),
                  Expanded(
                      flex: 6,
                      child: Padding(
                        padding: EdgeInsets.only(
                            left: 0, right: 0, top: 10, bottom: 10),
                        child: SelectableText(
                          obj.code,
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            fontSize: 18.0,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                          maxLines: 1,
                        ),
                      )),
                  Expanded(
                    flex: 2,
                    child: TextButton(
                      child: const Text(
                        'APPLY',
                        style: TextStyle(
                          fontSize: 15.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      style: TextButton.styleFrom(
                        primary: obj.available ? Colors.redAccent : Colors.grey,
                      ),
                      onPressed: () {
                        obj.available
                            ? ScaffoldMessenger.of(context)
                                .showSnackBar(SnackBar(
                                    backgroundColor: Colors.green,
                                    content: Text(
                                      "Yay! Offer applied",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.normal),
                                    )))
                            : ScaffoldMessenger.of(context)
                                .showSnackBar(SnackBar(
                                content: Text(obj.desc),
                              ));
                      },
                    ),
                  ),
                ],
              ),
              Padding(
                padding:
                    EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 10),
                child: Text(
                  obj.title,
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
              ),
              Padding(
                padding:
                    EdgeInsets.only(left: 10, right: 10, top: 0, bottom: 0),
                child: Text(
                  obj.desc,
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontSize: 14.0,
                    color: Colors.black,
                    fontWeight: FontWeight.normal,
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 3,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 5, right: 0, top: 0, bottom: 5),
                child: TextButton(
                  child: const Text('View details',
                      style: TextStyle(
                        fontSize: 14.0,
                        color: Colors.blueGrey,
                        fontWeight: FontWeight.normal,
                      )),
                  onPressed: () => launchURL(context, 'https://www.google.com'),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
