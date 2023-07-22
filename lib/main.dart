import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:mathlab/Constants/colors.dart';
import 'package:mathlab/screen/exam/models/ExamData.dart';
import 'package:mathlab/screen/homescreen.dart';
import 'package:mathlab/screen/splash.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'firebase_options.dart';

String log = "";
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Stripe.publishableKey =
      "pk_test_51NE9LVSDCM0Xaplj4b0VcHk8hHU8On1eu6lEIkSUllPcR1JqwsjHO2kYwoOV2gC5A2lhuO6Kg4x0mFMRuroTHqFr00r82wktSn";

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  SharedPreferences pref = await SharedPreferences.getInstance();
  log = pref.getString("LOGIN").toString();
  runApp(mathlab());
}

class mathlab extends StatelessWidget {
  const mathlab({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primaryColor: primaryColor),
      darkTheme: ThemeData(primaryColor: primaryColor),
      home: (log == "IN") ? HomeScreen() : SplashScreen(),
    );
  }
}
