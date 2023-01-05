import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:livemenu/screens/otp.dart';

//
class Login extends StatefulWidget {
  Login({Key key}) : super(key: key);

  @override
  _Login createState() => _Login();
}

class _Login extends State<Login> {
  TextEditingController phoneController = new TextEditingController();
  bool _validate = true;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark));
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(
                  left: 20.0, top: 90.0, right: 10.0, bottom: 0.0),
              child: Text(
                'Live Menu',
                style: TextStyle(
                    color: Colors.blueGrey,
                    fontSize: 30,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 20.0, top: 10.0, right: 10.0, bottom: 0.0),
              child: Text(
                'Curated food menu from your nearby restaurants',
                style: TextStyle(
                    color: Colors.blueGrey,
                    fontSize: 14,
                    fontWeight: FontWeight.normal),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 20.0, top: 20.0, right: 10.0, bottom: 0.0),
              child: IconButton(
                iconSize: 200,
                onPressed: () {},
                icon: CircleAvatar(
                    radius: 200,
                    backgroundColor: Colors.transparent,
                    backgroundImage: AssetImage("assets/images/login.avif")),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 20.0, top: 50.0, right: 10.0, bottom: 0.0),
              child: Text(
                'Login/Sign up with your mobile number',
                textAlign: TextAlign.start,
                style: TextStyle(
                    color: Colors.blueGrey,
                    fontSize: 14,
                    fontWeight: FontWeight.normal),
              ),
            ),
            Padding(
              padding:
                  EdgeInsets.only(left: 15.0, right: 15.0, top: 20, bottom: 0),
              child: TextFormField(
                maxLength: 10,
                controller: phoneController,
                keyboardType: TextInputType.number,
                onChanged: (text) {
                  if (text.length == 10) {
                    FocusManager.instance.primaryFocus?.unfocus();
                    setInputValidation(true);
                  }
                },
                decoration: InputDecoration(
                  icon: Icon(Icons.phone),
                  labelText: 'Mobile number',
                  errorText:
                      _validate ? null : 'Enter your 10 digit mobile number',
                  labelStyle: TextStyle(
                    color: Colors.black,
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
                onPressed: () {
                  if (phoneController.text.length < 10) {
                    setInputValidation(false);
                  } else {
                    setInputValidation(true);
                    Navigator.of(context).push(
                        createRoute(Otp(mobileNumber: phoneController.text)));
                  }
                },
                child: Padding(
                  padding: EdgeInsets.only(
                      left: 30.0, right: 30.0, top: 10, bottom: 10),
                  child: Text(
                    'Next',
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
                  ),
                ))
          ],
        ),
      ),
    );
  }

  setInputValidation(bool valid) {
    setState(() {
      _validate = valid;
    });
  }

  @override
  void dispose() {
    phoneController.dispose();
    super.dispose();
  }
}

Route createRoute(Widget page) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => page,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(1.0, 0.0);
      const end = Offset.zero;
      const curve = Curves.ease;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}
