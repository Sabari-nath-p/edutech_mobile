import 'package:flutter/material.dart';
import 'package:mathlab/screen/exam/ExamSolution.dart';
import 'package:mathlab/screen/exam/components.dart/options.dart';
import 'package:mathlab/screen/exam/components.dart/question.dart';
import 'package:mathlab/screen/exam/components.dart/questionNumber.dart';
import 'package:mathlab/screen/exam/components.dart/timerBar.dart';
import 'package:http/http.dart' as http;
import 'package:mathlab/screen/exam/models/ExamData.dart';
import 'package:mathlab/screen/exam/models/questionMode.dart';
import '../../Constants/sizer.dart';
import '../../Constants/textstyle.dart';

late ExamData tempExampModel;

class examMain extends StatefulWidget {
  ExamData examData;
  examMain({super.key, required this.examData});

  @override
  State<examMain> createState() => _examMainState(examContent: examData);
}

class _examMainState extends State<examMain> {
  ExamData examContent;
  _examMainState({required this.examContent});

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
    loadQuestion();
    tempExampModel = widget.examData;
  }

  loadQuestion() {
    examContent.notifier.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

    examContent.notifier.removeListener(() {});
  }

  @override
  Widget build(BuildContext context) {
    QuestionListModel qmodel = examContent.getCurrentQuestion();
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
                        alignment: Alignment.center,
                        child: tx600(examContent.title.toString(),
                            size: 20, color: Colors.black))),
                InkWell(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => ExamSolution()));
                    },
                    child: Icon(Icons.menu)),
                width(20)
              ],
            ),
            height(15),
            tx600("\t\t\t\t\t\t\tTime Left", size: 14, color: Colors.black),
            TimerBar(
              time: "1200",
              examData: examContent,
            ),
            Expanded(
                child: SingleChildScrollView(
              child: Column(
                children: [
                  questionView(
                    examData: qmodel,
                    currentQuestion: examContent.currentQuesstion,
                  ),
                  ExamOptions(
                    examData: examContent,
                  )
                ],
              ),
            )),
            Row(
              children: [
                width(20),
                InkWell(
                  onTap: () {
                    examContent.DecrementQuestion();
                  },
                  child: ButtonContainer(
                      Icon(
                        Icons.arrow_back_ios,
                        color: Colors.white,
                      ),
                      radius: 10),
                ),
                Expanded(
                    child: Container(
                        alignment: Alignment.center,
                        child: InkWell(
                          onTap: () {
                            showDialog(
                                context: context,
                                builder: (context) => Material(
                                    color: Colors.transparent,
                                    child: QuestionNumber(
                                      edata: examContent,
                                    )));
                          },
                          child: ButtonContainer(
                              tx600("Question", color: Colors.white),
                              width: 120,
                              radius: 10),
                        ))),
                InkWell(
                  onTap: () {
                    examContent.IncrementQuestion();
                  },
                  child: ButtonContainer(tx600("Next", color: Colors.white),
                      radius: 10),
                ),
                width(20),
              ],
            ),
            height(20)
          ],
        )),
      ),
    );
  }
}
