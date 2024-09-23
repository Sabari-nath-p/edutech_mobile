import 'dart:convert';
import 'dart:io';

import 'package:engagespot_sdk/engagespot_sdk.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_windowmanager/flutter_windowmanager.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/connect.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mathlab/Constants/colors.dart';
import 'package:mathlab/Constants/urls.dart';
import 'package:mathlab/Datamodels/pexam.dart';
import 'package:mathlab/Datamodels/purchaseExam.dart';
import 'package:mathlab/firebase_options.dart';
import 'package:mathlab/notificationSetup.dart';
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
late Box PX;

void main() async {
  await Hive.initFlutter();
  WidgetsFlutterBinding.ensureInitialized();

  if (Platform.isAndroid) {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    notificationSetup();
  }

  SharedPreferences pref = await SharedPreferences.getInstance();
  HttpOverrides.global = MyHttpOverrides();
  if (Platform.isAndroid)
    await FlutterWindowManager.addFlags(FlutterWindowManager.FLAG_SECURE);
  Engagespot.initSdk(apiKey: "4j76o2qeddbwmfqat1pczp");

  log = pref.getString("LOGIN").toString();
  if (!Hive.isAdapterRegistered(PurchaseCourseAdapter().typeId)) {
    Hive.registerAdapter(PurchaseCourseAdapter());
  }
  if (!Hive.isAdapterRegistered(PEXAMAdapter().typeId)) {
    Hive.registerAdapter(PEXAMAdapter());
  }
  purchaseCollection = await Hive.openBox("PURCHASED");
  PX = await Hive.openBox("EXAM");

  if (log == "IN") {
    await fetchUserProfile(pref);
  }
  runApp(mathlab());
}

class mathlab extends StatelessWidget {
  const mathlab({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData(primaryColor: primaryColor),
      debugShowCheckedModeBanner: false,
      darkTheme: ThemeData(primaryColor: primaryColor),
      home: (log == "IN")
          ? HomeScreen()
          : (log == "error")
              ? ErrorPage()
              : LoginScreen(),
    );
  }
}

updatePurchaseCourse(var purchanseCoures, var purchaseExam) {
  //Box bk =a Hive.openBox("PURCHASED");

  for (var data in purchanseCoures) {
    PurchaseCourse pc = PurchaseCourse.fromJson(data);
    ////print(purchaseCourse.toJson());
    if (data["isPaid"] ?? true) purchaseCollection.put(pc.courseId, pc);
  }

  for (var data in purchaseExam) {
    PEXAM pc = PEXAM.fromJson(data);
    ////print(purchaseCourse.toJson());
    //print(pc.courseId);
    PX.put(pc.courseId, pc);
  }
}

addExamResponse(var response) async {
  Box bx = await Hive.openBox("EXAM_RESULT");
  if (response != null)
    for (var data in response) {
      bx.put(data["exam_id"].toString(), data);
    }
}

bool checkCourseActive(int id) {
//  Box bk = await Hive.openBox("PURCHASED");
  var source = purchaseCollection.get(id);
  ////print(source.expirationDate);

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

bool checkActiveExam(int id) {
//  Box bk = await Hive.openBox("PURCHASED");

  var source = PX.get(id);
  ////print(source.expirationDate);

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

String token = "";

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

Future fetchUserProfile(SharedPreferences pref) async {
  String email = pref.getString("EMAIL").toString();
  token = pref.getString("TOKEN").toString();
  final response = await http.get(
      Uri.parse("$baseurl/applicationview/get-user-profile"),
      headers: ({"Authorization": "token $token"}));

  if (response.statusCode == 401) {
    Fluttertoast.showToast(msg: "Please reauthenticate");
    log = "out";
    pref.setString("LOGIN", "OUT");
  } else if (response.statusCode == 200) {
    //Fluttertoast.showToast(msg: msg)
    var js = json.decode(response.body);
    var list = (js["data"]["purchase_list"] != null &&
            js["data"]["purchase_list"]["purchased_courses"] != null)
        ? js["data"]["purchase_list"]["purchased_courses"]
        : [];
    var list2 = (js["data"]["purchase_list"] != null &&
            js["data"]["purchase_list"]["purchased_exams"] != null)
        ? js["data"]["purchase_list"]["purchased_exams"]
        : [];

    Engagespot.LoginUser(userId: email.toString());
    updatePurchaseCourse(list, list2);

    addExamResponse(js["data"]["exam_response"]);
  } else {
    log = "error";
  }
}
