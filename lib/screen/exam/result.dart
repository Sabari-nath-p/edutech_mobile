import 'package:flutter/material.dart';
import 'package:mathlab/Constants/colors.dart';
import 'package:mathlab/Constants/sizer.dart';
import 'package:mathlab/Constants/textstyle.dart';
import 'package:mathlab/screen/exam/ExamSolution.dart';
import 'package:mathlab/screen/exam/models/ExamData.dart';

class ExamResult extends StatefulWidget {
  List answerStatus;
  ExamData examData;
  int seconds;
  double total;
  ExamResult(
      {super.key,
      required this.answerStatus,
      required this.examData,
      required this.seconds,
      required this.total});

  @override
  State<ExamResult> createState() => _ExamResultState();
}

class _ExamResultState extends State<ExamResult> {
  bool status = true;
  double passMark = 0;
  double totalMark = 0;
  String minute = "";
  String hours = "";
  String second = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadcontent();
  }

  //String hours = "0";

  loadcontent() {
    setState(() {
      if (widget.total > 0) status = true;
      totalMark = widget.examData.totalmark.toDouble();
      //print(widget.seconds);
      Duration duration = Duration(seconds: widget.seconds);
      hours = duration.inHours.toString().padLeft(0, '2');
      minute = duration.inMinutes.remainder(60).toString().padLeft(2, '0');
      second = duration.inSeconds.remainder(60).toString().padLeft(2, '0');
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //height(20),
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
                      child: Icon(Icons.arrow_back_ios_new_rounded)),
                  Expanded(
                    child: Container(
                      alignment: Alignment.center,
                      child: tx600("Result", size: 22),
                    ),
                  ),
                  width(40)
                ],
              ),
            ),
            height(20),
            Padding(
              padding: const EdgeInsets.all(20),
              child: tx600("Score Card", size: 19),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  height: 140,
                  width: 160,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(14),
                      color: Color(0xff9B1818)),
                  child: Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: 60,
                            height: 60,
                            margin: EdgeInsets.only(left: 10, top: 10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white,
                            ),
                            child: Icon(
                              (status) ? Icons.check : Icons.close,
                              color: Color(
                                0xff9B1818,
                              ),
                              size: 35,
                            ),
                          ),
                          width(10),
                          if (status)
                            tx500("Status\nPassed",
                                color: Colors.white, size: 16),
                          if (!status)
                            tx500("Status\nFailed",
                                color: Colors.white, size: 16)
                        ],
                      ),
                      Expanded(
                          child: Container(
                              alignment: Alignment.center,
                              child: tx600(
                                  "${widget.total.toInt()}/${totalMark.toInt()}",
                                  size: 25,
                                  color: Colors.white)))
                    ],
                  ),
                ),
                Container(
                  height: 140,
                  width: 170,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(14),
                      color: Color(0xff9B1818)),
                  child: Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: 60,
                            height: 60,
                            margin: EdgeInsets.only(left: 10, top: 10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white,
                            ),
                            child: Icon(
                              Icons.alarm_on_sharp,
                              color: Color(
                                0xff9B1818,
                              ),
                              size: 35,
                            ),
                          ),
                          width(10),
                          tx500("Time\nDuration", color: Colors.white, size: 16)
                        ],
                      ),
                      Expanded(
                          child: Container(
                              alignment: Alignment.center,
                              child: tx600("$minute m: $second s",
                                  size: 22, color: Colors.white)))
                    ],
                  ),
                )
              ],
            ),
            height(20),
            Container(
                width: double.infinity,
                alignment: Alignment.center,
                child: tx600("Answer Sheet", size: 20)),
            Row(
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
                Text("Correct"),
                width(8),
                Container(
                  width: 15,
                  height: 15,
                  margin: EdgeInsets.symmetric(horizontal: 2),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: primaryColor),
                ),
                Text("wrong"),
                width(8),
                Container(
                  width: 15,
                  height: 15,
                  margin: EdgeInsets.symmetric(horizontal: 2),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.orange),
                ),
                Text("unattended"),
              ],
            ),

            Expanded(
              child: Container(
                alignment: Alignment.topCenter,
                margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: SingleChildScrollView(
                  child: Wrap(
                    crossAxisAlignment: WrapCrossAlignment.center,
                    alignment: WrapAlignment.center,
                    runSpacing: 8,
                    spacing: 8,
                    children: [
                      for (int i = 0; i < widget.answerStatus.length; i++)
                        InkWell(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => ExamSolution(
                                    qmodel: widget.examData.questions[i],
                                    currentQuesstion: i,
                                    examData: widget.examData)));
                          },
                          child: Container(
                            width: 50,
                            alignment: Alignment.center,
                            height: 50,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                color: (widget.answerStatus[i] == 0)
                                    ? Color(0xffE5B027)
                                    : (widget.answerStatus[i] == 1)
                                        ? Color(0xff009E52)
                                        : Colors.red),
                            child: tx600("${i + 1}", color: Colors.white),
                          ),
                        )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
