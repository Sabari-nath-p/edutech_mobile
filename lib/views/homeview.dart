import 'dart:convert';
import 'dart:io';

import 'package:engagespot_sdk/engagespot_sdk.dart';
import 'package:engagespot_sdk/models/Notifications.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:mathlab/Constants/colors.dart';
import 'package:mathlab/Constants/sizer.dart';
import 'package:mathlab/Constants/textstyle.dart';
import 'package:mathlab/Constants/urls.dart';
import 'package:mathlab/components/notificationicon.dart';
import 'package:mathlab/screen/notification.dart';
import 'package:mathlab/screen/course_overview.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../components/popularCourse.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
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
    loadpopularCouse();
    if (slidershowimages.isEmpty) loadSlideShow();
    loadNotification();
  }

  List popCourse = [];
  List slidershowimages = [];

  NotificationSet? notifications;
  loadNotification() async {
    //print("Notifications");
    notifications = await Engagespot.getNotifications();
    setState(() {});
    Engagespot.ListernMessage(onMessage: (message) {
      notifications!.notificationMessage!.insert(0, message);
      notifications!.unReadCount = notifications!.unReadCount! + 1;
      setState(() {});
    }, onReadAll: () {
      notifications!.unReadCount = 0;
      setState(() {});
    });

    if (Platform.isAndroid) {
      FirebaseMessaging.instance.getToken().then((value) {
        String? token = value;

        Engagespot.RegisterFCM(token!);
      });
    }
  }

  loadpopularCouse() async {
    final Response = await http
        .get(Uri.parse("$baseurl/applicationview/popularcourseview/"));
    if (Response.statusCode == 200) {
      setState(() {
        //print(Response.body);
        var js = json.decode(Response.body);

        for (var data in js) {
          //   popCourse = data["course"];
          //  //print(data);
          popCourse = data["course"];
        }
        //popCourse = js[0]["course"];
        //  //print(popCourse);
      });
    }
  }

  loadSlideShow() async {
    final response =
        await http.get(Uri.parse("$baseurl/applicationview/sliderimageview/"));

    if (response.statusCode == 200) {
      setState(() {
        var js = json.decode(response.body);
        slidershowimages = js;
        // //print(js);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          height(20),
          Row(
            children: [
              width(20),
              SizedBox(
                width: 140,
                height: 60,
                child: Image.asset(
                  "assets/icons/mathlablogo.png",
                ),
              ),
              Expanded(child: Container()),
              InkWell(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => NotificationScreen()));
                },
                child: myAppBarIcon(
                    notifications != null ? notifications!.unReadCount! : 0),
                // child: CircleAvatar(
                //     radius: 18,
                //     backgroundColor: Colors.transparent,
                //     child: Image.network(
                //       "https://cdn4.iconfinder.com/data/icons/social-messaging-ui-coloricon-1/21/61_1-512.png",
                //       color: primaryColor,
                //     )),
              ),
              width(20),
            ],
          ),
          height(30),
          Container(
            width: MediaQuery.of(context).size.width,
            child: Row(
              children: [
                width(30),
                tx400("Hello, ${name.split(" ")[0]}", size: 20),
                Expanded(child: Container()),
                width(30)
              ],
            ),
          ),
          Container(
            alignment: Alignment.topLeft,
            margin: EdgeInsets.symmetric(horizontal: 30),
            child: tx500("Find Your Favorite Online Course",
                size: 20, color: Colors.black),
          ),
          height(10),
          if (slidershowimages.isNotEmpty)
            Container(
              margin: EdgeInsets.symmetric(horizontal: 30),
              height: 160,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: ImageSlideshow(children: [
                  for (var data in slidershowimages)
                    Image.network(
                      data["images"],
                      fit: BoxFit.cover,
                    ),
                ]),
              ),
            ),
          //height(20),
          if (false)
            Container(
              margin: EdgeInsets.symmetric(horizontal: 30),
              child: tx700("Menu", size: 18, color: Colors.black),
            ),
          height(10),
          if (false)
            Container(
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.symmetric(horizontal: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      InkWell(
                        onTap: () {
                          /* Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => VideoPlayerScreen(
                                  chapterID: "1223",
                                  subjectID: "physics",
                                  courseID: "basicsmath",
                                )));*/
                          //    Navigator.of(context).push(MaterialPageRoute(
                          //      builder: (context) => chapterListScreen()));
                        },
                        child: Container(
                          height: 75,
                          width: 75,
                          padding: EdgeInsets.all(12),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Color(0xffBEFFD8)),
                          child: Image.network(
                              'https://cdn2.iconfinder.com/data/icons/university-set-5/512/15-256.png'),
                        ),
                      ),
                      tx400("Video", size: 13)
                    ],
                  ),
                  Column(
                    children: [
                      Container(
                        height: 75,
                        width: 75,
                        padding: EdgeInsets.all(12),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Color(0xffFFD0D0)),
                        child: Image.network(
                            'https://icon-library.com/images/icon-note/icon-note-22.jpg'),
                      ),
                      tx400("Note", size: 13)
                    ],
                  ),
                  Column(
                    children: [
                      Container(
                        height: 75,
                        width: 75,
                        padding: EdgeInsets.all(15),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Color(0xffD0D8FF)),
                        child: Image.network(
                            'https://pluspng.com/img-png/png-exam-education-exam-examination-grade-level-result-test-icon-512.png'),
                      ),
                      tx400("Exam", size: 13)
                    ],
                  ),
                  Column(
                    children: [
                      Container(
                        height: 75,
                        width: 75,
                        padding: EdgeInsets.all(12),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Color(0xffD0F4FF)),
                        child: Image.network(
                            'https://cdn2.iconfinder.com/data/icons/university-set-5/512/21-512.png'),
                      ),
                      tx400("Live", size: 13)
                    ],
                  )
                ],
              ),
            ),
          height(20),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 30),
            child: tx700("Popular Courses", size: 18, color: Colors.black),
          ),
          height(10),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                width(30),
                for (var data in popCourse) PopularCourse(id: data)
              ],
            ),
          )
        ],
      ),
    );
  }
}
