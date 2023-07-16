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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            height(100),
            tx600("Learn Online From \nYour Home",
                size: 22, color: Colors.black, textAlign: TextAlign.center),
            height(10),
            Container(
                alignment: Alignment.center,
                margin: EdgeInsets.symmetric(horizontal: 40),
                child: tx600(s1,
                    size: 14, family: "Mullish", textAlign: TextAlign.center)),
            Expanded(
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 10),
                child: Stack(
                  children: [
                    Positioned(
                      top: 0,
                      width: 320,
                      height: 460,
                      right: 40,
                      child: Image.asset(
                        "assets/image/splash1.png",
                      ),
                    ),
                    Positioned(
                        left: 45,
                        right: 45,
                        top: 400,
                        child: InkWell(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => LoginScreen()));
                          },
                          child: ButtonContainer(
                              tx700("Get Started",
                                  size: 18, color: Colors.white),
                              radius: 15,
                              color: Color(0xffBB2828),
                              height: 55),
                        )),
                    Positioned(
                        top: 465,
                        left: 40,
                        right: 40,
                        child: tx600(
                            "By accepting, you have agreed our privacy policy",
                            size: 11))
                  ],
                ),
              ),
            ),
            height(50)
          ],
        ),
      ),
    ));
  }
}
