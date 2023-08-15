import 'package:flutter/material.dart';
import 'package:mathlab/Constants/sizer.dart';
import 'package:mathlab/Constants/textstyle.dart';
import 'package:mathlab/screen/exam/components.dart/question.dart';
import 'package:mathlab/screen/exam/components.dart/solutionOption.dart';
import 'package:mathlab/screen/exam/models/ExamData.dart';
import 'package:mathlab/screen/exam/models/questionMode.dart';
import 'package:mathlab/screen/exam/solutionText.dart';

class ExamSolution extends StatefulWidget {
  QuestionListModel qmodel;
  ExamData examData;
  int currentQuesstion;
  ExamSolution(
      {super.key,
      required this.qmodel,
      required this.currentQuesstion,
      required this.examData});

  @override
  State<ExamSolution> createState() => _ExamSolutionState(
      qmodel: qmodel, examData: examData, currentQuesstion: currentQuesstion);
}

class _ExamSolutionState extends State<ExamSolution> {
  QuestionListModel qmodel;
  ExamData examData;
  int currentQuesstion;
  _ExamSolutionState(
      {required this.qmodel,
      required this.currentQuesstion,
      required this.examData});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Container(
              padding: EdgeInsets.only(top: 20, bottom: 10),
              child: Row(
                children: [
                  width(20),
                  InkWell(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: Icon(Icons.arrow_back_ios_new)),
                  Expanded(
                      child: Container(
                          alignment: Alignment.center,
                          child: tx600("Exam Solution", size: 20))),
                  width(40),
                ],
              ),
            ),
            Expanded(
                child: SingleChildScrollView(
              child: Column(
                children: [
                  questionView(
                      examData: qmodel, currentQuestion: currentQuesstion),
                  solutionOption(examData: qmodel),
                  SolutionText(
                      examData: qmodel, currentQuestion: currentQuesstion)
                ],
              ),
            ))
          ],
        ),
      ),
    );
  }
}
