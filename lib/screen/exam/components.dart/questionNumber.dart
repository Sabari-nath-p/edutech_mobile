import 'package:flutter/material.dart';
import 'package:mathlab/Constants/sizer.dart';
import 'package:mathlab/Constants/textstyle.dart';
import 'package:mathlab/screen/exam/ExamMain.dart';

import '../models/ExamData.dart';

class QuestionNumber extends StatefulWidget {
  ExamData edata;
  QuestionNumber({super.key, required this.edata});

  @override
  State<QuestionNumber> createState() => _QuestionNumberState();
}

class _QuestionNumberState extends State<QuestionNumber> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 30, vertical: 180),
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20), color: Colors.white),
      child: Stack(
        children: [
          Positioned(
              top: 50,
              left: 0,
              right: 0,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 15,
                    height: 15,
                    margin: EdgeInsets.symmetric(horizontal: 2),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.green),
                  ),
                  Text("Answered"),
                  width(8),
                  Container(
                    width: 15,
                    height: 15,
                    margin: EdgeInsets.symmetric(horizontal: 2),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.orange),
                  ),
                  Text("Attended"),
                  width(8),
                  Container(
                    width: 15,
                    height: 15,
                    margin: EdgeInsets.symmetric(horizontal: 2),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.grey),
                  ),
                  Text("unattended"),
                  width(8),
                ],
              )),
          Positioned(
              bottom: 10,
              left: 20,
              right: 20,
              child: Center(
                  child: InkWell(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: ButtonContainer(tx600("Back", color: Colors.white),
                    radius: 10, width: 120),
              ))),
          Positioned(
              top: 10,
              left: 10,
              right: 10,
              child: Center(
                  child:
                      tx500("Select Question", size: 18, color: Colors.black))),
          Positioned(
            top: 80,
            left: 0,
            right: 0,
            bottom: 65,
            child: SingleChildScrollView(
              child: Wrap(
                crossAxisAlignment: WrapCrossAlignment.center,
                alignment: WrapAlignment.center,
                runSpacing: 8,
                spacing: 8,
                children: [
                  for (int i = 0; i < widget.edata.questions.length; i++)
                    InkWell(
                      onTap: () {
                        widget.edata.jumpto(i);
                        Navigator.of(context).pop();
                      },
                      child: Container(
                        width: 50,
                        alignment: Alignment.center,
                        height: 50,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: (widget.edata.questions[i].status == -1)
                                ? Colors.grey
                                : (widget.edata.questions[i].status == 1)
                                    ? Color(0xff009E52)
                                    : Color(0xffE5B027)),
                        child: tx600("${i + 1}", color: Colors.white),
                      ),
                    )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
