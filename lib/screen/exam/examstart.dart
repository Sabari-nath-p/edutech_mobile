import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:mathlab/Constants/colors.dart';
import 'package:mathlab/Constants/sizer.dart';
import 'package:mathlab/Constants/textstyle.dart';
import 'package:mathlab/Constants/urls.dart';
import 'package:mathlab/development.dart';
import 'package:mathlab/screen/exam/ExamMain.dart';
import 'package:mathlab/screen/exam/models/ExamData.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class ExamStart extends StatefulWidget {
  String courseid;
  String subjectid;
  String moduleid;
  String examid;
  ExamStart(
      {super.key,
      required this.courseid,
      required this.examid,
      required this.moduleid,
      required this.subjectid});

  @override
  State<ExamStart> createState() => _ExamStartState();
}

class _ExamStartState extends State<ExamStart> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    loadExamContent();
  }

  String examTitle = "";
  String examduration = "";
  String instructionSet = "";
  ExamData examData = ExamData();
  int timesecond = 0;
  loadExamContent() async {
    final response = await http.get(Uri.parse(
        "$baseurl/applicationview/courses/${widget.courseid}/subjects/${widget.subjectid}/modules/${widget.moduleid}/exams/${widget.examid}"));

    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      print(response.body);
      setState(() {
        examTitle = data["exam_name"];
        examduration = data["duration_of_exam"];
        instructionSet = data["instruction"];
        examData.fetchQuestion(data["multiplechoice"], "multiplechoice");
        examData.fetchQuestion(data["multiselect"], "multiselect");
        examData.fetchQuestion(data["numericals"], "numericals");
        examData.FetchExam(data);
        List tm = examduration.split(":");
        int second = int.parse(tm[2]);
        int minute = int.parse(tm[1]);
        int hour = int.parse(tm[0]);

        Duration duration =
            Duration(hours: hour, seconds: second, minutes: minute);
        timesecond = duration.inSeconds;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var js = json.decode(questionData);

    return SafeArea(
        child: Scaffold(
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            height(20),
            Row(
              children: [
                width(20),
                InkWell(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: Icon(Icons.arrow_back_ios_new_rounded)),
                Expanded(
                    child: Container(
                        constraints:
                            BoxConstraints(maxWidth: 200, maxHeight: 30),
                        alignment: Alignment.center,
                        child: tx600("Exam $examTitle",
                            textAlign: TextAlign.center,
                            size: 20,
                            color: Colors.black))),
                Icon(Icons.menu),
                width(20)
              ],
            ),
            height(30),
            if (examduration != "")
              tx600("\t\t\t\t\tTime", size: 18, color: Colors.black),
            if (examduration != "")
              Container(
                margin: EdgeInsets.all(20),
                height: 63,
                padding: EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Color(0xFFFFBB33)),
                child: Row(
                  children: [
                    tx600("$examduration", size: 20, color: Colors.white),
                    Expanded(child: Container()),
                    Icon(
                      Icons.play_arrow,
                      color: Colors.white,
                    ),
                    tx500(" Start", size: 18, color: Colors.white)
                  ],
                ),
              ),
            if (instructionSet != "")
              tx600("\t\t\t\t\tInstruction", size: 19, color: Colors.black),
            if (instructionSet != "")
              Expanded(
                  child: Container(
                margin: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                height: double.infinity,
                width: double.infinity,
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Color.fromARGB(255, 231, 231, 231)),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        child: Text(
                          "${instructionSet.replaceAll("\n", "\n\n-> ")}",
                          textAlign: TextAlign.justify,
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: Colors.black,
                              fontFamily: "Mullish"),
                        ),
                      )
                    ],
                  ),
                ),
              )),
            if (instructionSet != "")
              Container(
                alignment: Alignment.center,
                child: tx400("Click start to begin exam", size: 15),
              ),
            if (instructionSet != "")
              Container(
                  margin: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                  child: InkWell(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => examMain(
                                examData: examData,
                                second: timesecond,
                              )));
                    },
                    child: ButtonContainer(tx600("Start", color: Colors.white),
                        radius: 10, height: 50, color: primaryColor),
                  )),
            if (instructionSet == "")
              Expanded(
                child: Center(
                    child: SizedBox(
                  height: 200,
                  width: 200,
                  child: LoadingAnimationWidget.beat(
                      color: primaryColor, size: 40),
                )),
              ),
            height(30)
          ],
        ),
      ),
    ));
  }
}
