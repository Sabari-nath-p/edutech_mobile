import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mathlab/Constants/colors.dart';
import 'package:mathlab/Constants/sizer.dart';
import 'package:mathlab/Constants/textstyle.dart';
import 'package:mathlab/screen/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

class profileView extends StatefulWidget {
  const profileView({super.key});

  @override
  State<profileView> createState() => _profileViewState();
}

class _profileViewState extends State<profileView> {
  String name = '';

  loaddata() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      name = pref.getString("NAME").toString();
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loaddata();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        padding: EdgeInsets.all(30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            height(20),
            InkWell(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: CircleAvatar(
                    radius: 20,
                    backgroundColor: Colors.grey.withOpacity(.1),
                    child: Icon(Icons.arrow_back_ios_new))),
            height(30),
            Container(
              alignment: Alignment.topCenter,
              child: Column(
                children: [
                  CircleAvatar(
                      radius: 65,
                      backgroundColor: Colors.transparent,
                      child: ClipRRect(
                        child: Image.network(
                            "https://www.clipartkey.com/mpngs/m/208-2089363_user-profile-image-png.png"),
                      )),
                  tx600("$name", size: 18, color: Colors.black),
                  Image.asset(
                    "assets/icons/student_badge.png",
                    width: 100,
                    height: 70,
                  )
                ],
              ),
            ),
            height(20),
            Row(
              children: [
                tx700("Current Course ", size: 17),
                Expanded(child: Container()),
                ButtonContainer(Row(
                  children: [
                    tx600("Plus One", color: Colors.white),
                    Icon(
                      Icons.arrow_drop_down,
                      size: 30,
                      color: Colors.white,
                    )
                  ],
                ))
              ],
            ),
            height(20),
            tx700("Account Setting ", size: 17),
            height(10),
            tx600("Edit Profile", size: 15, color: Colors.black),
            height(5),
            tx600("Rate us", size: 15, color: Colors.black),
            height(5),
            tx600("Privacy Policy", size: 15, color: Colors.black),
            Expanded(child: Container()),
            Container(
              alignment: Alignment.center,
              child: InkWell(
                  onTap: () async {
                    SharedPreferences pref =
                        await SharedPreferences.getInstance();
                    pref.setString("LOGIN", "OUT");
                    Navigator.of(context).pop();
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => LoginScreen()));
                  },
                  child: tx700("Logout", color: primaryColor, size: 17)),
            )
          ],
        ),
      ),
    ));
  }
}
