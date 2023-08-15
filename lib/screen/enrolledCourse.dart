import 'dart:convert';
import 'package:intl/intl.dart';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mathlab/Constants/sizer.dart';
import 'package:mathlab/Constants/textstyle.dart';
import 'package:mathlab/Constants/urls.dart';
import 'package:mathlab/Datamodels/purchaseExam.dart';
import 'package:mathlab/main.dart';
import 'package:http/http.dart' as http;

class enrolledCourse extends StatefulWidget {
  const enrolledCourse({super.key});

  @override
  State<enrolledCourse> createState() => _enrolledCourseState();
}

class _enrolledCourseState extends State<enrolledCourse> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadEnrolledCourse();
  }

  List enrolls = [];

  loadEnrolledCourse() async {
    for (var data in purchaseCollection.keys) {
      setState(() {
        PurchaseCourse pk = purchaseCollection.get(data);
        enrolls.add(pk);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            //  height(20),
            Container(
              padding: EdgeInsets.only(top: 20, bottom: 10),
              color: Colors.white,
              child: Row(
                children: [
                  width(20),
                  InkWell(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: SizedBox(
                      width: 40,
                      height: 40,
                      child: CircleAvatar(
                          backgroundColor: Colors.grey.withOpacity(.1),
                          radius: 10,
                          child: Icon(
                            Icons.arrow_back_ios_new,
                            color: Colors.black,
                          )),
                    ),
                  ),
                  width(20),
                  tx700("Enrolled Course", size: 20),
                  //Icon(Icons.arrow_back_ios_new_outlined)
                ],
              ),
            ),

            for (PurchaseCourse data in enrolls)
              enrollCard(purchaseCourse: data)
          ],
        ),
      ),
    );
  }
}

class enrollCard extends StatefulWidget {
  PurchaseCourse purchaseCourse;
  enrollCard({super.key, required this.purchaseCourse});

  @override
  State<enrollCard> createState() => _enrollCardState();
}

class _enrollCardState extends State<enrollCard> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadCourseData();
    now = DateTime.parse(widget.purchaseCourse.expirationDate.toString());
  }

  String courseName = "";
  String expiryDate = "";
  DateTime now = DateTime.now();
  loadCourseData() async {
    final Response = await http.get(Uri.parse(
        "$baseurl/applicationview/courses/${widget.purchaseCourse.courseId}"));
    if (Response.statusCode == 200) {
      var js = json.decode(Response.body);
      setState(() {
        courseName = js["field_of_study"];

        expiryDate = DateFormat('dd-MM-yyyy ').format(now);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 3),
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(10)),
      child: Stack(
        children: [
          Positioned(
            left: 0,
            right: 0,
            top: 0,
            bottom: 0,
            child: Row(
              children: [
                SvgPicture.asset(
                  "assets/icons/class.svg",
                  color: Colors.grey,
                ),
                width(10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    tx600("$courseName", size: 15, color: Colors.black),
                    tx400("Validity : $expiryDate ",
                        size: 12, color: Colors.black),
                  ],
                )
              ],
            ),
          ),
          if (DateTime.now().isBefore(now))
            Positioned(
                right: 0,
                bottom: 0,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.green),
                  child: tx500("Active", size: 13, color: Colors.white),
                )),
          if (!DateTime.now().isBefore(now))
            Positioned(
                right: 0,
                bottom: 0,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.red),
                  child: tx500("Expired", size: 13, color: Colors.white),
                )),
        ],
      ),
    );
  }
}
