import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mathlab/Constants/colors.dart';
import 'package:mathlab/Constants/urls.dart';
import 'package:mathlab/screen/ErrorPage.dart';
import 'package:mathlab/screen/exam/models/ExamData.dart';
import 'package:mathlab/screen/homescreen.dart';
import 'package:mathlab/screen/splash.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

String log = "";
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Stripe.publishableKey =
      "pk_test_51NE9LVSDCM0Xaplj4b0VcHk8hHU8On1eu6lEIkSUllPcR1JqwsjHO2kYwoOV2gC5A2lhuO6Kg4x0mFMRuroTHqFr00r82wktSn";

  SharedPreferences pref = await SharedPreferences.getInstance();
  log = pref.getString("LOGIN").toString();

  if (log == "IN") {
    String email = pref.getString("EMAIL").toString();
    String token = pref.getString("TOKEN").toString();
    final response = await http.get(
        Uri.parse("$baseurl/applicationview/userlist/$email/"),
        headers: ({"Authorization": "token $token"}));

    if (response.statusCode == 401) {
      Fluttertoast.showToast(msg: "Please reauthenticate");
      log = "out";
      pref.setString("LOGIN", "OUT");
    } else if (response.statusCode == 200) {
      //Fluttertoast.showToast(msg: msg)
    } else {
      log = "error";
    }
  }
  runApp(mathlab());
}

class mathlab extends StatelessWidget {
  const mathlab({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primaryColor: primaryColor),
      darkTheme: ThemeData(primaryColor: primaryColor),
      home: (log == "IN")
          ? HomeScreen()
          : (log == "error")
              ? ErrorPage()
              : SplashScreen(),
    );
  }
}
