import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:livemenu/dining_model.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import 'networklayer.dart';

class Dining extends StatefulWidget {
  Dining({Key key}) : super(key: key);

  @override
  _Dining createState() => _Dining();
}

class _Dining extends State<Dining> {
  final List<int> _selectedIndices = <int>[-1];

  _onSelected(int index) {
    setState(() {
      if (_selectedIndices.contains(index)) {
        _selectedIndices.remove(index);
      } else {
        _selectedIndices.add(index);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: Colors.white,
        statusBarIconBrightness: Brightness.dark));
    return Scaffold(
        body: Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(
              left: 10.0, top: 60.0, right: 10.0, bottom: 0.0),
          child: TextField(
            decoration: InputDecoration(
              labelText: "Search restaurants, cuisine..",
              isDense: true,
              // now you can customize it here or add padding widget
              contentPadding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
              prefixIcon: Icon(Icons.search),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(10.0),
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: new FutureBuilder<List<DiningModel>>(
            future: getDining(new http.Client()),
            builder: (context, snapshot) {
              if (snapshot.hasError) print(snapshot.error);

              return snapshot.hasData
                  ? new SingleChildScrollView(
                      physics: ScrollPhysics(),
                      child: Column(
                        children: <Widget>[
                          ListView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
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

  Container getListItem(DiningModel obj, int index, BuildContext context) {
    return Container(
        child: Card(
      margin: EdgeInsets.only(
        bottom: 20,
        left: 10,
        right: 10,
      ),
      elevation: 2,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            flex: 4,
            child: Image.network(obj.imageUrl,
                width: 150, height: 160, fit: BoxFit.fill),
          ),
          Expanded(
            flex: 6,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Padding(
                        padding: EdgeInsets.only(
                            bottom: 6, left: 12, right: 10, top: 8),
                        child: Text(
                          obj.title,
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            fontSize: 17.0,
                            color: Colors.black87,
                            fontWeight: FontWeight.normal,
                          ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 10.0, top: 6.0, bottom: 10, right: 10),
                      child: ClipOval(
                        child: Material(
                          child: InkWell(
                            splashColor: Colors.grey, // Splash color
                            onTap: () {
                              _onSelected(index);
                            },
                            child: SizedBox(
                                width: 26,
                                height: 26,
                                child: Icon(
                                  _selectedIndices.contains(index)
                                      ? Icons.favorite
                                      : Icons.favorite_outline,
                                  size: 26,
                                  color: _selectedIndices.contains(index)
                                      ? Colors.redAccent
                                      : Colors.grey,
                                )),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding:
                      EdgeInsets.only(bottom: 5, left: 12, right: 10, top: 0),
                  child: Text(
                    obj.desc,
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      fontSize: 10.0,
                      color: Colors.black45,
                      fontWeight: FontWeight.normal,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Padding(
                  padding:
                      EdgeInsets.only(bottom: 5, left: 12, right: 10, top: 0),
                  child: Text(
                    obj.address,
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      fontSize: 10.0,
                      color: Colors.black38,
                      fontWeight: FontWeight.normal,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Padding(
                  padding:
                      EdgeInsets.only(bottom: 5, left: 12, right: 10, top: 0),
                  child: Text(
                    obj.timing,
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      fontSize: 10.0,
                      color: Colors.black38,
                      fontWeight: FontWeight.normal,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Padding(
                  padding:
                      EdgeInsets.only(bottom: 6, left: 12, right: 10, top: 0),
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      color: Colors.green,
                      borderRadius: new BorderRadius.all(Radius.circular(3.0)),
                    ),
                    padding: EdgeInsets.all(2.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.star,
                          color: Colors.white,
                          size: 8,
                        ),
                        Text(
                          obj.rating,
                          style: TextStyle(
                            fontWeight: FontWeight.normal,
                            fontSize: 12.0,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 10.0, top: 6.0, bottom: 10),
                      child: ClipOval(
                        child: Material(
                          color: Colors.blue, // Button color
                          child: InkWell(
                            splashColor: Colors.grey, // Splash color
                            onTap: () {
                              _launchURL(obj.map);
                            },
                            child: SizedBox(
                                width: 24,
                                height: 24,
                                child: Icon(
                                  Icons.room_outlined,
                                  size: 18,
                                  color: Colors.white,
                                )),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 10.0, top: 6.0, bottom: 10),
                      child: ClipOval(
                        child: Material(
                          color: Colors.blue, // Button color
                          child: InkWell(
                            splashColor: Colors.grey, // Splash color
                            onTap: () {
                              Share.share(obj.map,
                                  subject: obj.title + "\n" + obj.desc);
                            },
                            child: SizedBox(
                                width: 24,
                                height: 24,
                                child: Icon(
                                  Icons.ios_share_sharp,
                                  size: 18,
                                  color: Colors.white,
                                )),
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    ));
  }

  void _launchURL(String _url) async {
    if (!await launch(_url)) throw 'Could not launch $_url';
  }
}
