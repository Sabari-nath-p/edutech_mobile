import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:flutter_windowmanager/flutter_windowmanager.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mathlab/Constants/colors.dart';
import 'package:mathlab/Constants/urls.dart';
import 'package:mathlab/Datamodels/purchaseExam.dart';
import 'package:mathlab/screen/ErrorPage.dart';
import 'package:mathlab/screen/exam/models/ExamData.dart';
import 'package:mathlab/screen/homescreen.dart';
import 'package:mathlab/screen/login.dart';
import 'package:mathlab/screen/splash.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

String log = "";
late Box purchaseCollection;
void main() async {
  await Hive.initFlutter();
  WidgetsFlutterBinding.ensureInitialized();

  // HttpOverrides.global = MyHttpOverrides();
  Stripe.publishableKey =
      "pk_test_51NE9LVSDCM0Xaplj4b0VcHk8hHU8On1eu6lEIkSUllPcR1JqwsjHO2kYwoOV2gC5A2lhuO6Kg4x0mFMRuroTHqFr00r82wktSn";

  SharedPreferences pref = await SharedPreferences.getInstance();
  HttpOverrides.global = MyHttpOverrides();
  await FlutterWindowManager.addFlags(FlutterWindowManager.FLAG_SECURE);
  log = pref.getString("LOGIN").toString();
  if (!Hive.isAdapterRegistered(PurchaseCourseAdapter().typeId)) {
    Hive.registerAdapter(PurchaseCourseAdapter());
  }
  purchaseCollection = await Hive.openBox("PURCHASED");
  print(checkCourseActive(6));
  if (log == "IN") {
    String email = pref.getString("EMAIL").toString();
    String token = pref.getString("TOKEN").toString();
    final response = await http.get(
        Uri.parse("$baseurl/applicationview/userlist/$email/"),
        headers: ({"Authorization": "token $token"}));
    print(response.body);
    if (response.statusCode == 401) {
      Fluttertoast.showToast(msg: "Please reauthenticate");
      log = "out";
      pref.setString("LOGIN", "OUT");
    } else if (response.statusCode == 200) {
      //Fluttertoast.showToast(msg: msg)
      var js = json.decode(response.body);
      updatePurchaseCourse(js["purchase_list"]["purchased_courses"]);
      addExamResponse(js["exam_response"]);
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
              : LoginScreen(),
    );
  }
}

updatePurchaseCourse(var purchanseCoures) {
  //Box bk =a Hive.openBox("PURCHASED");
  for (var data in purchanseCoures) {
    PurchaseCourse pc = PurchaseCourse.fromJson(data);
    //print(purchaseCourse.toJson());
    purchaseCollection.put(pc.courseId, pc);
  }
}

addExamResponse(var response) async {
  Box bx = await Hive.openBox("EXAM_RESULT");

  for (var data in response) {
    bx.put(data["exam_id"].toString(), data);
  }
}

bool checkCourseActive(int id) {
//  Box bk = await Hive.openBox("PURCHASED");
  var source = purchaseCollection.get(id);
  //print(source.expirationDate);

  if (source != null) {
    DateTime expiryDate = DateTime.parse(source.expirationDate.toString());
    DateTime currentDate = DateTime.now();
    if (currentDate.isBefore(expiryDate)) {
      return true;
    } else
      return false;
  } else {
    return false;
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
