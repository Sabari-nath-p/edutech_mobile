import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mathlab/Constants/colors.dart';
import 'package:mathlab/Constants/sizer.dart';
import 'package:mathlab/Constants/textstyle.dart';
import 'package:mathlab/development.dart';
import 'package:mathlab/screen/exam/ExamMain.dart';
import 'package:mathlab/screen/exam/models/ExamData.dart';
import 'package:provider/provider.dart';

class ExamStart extends StatelessWidget {
  ExamStart({super.key});

  bool isfirst = false;

  @override
  Widget build(BuildContext context) {
    var js = json.decode(questionData);
    ExamData examData = ExamData();
    examData.fetchQuestion(js["questions"]);

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
                Icon(Icons.arrow_back_ios_new_rounded),
                Expanded(
                    child: Container(
                        alignment: Alignment.center,
                        child: tx600("Exam Title",
                            size: 20, color: Colors.black))),
                Icon(Icons.menu),
                width(20)
              ],
            ),
            height(30),
            tx600("\t\t\t\t\tTime", size: 18, color: Colors.black),
            Container(
              margin: EdgeInsets.all(20),
              height: 63,
              padding: EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Color(0xFFFFBB33)),
              child: Row(
                children: [
                  tx600("00:20:00", size: 20, color: Colors.white),
                  Expanded(child: Container()),
                  Icon(
                    Icons.play_arrow,
                    color: Colors.white,
                  ),
                  tx500(" Start", size: 18, color: Colors.white)
                ],
              ),
            ),
            tx600("\t\t\t\t\tInstruction", size: 19, color: Colors.black),
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
                        "${instruction.replaceAll("\n", "\n\n-> ")}",
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
            Container(
              alignment: Alignment.center,
              child: tx400("Click start to begin exam", size: 15),
            ),
            Container(
                margin: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                child: InkWell(
                  onTap: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => examMain(examData: examData,)));
                  },
                  child: ButtonContainer(tx600("Start", color: Colors.white),
                      radius: 10, height: 50, color: primaryColor),
                )),
            height(30)
          ],
        ),
      ),
    ));
  }
}
