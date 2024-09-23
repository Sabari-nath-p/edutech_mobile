import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:mathlab/Constants/colors.dart';
import 'package:mathlab/Constants/urls.dart';
import 'package:mathlab/main.dart';
import 'package:mathlab/screen/homescreen.dart';
import 'package:pinput/pinput.dart';
import 'package:shared_preferences/shared_preferences.dart';

class otpVerifyScreen extends StatefulWidget {
  String phone;
  bool phoneOnly;
  otpVerifyScreen({super.key, required this.phone, this.phoneOnly = false});

  @override
  State<otpVerifyScreen> createState() => _otpVerifyScreenState();
}

class _otpVerifyScreenState extends State<otpVerifyScreen> {
  bool loading = false;
  TextEditingController otpController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.only(top: 20),
              decoration: BoxDecoration(color: Colors.white, boxShadow: [
                BoxShadow(
                    spreadRadius: .3,
                    blurRadius: 3,
                    color: Colors.grey.withOpacity(.1))
              ]),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 10,
                  ),
                  IconButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      icon:
                          Icon(Icons.arrow_back_ios_new, color: primaryColor)),
                  SizedBox(
                    width: 100,
                    height: 35,
                    child: Image.asset(
                      'assets/icons/mathlablogo.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: density(30),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: density(30)),
              width: density(250),
              alignment: Alignment.topLeft,
              child: Text(
                'Enter the OTP sent to ${widget.phone}',
                style: TextStyle(
                  fontSize: 16,
                  fontFamily: "Poppins",
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              // width: 300,
              height: 90,
              margin: EdgeInsets.symmetric(horizontal: density(30)),
              child: Pinput(
                controller: otpController,
                length: 6,
                // :
                //     AndroidSmsAutofillMethod.smsUserConsentApi,
                defaultPinTheme: PinTheme(
                    width: density(45),
                    height: density(45),
                    textStyle: TextStyle(
                        //  color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 18),
                    decoration: BoxDecoration(
                        border:
                            Border.all(color: Color.fromARGB(255, 11, 11, 11)),
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10))),
              ),
            ),
            Row(
              children: [
                SizedBox(
                  width: density(33),
                ),
                Text(
                  'Didn’t receive it ?',
                  style: TextStyle(
                    fontFamily: "Poppins",
                    fontWeight: FontWeight.w500,
                  ),
                ),
                InkWell(
                  onTap: () {
                    Fluttertoast.showToast(msg: "OTP resend Successfully");
                  },
                  child: Text(
                    ' Resend',
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                        fontFamily: 'Poppins'),
                  ),
                ),
                // Countdown(
                //   seconds: 30,
                //   build: (BuildContext context, double time) {
                //     int rev = time.toInt();
                //     String t = rev.toString();
                //     if (rev < 10) {
                //       t = '0$rev';
                //     }
                //     return Text(t,
                //         style: TextStyle(
                //             fontSize: 14,
                //             fontWeight: FontWeight.w500,
                //             color: Colors.blue,
                //             fontFamily: 'Axiforma'));
                //   },
                //   controller: resend.resume(),
                //   onFinished: () {},
                // )
              ],
            ),
            SizedBox(
              height: 20,
            ),
            InkWell(
              onTap: () async {
                if (otpController.text.isEmpty) {
                  Fluttertoast.showToast(msg: "Please enter OTP");
                } else if (loading) {
                  Fluttertoast.showToast(msg: "Please wait verifying");
                } else {
                  setState(() {
                    loading = true;
                  });

                  final Response = await post(
                      Uri.parse(baseurl + "/users/verify-login-otp-mobile/"),
                      body: {
                        "phone": widget.phone,
                        "otp": otpController.text,
                      });
                  //print(Response.statusCode);
                  //print(Response.body);
                  setState(() {
                    loading = false;
                  });
                  if (Response.statusCode == 200) {
                    var result = json.decode(Response.body);

                    if (!widget.phoneOnly) {
                      Fluttertoast.showToast(msg: "OTP verified successfully ");
                      SharedPreferences pref =
                          await SharedPreferences.getInstance();
                      pref.setString("LOGIN", "IN");
                      pref.setString("TOKEN", result["token"]);
                      token = result["token"];
                      Navigator.of(context).pop();
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => HomeScreen()));
                    } else {
                      Fluttertoast.showToast(
                          msg:
                              "OTP verified successfully , Please login with email and password");
                      Navigator.of(context).pop();
                    }
                  } else {
                    Fluttertoast.showToast(msg: "OTP does not match");
                  }
                }
              },
              child: Container(
                  width: double.infinity,
                  height: density(50),
                  margin: EdgeInsets.symmetric(horizontal: (20)),
                  decoration: BoxDecoration(
                    color: primaryColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  alignment: Alignment.center,
                  child: (loading)
                      ? LoadingAnimationWidget.staggeredDotsWave(
                          color: Colors.white, size: 24)
                      : Text(
                          'Verify OTP',
                          style: TextStyle(
                              fontSize: 18,
                              fontFamily: 'Axiforma',
                              color: Colors.white,
                              fontWeight: FontWeight.w600),
                        )),
            ),
            SizedBox(
              height: 20,
            )
          ],
        ),
      ),
    );
  }

  double density(
    double d,
  ) {
    double height = MediaQuery.of(context).size.height;
    double value = d * (height / 853);
    return value;
  }
}
