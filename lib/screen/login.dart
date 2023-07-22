import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:mathlab/Constants/colors.dart';
import 'package:mathlab/Constants/sizer.dart';
import 'package:mathlab/Constants/textstyle.dart';
import 'package:mathlab/Constants/urls.dart';
import 'package:mathlab/screen/homescreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // varible session
  bool passvisible = true;
  TextEditingController nameText = TextEditingController();
  TextEditingController emailText = TextEditingController();
  TextEditingController passwordText = TextEditingController();
  TextEditingController phoneText = TextEditingController();
  bool option =
      false; // check wheather login  or signup method false for login and true for signup

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    //loading = false;
    return SafeArea(
        child: Scaffold(
      body: Stack(
        children: [
          Positioned(
              top: 0,
              left: 20,
              right: 20,
              height: h * .4,
              child: Image.asset("assets/image/loginitem.png")),
          Positioned(
              top: 0,
              left: 100,
              right: 100,
              height: h * .4,
              child: Image.asset("assets/icons/mathlablogo.png")),
          Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              height: h * .62,
              child: Container(
                height: h * .62,
                width: double.infinity,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: primaryColor),
              )),
          Positioned(
              top: h * .37,
              left: 100,
              right: 100,
              height: 30,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  if (!option) tx600("Login", color: Colors.white),
                  if (option)
                    InkWell(
                        onTap: () {
                          setState(() {
                            option = false;
                          });
                        },
                        child: tx400("Login", color: Colors.white54)),
                  if (!option)
                    InkWell(
                        onTap: () {
                          setState(() {
                            option = true;
                          });
                        },
                        child: tx400("Signup", color: Colors.white54)),
                  if (option) tx600("Signup", color: Colors.white),
                ],
              )),
          Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              height: h * .54,
              child: Container(
                height: h * .54,
                width: double.infinity,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(50),
                        topRight: Radius.circular(50)),
                    color: Colors.white),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      height(30),
                      if (option)
                        Container(
                          width: 250,
                          height: 60,
                          margin: EdgeInsets.all(6),
                          child: TextField(
                            controller: nameText,
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontFamily: "Poppins",
                                color: Colors.black,
                                fontSize: 14),
                            decoration: InputDecoration(
                                isDense: false,
                                isCollapsed: false,
                                labelStyle: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontFamily: "Poppins",
                                    color: Colors.black,
                                    fontSize: 13),
                                hintText: "Name of Student",
                                labelText: "Name *"),
                          ),
                        ),
                      if (option || !option)
                        Container(
                          width: 250,
                          height: 60,
                          margin: EdgeInsets.all(6),
                          child: TextField(
                            controller: emailText,
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontFamily: "Poppins",
                                color: Colors.black,
                                fontSize: 14),
                            decoration: InputDecoration(
                                isDense: false,
                                isCollapsed: false,
                                labelStyle: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontFamily: "Poppins",
                                    color: Colors.black,
                                    fontSize: 13),
                                hintText: "Email ID",
                                labelText: "Email *"),
                          ),
                        ),
                      if (option)
                        Container(
                          width: 250,
                          height: 60,
                          margin: EdgeInsets.all(6),
                          child: TextField(
                            controller: phoneText,
                            keyboardType: TextInputType.phone,
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontFamily: "Poppins",
                                color: Colors.black,
                                fontSize: 14),
                            decoration: InputDecoration(
                                isDense: false,
                                isCollapsed: false,
                                labelStyle: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontFamily: "Poppins",
                                    color: Colors.black,
                                    fontSize: 13),
                                hintText: "Mobile",
                                labelText: "Mobile Number *"),
                          ),
                        ),
                      if (option || !option)
                        Container(
                          width: 250,
                          height: 60,
                          margin: EdgeInsets.all(6),
                          child: TextField(
                            controller: passwordText,
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontFamily: "Poppins",
                                color: Colors.black,
                                fontSize: 14),
                            obscureText: passvisible,
                            decoration: InputDecoration(
                                isDense: false,
                                isCollapsed: false,
                                labelStyle: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontFamily: "Poppins",
                                    color: Colors.black,
                                    fontSize: 13),
                                suffix: InkWell(
                                    onTapDown: (value) {
                                      setState(() {
                                        passvisible = false; //!passvisible;
                                      });
                                    },
                                    onTapUp: (value) {
                                      setState(() {
                                        passvisible = true; //!passvisible;
                                      });
                                    },
                                    child: tx400(
                                        (passvisible) ? "show" : "hide",
                                        size: 12,
                                        color: Colors.black87)),
                                hintText: "Password",
                                labelText: "Password *"),
                          ),
                        ),
                    ],
                  ),
                ),
              )),
          if (!option)
            Positioned(
                bottom: 55,
                left: 50,
                right: 50,
                child: InkWell(
                  onTap: () {
                    if (emailText.text.isNotEmpty &&
                        passwordText.text.isNotEmpty) {
                      setState(() {
                        loading = true;
                        sendlogin(
                            emailText.text.trim(), passwordText.text.trim());
                      });
                    } else {
                      Fluttertoast.showToast(
                          msg: "Please fill form to continue");
                    }
                  },
                  child: ButtonContainer(
                      (loading)
                          ? LoadingAnimationWidget.staggeredDotsWave(
                              color: Colors.white, size: 30)
                          : tx700("Login", color: Colors.white),
                      radius: 15,
                      height: 54),
                )),
          if (option)
            Positioned(
                bottom: 55,
                left: 50,
                right: 50,
                child: InkWell(
                  onTap: () {
                    if (nameText.text.isNotEmpty &&
                        emailText.text.isNotEmpty &&
                        phoneText.text.isNotEmpty &&
                        passwordText.text.isNotEmpty) {
                      setState(() {
                        loading = true;
                        sendsignup(
                            emailText.text.trim(),
                            passwordText.text.trim(),
                            nameText.text.trim(),
                            phoneText.text.trim());
                      });
                    } else {
                      Fluttertoast.showToast(
                          msg: "Please fill form to continue");
                    }
                  },
                  child: ButtonContainer(
                      (loading)
                          ? LoadingAnimationWidget.staggeredDotsWave(
                              color: Colors.white, size: 30)
                          : tx700("Signup", color: Colors.white),
                      radius: 15,
                      height: 54),
                ))
        ],
      ),
    ));
  }

  sendlogin(String email, String password) async {
    setState(() {
      loading = true;
    });

    final Response = await http.post(Uri.parse("$baseurl/users/login/"), body: {
      "username": email,
      "password": password,
    }, headers: {
      "Vary": "Accept"
    });

    print(Response.body);
    print(Response.statusCode);
    if (Response.statusCode == 200) {
      var js = json.decode(Response.body);

      //  print(js["token"]);
      //  print(js);

      if (js == "The username or password is incorrect") {
        Fluttertoast.showToast(msg: "Invalid credentials");
        setState(() {
          loading = false;
        });
      } else {
        SharedPreferences pref = await SharedPreferences.getInstance();
        pref.setString("LOGIN", "IN");
        pref.setString("EMAIL", email);
        pref.setString("PASSWORD", password);
        pref.setString("TOKEN", js["token"]);
        Navigator.of(context).pop();
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => HomeScreen()));
      }
      print("working");
    } else {
      setState(() {
        loading = false;
      });
      Fluttertoast.showToast(msg: "Invalid Credentials");
    }
  }

  bool loading = false;
  sendsignup(String email, String password, String name, String phone) async {
    setState(() {
      loading = true;
    });

    final Response =
        await http.post(Uri.parse("$baseurl/users/userRegistration/"), body: {
      "name": name,
      "username": email,
      "phone_number": phone,
      "password": password,
      "confirm_password": password,
    }, headers: {
      "Vary": "Accept"
    });

    if (Response.statusCode == 200 || Response.statusCode == 201) {
      var result = json.decode(Response.body);

      Fluttertoast.showToast(msg: "Welcome to MathLab Research");
      SharedPreferences pref = await SharedPreferences.getInstance();
      pref.setString("LOGIN", "IN");
      pref.setString("EMAIL", email);
      pref.setString("PASSWORD", password);
      pref.setString("NAME", name);
      pref.setString("PHONE", phone);
      print(result);
      Navigator.of(context).pop();
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => HomeScreen()));
    } else {
      var result = json.decode(Response.body);
      if (result["username"] != null)
        Fluttertoast.showToast(msg: "Invalid Credentials");
      if (result["password"] != null)
        Fluttertoast.showToast(
            msg:
                "Password must container uppercase , lowercase number and special character");
      if (result["non_field_error"] != null)
        Fluttertoast.showToast(msg: "Please fill data");
      setState(() {
        loading = false;
      });
    }
  }
}
