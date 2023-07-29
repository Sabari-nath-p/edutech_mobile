import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:mathlab/screen/homescreen.dart';
import 'package:mathlab/screen/login.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../Constants/colors.dart';
import '../Constants/urls.dart';
import '../main.dart';

class ErrorPage extends StatefulWidget {
  ErrorPage({super.key});

  @override
  State<ErrorPage> createState() => _ErrorPageState();
}

class _ErrorPageState extends State<ErrorPage> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(40.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: Image.asset("assets/image/errorimage.png"),
            ),
            if (!isLoading)
              InkWell(
                onTap: () async {
                  SharedPreferences pref =
                      await SharedPreferences.getInstance();
                  log = pref.getString("LOGIN").toString();
                  setState(() {
                    isLoading = true;
                  });

                  String email = pref.getString("EMAIL").toString();
                  String token = pref.getString("TOKEN").toString();
                  final response = await http.get(
                      Uri.parse("$baseurl/applicationview/userlist/$email/"),
                      headers: ({"Authorization": "token $token"}));

                  if (response.statusCode == 401) {
                    Fluttertoast.showToast(msg: "Please reauthenticate");
                    log = "out";
                    pref.setString("LOGIN", "OUT");
                    Navigator.of(context).pop();
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => LoginScreen()));

                    runApp(mathlab());
                  } else if (response.statusCode == 200) {
                    Navigator.of(context).pop();
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => HomeScreen()));
                    //  runApp(mathlab());
                  } else {
                    setState(() {
                      isLoading = false;
                    });

                    Fluttertoast.showToast(msg: "Could't Resolve");
                    log = "error";
                  }
                },
                child: Container(
                  padding: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.grey),
                  ),
                  child: Text("Try Again"),
                ),
              ),
            if (isLoading)
              SizedBox(
                  child: LoadingAnimationWidget.beat(
                      color: primaryColor, size: 40))
          ],
        ),
      ),
    );
  }
}
