import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../util/constants.dart';
import 'login.dart';

class Profile extends StatefulWidget {
  Profile();

  @override
  _Profile createState() => _Profile();
}

class _Profile extends State<Profile> {
  var _image;
  var imagePicker;
  var mobileNumber = '';

  _Profile();

  @override
  void initState() {
    super.initState();
    imagePicker = new ImagePicker();
    getLogin();
  }

  @override
  Widget build(BuildContext context) {
    Color c = const Color(0xFFf2f2f2);
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light));
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: c,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: 160,
              width: double.maxFinite,
              child: Wrap(
                children: [
                  ColorFiltered(
                    colorFilter: ColorFilter.mode(
                        Colors.black.withOpacity(0.5), BlendMode.dstATop),
                    child: Image.asset(
                      'assets/images/banner1.webp',
                    ),
                  ),
                ],
              ),
            ),
            Padding(
                padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Stack(
                          children: <Widget>[
                            IconButton(
                              iconSize: 100,
                              onPressed: () => _showPicker(context),
                              icon: CircleAvatar(
                                  radius: 60,
                                  backgroundColor: Colors.transparent,
                                  backgroundImage: _image != null
                                      ? Image.file(
                                          _image,
                                          width: 200.0,
                                          height: 200.0,
                                          fit: BoxFit.fitHeight,
                                        ).image
                                      : new AssetImage(
                                          "assets/images/user.png")),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Card(
                      margin: EdgeInsets.only(top: 10.0, left: 10, right: 10),
                      child: Column(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(
                              top: 20.0,
                              bottom: 10,
                            ),
                            child: Text(
                              'Jay Shankar',
                              style:
                                  TextStyle(color: Colors.black, fontSize: 22),
                            ),
                          ),
                          Divider(
                            indent: 10,
                            endIndent: 10,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 5.0),
                            child: Text(
                              'user1@mail.com',
                              style:
                                  TextStyle(color: Colors.black, fontSize: 15),
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(top: 5.0, bottom: 20),
                            child: Text(
                              mobileNumber,
                              style:
                                  TextStyle(color: Colors.black, fontSize: 15),
                            ),
                          )
                        ],
                      ),
                    ),
                    GridView.count(
                        padding: EdgeInsets.only(top: 10),
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        // Create a grid with 2 columns. If you change the scrollDirection to
                        // horizontal, this produces 2 rows.
                        crossAxisCount: 2,
                        crossAxisSpacing: 5,
                        children: [
                          Card(
                            semanticContainer: true,
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            margin: EdgeInsets.all(10.0),
                            child: InkWell(
                              onTap: () => ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                content: Text("No orders yet"),
                              )),
                              child: Padding(
                                padding: const EdgeInsets.only(top: 5.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.library_books,
                                      color: Colors.blueGrey,
                                      size: 48,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 15.0),
                                      child: Text(
                                        'Orders',
                                        style: TextStyle(
                                            color: Colors.black, fontSize: 18),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Card(
                            margin: EdgeInsets.all(10.0),
                            child: InkWell(
                              onTap: () => ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                content: Text("No access"),
                              )),
                              child: Padding(
                                padding: const EdgeInsets.only(top: 5.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.account_box_sharp,
                                      color: Colors.blueGrey,
                                      size: 48,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 15.0),
                                      child: Text(
                                        'Account',
                                        style: TextStyle(
                                            color: Colors.black, fontSize: 18),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Card(
                            margin: EdgeInsets.all(10.0),
                            child: InkWell(
                              onTap: () => ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                content: Text("No notifications to show"),
                              )),
                              child: Padding(
                                padding: const EdgeInsets.only(top: 5.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.notifications,
                                      size: 48,
                                      color: Colors.blueGrey,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 15.0),
                                      child: Text(
                                        'Notifications',
                                        style: TextStyle(
                                            color: Colors.black, fontSize: 18),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Card(
                            margin: EdgeInsets.all(10.0),
                            child: InkWell(
                              onTap: () => ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                content: Text("Coming soon..."),
                              )),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.help_center,
                                    size: 48,
                                    color: Colors.blueGrey,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 15.0),
                                    child: Text(
                                      'Help',
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 18),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ]),
                  ],
                )),
            Align(
              alignment: Alignment.center,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: TextButton(
                  onPressed: () {
                    _showMyDialog();
                  },
                  child: const Text(
                    'Logout',
                    style: TextStyle(color: Colors.black, fontSize: 16),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void _showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Wrap(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 10.0, top: 15.0),
                  child: Text(
                    'Update profile image',
                    style: TextStyle(color: Colors.black, fontSize: 16),
                  ),
                ),
                new ListTile(
                    leading: new Icon(Icons.photo_library),
                    title: new Text('Gallery'),
                    onTap: () async {
                      Navigator.of(context).pop();
                      var source = ImageSource.gallery;
                      XFile image = await imagePicker.pickImage(
                          source: source,
                          imageQuality: 50,
                          preferredCameraDevice: CameraDevice.front);
                      setState(() {
                        _image = File(image.path);
                      });
                    }),
                new ListTile(
                  leading: new Icon(Icons.photo_camera),
                  title: new Text('Camera'),
                  onTap: () async {
                    Navigator.of(context).pop();
                    var source = ImageSource.camera;
                    XFile image = await imagePicker.pickImage(
                        source: source,
                        imageQuality: 50,
                        preferredCameraDevice: CameraDevice.front);
                    setState(() {
                      _image = File(image.path);
                    });
                  },
                ),
              ],
            ),
          );
        });
  }

  getLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      mobileNumber = prefs.getString(Constants.LOGIN) ?? '';
    });
  }

  logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove(Constants.LOGIN);
    setState(() {
      mobileNumber = '';
    });
  }

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Logout'),
          content: Text('Are you sure you want to logout?'),
          actions: <Widget>[
            TextButton(
              child: const Text('Yes'),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.pushAndRemoveUntil(
                  context,
                  createRoute(Login()),
                  (route) => false,
                );
                logout();
              },
            ),
          ],
        );
      },
    );
  }
}
