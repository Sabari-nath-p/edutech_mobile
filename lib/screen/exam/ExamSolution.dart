import 'package:flutter/material.dart';
import 'package:mathlab/Constants/sizer.dart';
import 'package:mathlab/Constants/textstyle.dart';

class ExamSolution extends StatefulWidget {
  const ExamSolution({super.key});

  @override
  State<ExamSolution> createState() => _ExamSolutionState();
}

class _ExamSolutionState extends State<ExamSolution> {
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
                  width(40)
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
