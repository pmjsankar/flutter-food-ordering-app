import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'constants.dart';
import 'login.dart';
import 'main.dart';

class Otp extends StatefulWidget {
  final String mobileNumber;

  Otp({Key key, this.mobileNumber}) : super(key: key);

  @override
  _Otp createState() => _Otp();
}

class _Otp extends State<Otp> {
  TextEditingController otpController = new TextEditingController();
  bool _validate = true;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark));
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: 60),
              child: Row(
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: TextButton.icon(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        icon: Icon(
                          Icons.arrow_back,
                          color: Colors.black87,
                        ),
                        label: Text('')),
                  ),
                  Align(
                    alignment: Alignment.topCenter,
                    child: Text(
                      'OTP verification',
                      style: TextStyle(
                          color: Colors.blueGrey,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 20.0, top: 10.0, right: 20.0, bottom: 0.0),
              child: Text(
                'Enter the verification code sent to your mobile number',
                style: TextStyle(
                    color: Colors.blueGrey,
                    fontSize: 14,
                    fontWeight: FontWeight.normal),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 15.0, right: 15.0, top: 30, bottom: 0),
              child: TextFormField(
                autofocus: true,
                controller: otpController,
                keyboardType: TextInputType.number,
                maxLength: 4,
                obscureText: true,
                enableSuggestions: false,
                autocorrect: false,
                obscuringCharacter: '●',
                style: TextStyle(fontSize: 13),
                decoration: InputDecoration(
                  icon: Icon(Icons.password),
                  labelText: 'OTP',
                  errorText: _validate ? null : 'Enter the 4 digit OTP',
                  labelStyle: TextStyle(
                    color: Colors.black,
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                  ),
                ),
                onChanged: (text) {
                  if (text.length == 4) {
                    setInputValidation(true);
                    FocusManager.instance.primaryFocus?.unfocus();
                  }
                },
              ),
            ),
            SizedBox(
              height: 40,
            ),
            ElevatedButton(
                onPressed: () {
                  if (otpController.text.length < 4) {
                    setInputValidation(false);
                  } else {
                    setInputValidation(true);
                    saveLogin(widget.mobileNumber);
                    Navigator.pushAndRemoveUntil(
                      context,
                      createRoute(HomePage()),
                      (route) => false,
                    );
                  }
                },
                child: Padding(
                  padding: EdgeInsets.only(
                      left: 30.0, right: 30.0, top: 10, bottom: 10),
                  child: Text(
                    'Verify',
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

  saveLogin(String mobileNumber) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(Constants.LOGIN, mobileNumber);
  }
}
