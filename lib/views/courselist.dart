import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:mathlab/Constants/colors.dart';
import 'package:mathlab/Constants/sizer.dart';
import 'package:mathlab/Constants/textstyle.dart';
import 'package:mathlab/Constants/urls.dart';
import 'package:mathlab/screen/chapterlist.dart';
import 'package:http/http.dart' as http;
import 'package:mathlab/views/subjectlist.dart';

List course = [];

class CourseListView extends StatefulWidget {
  CourseListView({super.key});

  @override
  State<CourseListView> createState() => _CourseListViewState();
}

class _CourseListViewState extends State<CourseListView> {
  loadcourse() async {
    final Response = await http.get(
        Uri.parse("$baseurl/applicationview/courses/"),
        headers: ({"Vary": "Accept"}));

    if (Response.statusCode == 200) {
      var js = json.decode(Response.body);
      print(js);
      setState(() {
        for (var data in js) {
          course.add(data);
        }
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (course.isEmpty) loadcourse();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            backgroundColor: primaryColor, // Color(0xff26202C),
            body: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 100,
                    decoration: BoxDecoration(

                        // border: Border(
                        //   bottom: BorderSide(color: Colors.grey.withOpacity(.7))),
                        ),
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: SizedBox(
                                  height: 60,
                                  child: CircleAvatar(
                                      backgroundColor: Colors.white54,
                                      child: Icon(
                                        Icons.arrow_back_ios_rounded,
                                        color: Colors.black,
                                      ))
                                  //Image.asset("assets/icons/mathlablogo.png"),
                                  ),
                            ),
                            Expanded(
                                child: Container(
                              alignment: Alignment.center,
                              child: tx700("Courses",
                                  color: Colors.white, size: 23),
                            )),
                            width(60)
                          ],
                        ),
                        // height(10),
                        // tx700("", color: Colors.black, size: 25),
                      ],
                    ),
                  ),
                  Expanded(
                      child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: Colors.white.withOpacity(.98),
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(50),
                            topRight: Radius.circular(50))),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          height(20),
                          for (var data in course)
                            if (data["is_active"] && data["subjects_count"] > 0)
                              InkWell(
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => SubjectListView(
                                            courseData: data,
                                          )));
                                },
                                child: subjectCard(data),
                              )
                        ],
                      ),
                    ),
                  ))
                ],
              ),
            )));
  }

  subjectCard(var data) {
    String subjects = "";
    for (var sub in data["subjects"]) subjects = "${subjects} ${sub},";
    return Container(
      height: 120,
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20), color: Colors.white),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                    constraints: BoxConstraints(maxHeight: 56),
                    child: tx600(data["field_of_study"],
                        size: 18, color: Colors.black)),
                height(1),
                tx600("${data["subjects_count"]} subject included",
                    size: 12, color: Colors.black),
                Expanded(
                    child: SizedBox(
                  width: 230,
                  child: tx500(data["Course_description"],
                      size: 14, color: Colors.black),
                )),
                tx400("Powered by Mathlab", size: 12),
              ],
            ),
          ),
          SizedBox(
            width: 70,
            height: 70,
            child: (data["course_image"] == null)
                ? Image.network(
                    "https://th.bing.com/th/id/OIP.T173YISP_ZxI1btAPB2zbAAAAA?pid=ImgDet&w=421&h=421&rs=1")
                : Image.network(data["course_image"]),
          )
        ],
      ),
    );
  }
}
