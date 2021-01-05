import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_truecaller/flutter_truecaller.dart';
import 'package:flutter_truecaller_app/home_page.dart';

class VerifyMobileNUmber extends StatefulWidget {
  @override
  _VerifyMobileNUmberState createState() => _VerifyMobileNUmberState();
}

class _VerifyMobileNUmberState extends State<VerifyMobileNUmber> {
  final TextEditingController _mobile = TextEditingController();

  final TextEditingController _firstName = TextEditingController();

  final TextEditingController _lastName = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _city = TextEditingController();
  final TextEditingController _pinCode = TextEditingController();
  final TextEditingController _otp = TextEditingController();

  final FlutterTruecaller truecaller = FlutterTruecaller();
  bool otpRequired = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: _mobile,
                decoration: InputDecoration(hintText: "Mobile Number"),
                keyboardType: TextInputType.phone,
              ),
            ),
            OutlineButton(
                onPressed: () async {
                  otpRequired =
                      await truecaller.requestVerification(_mobile.text);
                },
                child: Text("Verify")),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: _firstName,
                decoration: InputDecoration(hintText: "First Name"),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: _lastName,
                decoration: InputDecoration(hintText: "Last Name"),
              ),
            ),
            if (otpRequired)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: _otp,
                  decoration: InputDecoration(hintText: "OTP"),
                ),
              ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: _email,
                decoration: InputDecoration(hintText: "Email"),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: _city,
                decoration: InputDecoration(hintText: "City"),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: _pinCode,
                decoration: InputDecoration(hintText: "PinCode"),
              ),
            ),
            OutlineButton(
                onPressed: () async {
                  if (otpRequired) {
                    await truecaller.verifyOtp(
                        _firstName.text, _lastName.text, _otp.text);
                  } else {
                    Future.delayed(const Duration(seconds: 3));
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => HomePage()));
                  }
                },
                child: Text("Submit")),
            StreamBuilder<String>(
                stream: FlutterTruecaller.callback,
                builder: (context, snapshot) => Text(snapshot.data ?? " ")),
            StreamBuilder<FlutterTruecallerException>(
                stream: FlutterTruecaller.errors,
                builder: (context, snapshot) =>
                    Text(snapshot.hasData ? snapshot.data.errorMessage : "")),
            StreamBuilder<TruecallerProfile>(
                stream: FlutterTruecaller.trueProfile,
                builder: (context, snapshot) => Text(snapshot.hasData
                    ? snapshot.data.firstName + " " + snapshot.data.lastName
                    : "")),
          ],
        ),
      ),
    );
  }
}
