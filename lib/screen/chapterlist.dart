import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import 'package:mathlab/Constants/colors.dart';
import 'package:mathlab/Constants/sizer.dart';
import 'package:mathlab/Constants/textstyle.dart';
import 'package:http/http.dart' as http;
import 'package:mathlab/screen/videoplayer.dart';

import '../Constants/urls.dart';

class chapterListScreen extends StatefulWidget {
  String subjectId;
  String courseID;
  String SubjectName;
  chapterListScreen(
      {super.key,
      required this.courseID,
      required this.SubjectName,
      required this.subjectId});

  @override
  State<chapterListScreen> createState() => _chapterListScreenState(
      subjectId: subjectId, courseID: courseID, SubjectName: SubjectName);
}

class _chapterListScreenState extends State<chapterListScreen> {
  String subjectId;
  String courseID;
  String SubjectName;
  _chapterListScreenState(
      {required this.courseID,
      required this.SubjectName,
      required this.subjectId});
  List chapters = [];

  loadChapters() async {
    final Response = await http.get(Uri.parse(
        "$baseurl/applicationview/courses/$courseID/subjects/$subjectId/modules/"));
    //print(Response.statusCode);
    //print(Response.body);
    if (Response.statusCode == 200) {
      var js = json.decode(Response.body);
      setState(() {
        chapters = js;
      });
      //print(Response.body);
    }
  }

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
    loadChapters();
    //print("working");
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Container(
        //margin: EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 100,
              padding: EdgeInsets.symmetric(horizontal: 30),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(70)),
                  color: primaryColor.withOpacity(.9)),
              child: Row(
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: CircleAvatar(
                        backgroundColor: Colors.white.withOpacity(.1),
                        child: Icon(
                          Icons.arrow_back_ios_new,
                          color: Colors.white,
                        )),
                  ),
                  width(8),
                  Container(
                      width: 200,
                      child:
                          tx700("$SubjectName", size: 25, color: Colors.white)),
                  width(8),
                ],
              ),
            ),
            Expanded(
                child: SingleChildScrollView(
              child: Container(
                margin: EdgeInsets.only(left: 15, right: 50),
                child: Column(
                  children: [
                    height(20),
                    if (chapters.isEmpty)
                      Center(
                        child: SizedBox(
                            height: 200,
                            width: 200,
                            child: LoadingAnimationWidget.beat(
                                color: primaryColor, size: 40)),
                      ),
                    if (chapters.isNotEmpty)
                      for (var data in chapters)
                        if (data["is_active"] &&
                            (data["videos"].isNotEmpty ||
                                data["exams"].isNotEmpty ||
                                data["notes"].isNotEmpty))
                          InkWell(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => VideoPlayerScreen(
                                    chapterID: data["modules_id"].toString(),
                                    subjectID: widget.subjectId,
                                    courseID: widget.courseID),
                              ));
                            },
                            child:
                                chapterCard(data, chapters.indexOf(data) + 1),
                          )
                  ],
                ),
              ),
            ))
          ],
        ),
      ),
    ));
  }

  chapterCard(var data, int number) {
    return Container(
      height: 50,
      margin: EdgeInsets.symmetric(vertical: 3),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        // border: Border.all(color: primaryColor)
      ),
      child: Row(
        children: [
          width(10),
          Container(
            width: 35,
            height: 35,
            alignment: Alignment.center,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.grey.withOpacity(.2)),
            child: tx700(number.toString(), color: Colors.black54, size: 18),
          ),
          width(10),
          Expanded(
              child: tx500(data["module_name"], size: 15, color: Colors.black)),
          Icon(
            Icons.play_arrow,
            color: primaryColor,
            size: 30,
          ),
          width(10)
        ],
      ),
    );
  }
}
