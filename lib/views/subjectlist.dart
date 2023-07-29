import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:lottie/lottie.dart';
import 'package:mathlab/Constants/colors.dart';
import 'package:mathlab/Constants/sizer.dart';
import 'package:mathlab/Constants/textstyle.dart';
import 'package:mathlab/Constants/urls.dart';
import 'package:mathlab/screen/chapterlist.dart';
import 'package:http/http.dart' as http;

class SubjectListView extends StatefulWidget {
  var courseData;
  SubjectListView({super.key, required this.courseData});

  @override
  State<SubjectListView> createState() =>
      _SubjectListViewState(courseData: courseData);
}

class _SubjectListViewState extends State<SubjectListView> {
  var courseData;
  _SubjectListViewState({required this.courseData});
  List subjects = [];
  bool loadFinish = false;
  loadSubjects() async {
    final Response = await http.get(
        Uri.parse(
            "$baseurl/applicationview/courses/${courseData["course_unique_id"]}/subjects/"),
        headers: ({"Vary": "Accept"}));

    if (Response.statusCode == 200) {
      var js = json.decode(Response.body);
      print(js);
      setState(() {
        for (var data in js) {
          subjects.add(data);
          loadFinish = true;
        }
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (subjects.isEmpty) loadSubjects();
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
                    height: 112,
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
                            width(10),
                            Expanded(
                                child: Container(
                              alignment: Alignment.center,
                              child: tx700(courseData["field_of_study"],
                                  color: Colors.white, size: 22),
                            )),
                            width(60)
                          ],
                        ),
                        // height(10),
                        // tx700("", color: Colors.black, size: 25),
                      ],
                    ),
                  ),
                  if (subjects.isEmpty)
                    Expanded(
                        child: Container(
                      decoration: BoxDecoration(
                          color: Colors.white.withOpacity(.98),
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(50),
                              topRight: Radius.circular(50))),
                      child: Center(
                        child: SizedBox(
                            height: 200,
                            width: 200,
                            child: LoadingAnimationWidget.beat(
                                color: primaryColor, size: 40)),
                      ),
                    )),
                  if (!subjects.isEmpty)
                    Expanded(
                        child: Container(
                      height: double.maxFinite,
                      decoration: BoxDecoration(
                          color: Colors.white.withOpacity(.98),
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(50),
                              topRight: Radius.circular(50))),
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            height(20),
                            for (var data in subjects)
                              if (data["modules"].isNotEmpty &&
                                  data["is_active"])
                                InkWell(
                                  onTap: () {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                chapterListScreen(
                                                  subjectId: data["subject_id"]
                                                      .toString(),
                                                  SubjectName: data["subjects"],
                                                  courseID: courseData[
                                                          "course_unique_id"]
                                                      .toString(),
                                                )));
                                  },
                                  child: subjectCard(data),
                                ),
                            height(20)
                          ],
                        ),
                      ),
                    ))
                ],
              ),
            )));
  }

  subjectCard(var data) {
    return Container(
      height: 80,
      padding: EdgeInsets.all(5),
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 4),
      decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.withOpacity(.4)),
          borderRadius: BorderRadius.circular(20)),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(20)),
        child: Row(
          children: [
            Container(
              width: 65,
              margin: EdgeInsets.all(5),
              decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(.09),
                  borderRadius: BorderRadius.circular(15)),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image.network(
                  (data["subject_image"] == null)
                      ? "https://th.bing.com/th/id/OIP.T173YISP_ZxI1btAPB2zbAAAAA?pid=ImgDet&w=421&h=421&rs=1"
                      : "${data["subject_image"]}",
                  fit: BoxFit.cover,
                ),
              ),
            ),
            width(6),
            Expanded(
                child: tx600("${data["subjects"]}",
                    color: Colors.black, size: 17)),
            Container(
              width: 65,
              margin: EdgeInsets.all(5),
              decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(.09),
                  borderRadius: BorderRadius.circular(10)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  tx700("${data["modules_count"]}",
                      size: 17, color: Colors.black),
                  tx700("Chapters", size: 8, color: Colors.black),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
