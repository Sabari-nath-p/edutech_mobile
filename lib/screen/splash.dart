import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:mathlab/Constants/sizer.dart';
import 'package:mathlab/Constants/textstyle.dart';
import 'package:mathlab/development.dart';
import 'package:mathlab/screen/login.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        width: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            children: [
              height(density(100)),
              tx600("Learn Online From \nYour Home",
                  size: 22, color: Colors.black, textAlign: TextAlign.center),
              height(10),
              Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.symmetric(horizontal: density(40)),
                  child: tx600(s1,
                      size: 14,
                      family: "Mullish",
                      textAlign: TextAlign.center)),
              Positioned(
                top: 0,
                width: density(320),
                height: density(460),
                right: 40,
                child: Image.asset(
                  "assets/image/splash1.png",
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => LoginScreen()));
                },
                child: ButtonContainer(
                    tx700("Get Started", size: 18, color: Colors.white),
                    radius: 15,
                    color: Color(0xffBB2828),
                    width: density(250),
                    height: 55),
              ),
              Positioned(
                  top: density(465),
                  left: 40,
                  right: 40,
                  child: tx600(
                      "By accepting, you have agreed our privacy policy",
                      size: 11)),
              height(density(50))
            ],
          ),
        ),
      ),
    ));
  }

  double density(
    double d,
  ) {
    double height = MediaQuery.of(context).size.width;
    double value = d * (height / 390);
    return value;
  }
}
