import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
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
