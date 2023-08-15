import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mathlab/Constants/colors.dart';
import 'package:mathlab/Constants/sizer.dart';
import 'package:mathlab/Constants/textstyle.dart';
import 'package:mathlab/components/nameEdit.dart';
import 'package:mathlab/screen/enrolledCourse.dart';
import 'package:mathlab/screen/login.dart';
import 'package:mathlab/screen/privacyPolicy.dart';
import 'package:mathlab/screen/purchase.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

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
      backgroundColor: Colors.white.withOpacity(.8),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              height(30),
              Container(
                alignment: Alignment.center,
                child: tx600("Settings", size: 20, color: Colors.black),
              ),
              height(30),
              if (false)
                Container(
                  margin: EdgeInsets.all(10),
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 90,
                        height: 90,
                        child: Image.network(
                            "https://www.murrayglass.com/wp-content/uploads/2020/10/avatar-2048x2048.jpeg"),
                      ),
                      Column(
                        children: [],
                      )
                    ],
                  ),
                ),
              InkWell(
                onTap: () {
                  //  changeName();
                  Fluttertoast.showToast(msg: "Currently unavailable");
                },
                child: profilelistCard(
                    "Edit profile",
                    "The basic of your profile and general information",
                    Icons.person_2_outlined,
                    istop: true),
              ),
              InkWell(
                onTap: () {
                  // Navigator.of(context).push(
                  //   MaterialPageRoute(builder: (ctx) => purchaseHistory()));
                  Fluttertoast.showToast(
                      msg: "Online Payment method not  eabled");
                },
                child: profilelistCard(
                    "Purchanse History",
                    "Histroy of course, subject and other ads free purchase",
                    Icons.monetization_on),
              ),
              InkWell(
                onTap: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (ctx) => enrolledCourse()));
                },
                child: profilelistCard(
                    "Enrolled Course",
                    "Details of enrolled course, renewal data, and content ",
                    Icons.featured_play_list_outlined),
              ),
              InkWell(
                  onTap: () {
                    launchUrl(Uri.parse("https://mathlabcochin.com/#about"),
                        mode: LaunchMode.externalApplication);
                  },
                  child: profileListCard2("About Us")),
              InkWell(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => PrivacyPolicyScreen()));
                  },
                  child: profileListCard2("Terms and Policy")),
              if (false) profileListCard2("Privacy Policy"),
              InkWell(
                  onTap: () {
                    launchUrl(Uri.parse("https://mathlabcochin.com/#enquiry"));
                  },
                  child: profileListCard2("Connect Us")),
              //Expanded(child: Container()),
              height(180),
              InkWell(
                onTap: () async {
                  SharedPreferences pref =
                      await SharedPreferences.getInstance();
                  pref.setString("LOGIN", "OUT");
                  Navigator.of(context).pop();
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (ctx) => LoginScreen()));
                },
                child: Container(
                  alignment: Alignment.center,
                  child: ButtonContainer(tx700("Logout", color: Colors.white),
                      width: 140),
                ),
              ),
              height(20)
            ],
          ),
        ),
      ),
    ));
  }

  Widget profileListCard2(String title, {bool istop = false}) {
    return Container(
      decoration: BoxDecoration(
          border: (istop)
              ? Border(
                  top: BorderSide(color: Colors.grey.withOpacity(.5)),
                  bottom: BorderSide(color: Colors.grey.withOpacity(.5)))
              : Border(bottom: BorderSide(color: Colors.grey.withOpacity(.5)))),
      child: Row(
        children: [
          width(20),
          Expanded(child: tx600(title, size: 13, color: Colors.black)),
          Icon(
            Icons.keyboard_arrow_right_rounded,
            size: 40,
          )
        ],
      ),
    );
  }

  profilelistCard(String title, String body, IconData icon,
      {bool istop = false}) {
    return Container(
      height: 80,
      decoration: BoxDecoration(
          border: (istop)
              ? Border(
                  top: BorderSide(color: Colors.grey.withOpacity(.5)),
                  bottom: BorderSide(color: Colors.grey.withOpacity(.5)))
              : Border(bottom: BorderSide(color: Colors.grey.withOpacity(.5)))),
      child: Row(
        children: [
          width(10),
          SizedBox(
            width: 50,
            height: 50,
            child: Icon(
              icon,
              size: 40,
              color: Colors.grey,
            ),
          ),
          width(6),
          Expanded(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              tx600(title, size: 13, color: Colors.black),
              tx500(body, size: 12, color: Colors.black.withOpacity(.5))
            ],
          )),
          Icon(
            Icons.keyboard_arrow_right_rounded,
            size: 40,
          )
        ],
      ),
    );
  }

  changeName() {
    showDialog(
        context: context,
        builder: ((context) => Padding(
              padding: MediaQuery.of(context).viewInsets,
              child: Material(
                  color: Colors.transparent,
                  child: Container(
                      alignment: Alignment.center, child: NameEdit())),
            )));
  }
}
