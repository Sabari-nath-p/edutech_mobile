import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:mathlab/Constants/textstyle.dart';
import 'package:mathlab/Constants/urls.dart';
import 'package:mathlab/screen/exam/models/ExamData.dart';
import 'package:mathlab/screen/exam/models/questionMode.dart';
import 'package:mathlab/screen/exam/result.dart';
import 'package:http/http.dart' as http;
import '../../Constants/colors.dart';

class ExamAnswerValidation extends StatefulWidget {
  ExamData examData;
  var data;
  ExamAnswerValidation({super.key, required this.examData, required this.data});

  @override
  State<ExamAnswerValidation> createState() => _ExamAnswerValidationState();
}

class _ExamAnswerValidationState extends State<ExamAnswerValidation> {
  double total = 0;
  List answerStatus = [];
  validateAnswer() {
    var examData = widget.examData;

    var questionData = examData.questions;
    for (var data in questionData) {
      if (data.status == 1) {
        if (data.model == "multiplechoice") {
          checkchoice(data);
        } else if (data.model == "multiselect") {
          checkselect(data);
          print("multi_select");
        } else if (data.model == "numericals") {
          checknumerical(data);
        }
      } else {
        answerStatus.add(0);
      }
    }

    print(total);
    print(answerStatus);
    loadResult();
  }

  loadResult() {
    Navigator.of(context).pop();
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => ExamResult(
              total: total,
              answerStatus: answerStatus,
              examData: widget.examData,
              seconds: widget.data["response"]["time"],
            )));
  }

  checknumerical(QuestionListModel qmodel) {
    if (qmodel.answer.toString() != "") {
      double positive_marks =
          double.parse(qmodel.questionData["positive_marks"].toString())
              .toDouble();
      double negetive_mark =
          double.parse(qmodel.questionData["negetive_mark"].toString())
              .toDouble();
      // print(positive_marks);
      print(qmodel.answer.toString());
      double answer = double.parse(qmodel.answer.toString()).toDouble();
      double maxAnswer =
          double.parse(qmodel.questionData["ans_max_range"].toString())
              .toDouble();
      double minAnswer =
          double.parse(qmodel.questionData["ans_min_range"].toString())
              .toDouble();
      print(answer);
      print("numerical");
      if (maxAnswer >= answer && minAnswer <= answer) {
        answerStatus.add(1);
        total = total + positive_marks;
      } else {
        total = total - negetive_mark;
        answerStatus.add(2);
      }
    } else {
      answerStatus.add(0);
    }
  }

  checkchoice(QuestionListModel qmodel) {
    double positive_marks =
        double.parse(qmodel.questionData["positive_marks"].toString())
            .toDouble();
    double negetive_mark =
        double.parse(qmodel.questionData["negetive_mark"].toString())
            .toDouble();
    // print(positive_marks);
    String answer = qmodel.answer.toString();

    //print(answer);
    if (answer == "0" && qmodel.questionData["answer"].toString() == "A") {
      answerStatus.add(1);
      total = total + positive_marks;
    } else if (answer == "1" &&
        qmodel.questionData["answer"].toString() == "B") {
      answerStatus.add(1);
      total = total + positive_marks;
    } else if (answer == "2" &&
        qmodel.questionData["answer"].toString() == "C") {
      answerStatus.add(1);
      total = total + positive_marks;
    } else if (answer == "3" &&
        qmodel.questionData["answer"].toString() == "D") {
      answerStatus.add(1);
      total = total + positive_marks;
    } else {
      total = total - negetive_mark;
      answerStatus.add(2);
    }
    // print(total);
  }

  checkselect(QuestionListModel qmodel) {
    String answer = qmodel.answer.toString();
    double positive_marks =
        double.parse(qmodel.questionData["positive_marks"].toString())
            .toDouble();
    double negetive_mark =
        double.parse(qmodel.questionData["negetive_mark"].toString())
            .toDouble();

    print("answer + ");
    print(answer);
    print("multi_select");
    int i = -1;
    int status = 0;
    for (var data in qmodel.questionData["options"]) {
      i++;
      print(data["is_answer"]);
      if (!data["is_answer"] && answer.contains(i.toString())) {
        total = total - negetive_mark;
        status = 1;
        answerStatus.add(2);
        break;
      } else if (data["is_answer"] && !answer.contains(i.toString())) {
        total = total - negetive_mark;
        answerStatus.add(2);
        status = 1;
        break;
      }
    }

    if (status == 0) {
      total = total + positive_marks;
      answerStatus.add(1);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    total = 0;
    loadQuestion();
    // validateAnswer();
  }

  loadQuestion() async {
    final Response = await http
        .get(Uri.parse("$baseurl/applicationview/exams/${widget.examData.id}"));

    if (Response.statusCode == 200 || Response.statusCode == 201) {
      var data = json.decode(Response.body);

      widget.examData.fetchQuestion(data["multiplechoice"], "multiplechoice");
      widget.examData.fetchQuestion(data["multiselect"], "multiselect");
      widget.examData.fetchQuestion(data["numericals"], "numericals");
      widget.examData.FetchExam(data);
      widget.examData.id = int.parse(data["exam_id"]);
      widget.examData.fetchAnswer(widget.data["response"]);
      validateAnswer();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            LoadingAnimationWidget.beat(color: primaryColor, size: 40),
            tx600("Loading Question")
          ],
        ),
      ),
    );
  }
}
