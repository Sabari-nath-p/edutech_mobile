import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:mathlab/Constants/colors.dart';
import 'package:mathlab/Constants/sizer.dart';
import 'package:mathlab/Constants/textstyle.dart';
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

  sendlogin(String email, String password) {
    setState(() {
      loading = true;
    });
    CollectionReference users = FirebaseFirestore.instance.collection('user');
    users.where("email", isEqualTo: email).get().then((value) async {
      if (value.docs.isNotEmpty) {
        if (password == value.docs[0].get("password").toString()) {
          print(value.docs[0].data());
          SharedPreferences pref = await SharedPreferences.getInstance();
          pref.setString("LOGIN", "IN");
          pref.setString("EMAIL", email);
          pref.setString("PASSWORD", password);
          pref.setString("NAME", value.docs[0].get("name").toString());
          Navigator.of(context).pop();
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => HomeScreen()));
        } else {
          setState(() {
            loading = false;
          });
          Fluttertoast.showToast(msg: "Login failed , invalid Credential");
        }
      } else {
        Fluttertoast.showToast(msg: "Login failed , invalid Credential");
        setState(() {
          loading = false;
        });
      }
    });
  }

  bool loading = false;
  sendsignup(String email, String password, String name, String phone) {
    setState(() {
      loading = true;
    });
    CollectionReference users = FirebaseFirestore.instance.collection('user');
    users.add({
      "password": password,
      "name": name,
      "date_joined": DateTime.now().toString(),
      "last_login": DateTime.now().toString(),
      "email": email,
      "phone_number": phone
    }).whenComplete(() async {
      Fluttertoast.showToast(msg: "Welcome to MathLab Research");
      SharedPreferences pref = await SharedPreferences.getInstance();
      pref.setString("LOGIN", "IN");
      pref.setString("EMAIL", email);
      pref.setString("PASSWORD", password);
      pref.setString("NAME", name);
      pref.setString("PHONE", phone);

      Navigator.of(context).pop();
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => HomeScreen()));
    }).onError((error, stackTrace) {
      setState(() {
        loading = false;
      });
      Fluttertoast.showToast(msg: "Something went to wrong, please try again");
      return users.doc();
    });
  }
}
