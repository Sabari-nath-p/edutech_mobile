import 'package:flutter/material.dart';
import 'package:mathlab/Constants/sizer.dart';
import 'package:mathlab/Constants/textstyle.dart';
import 'package:mathlab/screen/exam/ExamMain.dart';
import 'package:mathlab/screen/exam/models/questionMode.dart';
import 'package:tex_text/tex_text.dart';

import '../models/ExamData.dart';

class questionView extends StatefulWidget {
  QuestionListModel examData;
  int currentQuestion;
  questionView(
      {super.key, required this.examData, required this.currentQuestion});

  @override
  State<questionView> createState() => _questionViewState();
}

class _questionViewState extends State<questionView> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  //String questionText = "";
  @override
  Widget build(BuildContext context) {
    String questionText = widget.examData.questionData["question"];
    String type = widget.examData.questionData["type"];
    return Column(
      children: [
        Image.asset("assets/image/base.png"),
        Container(
          padding: EdgeInsets.all(10),
          margin: EdgeInsets.symmetric(horizontal: 20),
          constraints: BoxConstraints(minHeight: 100),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Color(0xff545454)),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  tx600(" Question ${widget.currentQuestion + 1}",
                      color: Colors.white.withOpacity(.9), size: 14),
                  Expanded(child: Container()),
                ],
              ),
              height(6),
              if (type == "text" || type == "mix")
                Row(
                  children: [
                    width(7),
                    TexText(
                      questionText,
                      style: TextStyle(
                          color: Colors.white.withOpacity(.9),
                          fontFamily: "Poppins",
                          fontSize: 15,
                          fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              if (type == "image" || type == "mix") height(10),
              if (type == "image")
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(questionText),
                ),
              if (type == "mix")
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(widget.examData.questionData["image"]),
                )
            ],
          ),
        ),
        if (false)
          Container(
            margin: EdgeInsets.only(left: 17),
            alignment: Alignment.topLeft,
            height: 180,
            child: Stack(
              //crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (false)
                  Positioned(
                      top: 0,
                      right: 0,
                      left: 0,
                      child: Image.asset(
                        "assets/image/questionbg.png",
                        fit: BoxFit.fill,
                      )),
              ],
            ),
          ),
        if (false)
          Container(
            height: 150,
            child: Image.network(
                "https://www.aplustopper.com/wp-content/uploads/2019/08/Plus-One-Physics-Chapter-Wise-Questions-and-Answers-Chapter-3-Motion-in-a-Straight-Line-1M-Q4.jpg"),
          )
      ],
    );
  }
}
