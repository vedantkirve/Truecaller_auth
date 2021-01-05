import 'package:flutter/material.dart';
import 'package:flutter_truecaller/flutter_truecaller.dart';
import 'package:flutter_truecaller_app/verify_mobile_number.dart';

import 'home_page.dart';

void main() {
  runApp(MaterialApp(home: MyApp()));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final FlutterTruecaller truecaller = FlutterTruecaller();

  @override
  void initState() {
    // ignore: todo
    // TODO: implement initState
    super.initState();
    getTrueCaller();
  }

  Future getTrueCaller() async {
    await truecaller.initializeSDK(
      sdkOptions: FlutterTruecallerScope.SDK_OPTION_WITH_OTP,
      footerType: FlutterTruecallerScope.FOOTER_TYPE_ANOTHER_METHOD,
      consentMode: FlutterTruecallerScope.CONSENT_MODE_POPUP,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Flutter Truecaller App"),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            //crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Center(
                  child: Text(
                "Login/Signup using",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              )),
              SizedBox(
                height: 20,
              ),
              RaisedButton(
                color: Colors.blue,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14)),
                onPressed: () async {
                  await truecaller.getProfile();
                  FlutterTruecaller.manualVerificationRequired
                      .listen((isrequired) {
                    if (isrequired) {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (context) => VerifyMobileNUmber(),
                        ),
                      );
                    } else {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (context) => HomePage(),
                        ),
                      );
                    }
                  });
                },
                child: Container(
                  height: 50,
                  child: Center(
                    child: Text(
                      'Mobile Number'.toUpperCase(),
                      style: TextStyle(
                          fontStyle: FontStyle.normal,
                          fontSize: 16,
                          color: Colors.white),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
