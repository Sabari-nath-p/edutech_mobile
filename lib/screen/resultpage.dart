import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:mathlab/Constants/sizer.dart';
import 'package:mathlab/Constants/textstyle.dart';
import 'package:mathlab/screen/exam/models/ExamData.dart';

import 'exam/validationFile.dart';

class ResultPage extends StatefulWidget {
  const ResultPage({super.key});

  @override
  State<ResultPage> createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadAttendedExam();
  }

  List exams = [];
  loadAttendedExam() async {
    print("working");
    Box bk = await Hive.openBox("EXAM_RESULT");
    setState(() {
      for (var data in bk.keys) {
        print((data));
        print(bk.get(data));
        exams.add(bk.get(data));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          height(20),
          Container(
            alignment: Alignment.center,
            child: tx600("Attended Exam", size: 21, color: Colors.black),
          ),
          Container(
            width: 200,
            height: 2,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.black.withOpacity(.7)),
          ),
          for (var data in exams)
            InkWell(
              onTap: () {
                ExamData examData = ExamData();
                examData.id = int.parse(data["exam_id"]);
                // examData.fetchAnswer(data["response"]);

                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) =>
                        ExamAnswerValidation(examData: examData, data: data)));
              },
              child: Container(
                height: 80,
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                margin: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white),
                child: Row(
                  children: [
                    SvgPicture.asset("assets/icons/exam.svg"),
                    width(20),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          tx600(data["response"]["title"], size: 18),
                          height(8),
                          tx500(
                              "Mark Scored : ${data["marks_scored"].toString()}")
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          if (exams.isEmpty)
            Expanded(
                child: Padding(
              padding: const EdgeInsets.all(60),
              child: Center(
                child: LottieBuilder.network(
                  "https://lottie.host/770cb31f-b2d7-49e6-b5aa-c5dddb38a756/amtSUlPjmr.json",
                ),
              ),
            ))
        ],
      ),
    );
  }
}
