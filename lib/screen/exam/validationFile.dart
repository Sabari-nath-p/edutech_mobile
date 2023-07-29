import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:mathlab/Constants/textstyle.dart';
import 'package:mathlab/screen/exam/models/ExamData.dart';

import '../../Constants/colors.dart';

class ExamAnswerValidation extends StatefulWidget {
  ExamData examData;
  ExamAnswerValidation({super.key, required this.examData});

  @override
  State<ExamAnswerValidation> createState() => _ExamAnswerValidationState();
}

class _ExamAnswerValidationState extends State<ExamAnswerValidation> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            LoadingAnimationWidget.beat(color: primaryColor, size: 40),
            tx600("validation Answers")
          ],
        ),
      ),
    );
  }
}
