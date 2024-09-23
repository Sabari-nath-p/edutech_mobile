import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mathlab/screen/SectionExam/Model/SectionExamModel.dart';

class SQLModel {
  late String questionType;
  late int questionNo;
  String answers = "";
  bool isQuestionOpen = false;
  bool isQuestionAnswered = false;
  Multiplechoice? multiplechoice;
  Multiselect? multiselect;
  Numericals? numericals;
  SQLModel(
      {required this.questionType,
      this.isQuestionAnswered = false,
      this.answers = "",
      this.isQuestionOpen = false,
      this.multiplechoice,
      this.multiselect,
      this.numericals,
      required this.questionNo});

  int checkAnswerStatus() {
    if (questionType == "multiplechoice") {
      if (answers == multiplechoice!.answer)
        return 1;
      else if (answers != "")
        return 0;
      else
        return -1;
    } else if (questionType == "multiselect") {
      if (answers == "") {
        return -1;
      } else {
        List answerList = answers.split("-");
        int correctCount = 0;
        int markedCorrect = 0;
        for (var data in multiselect!.options!) {
          if (data.isAnswer!) {
            correctCount++;
          }

          if (data.isAnswer! && answerList.contains(data.optionId.toString())) {
            markedCorrect++;
          }
        }
        if (correctCount == markedCorrect && correctCount == answerList.length)
          return 1;
        return 0;
      }
    } else {
      if (answers == "") {
        return -1;
      }
      double ans = double.parse(answers);
      double max = double.parse(numericals!.ansMaxRange!);
      double min = double.parse(numericals!.ansMinRange!);

      if (ans >= min && ans <= max) {
        return 1;
      }
      return 0;
    }
  }

  Color? CheckOptionIsAnswer(int? optionID) {
    for (var data in multiselect!.options!) {
      if (data.optionId == optionID) {
        if (answers.contains(data.optionId.toString()) == true &&
            data.isAnswer! == true) {
          print("corect");
          return Colors.green;
        } else if (answers.contains(data.optionId.toString()) == true &&
            data.isAnswer! == false) {
          print("wrong");
          return Colors.red;
        } else if ((answers.contains(data.optionId.toString()) == false &&
            data.isAnswer! == true)) return Colors.orange;
      }
    }

    return null;
  }

  clickOnOption(String value) {
    if (questionType == "multiplechoice") {
      if (answers == value) {
        answers = "";
      } else {
        answers = value;
      }
    } else if (questionType == "multiselect") {
      List temp = answers.split("-");

      if (temp.contains(value)) {
        temp.remove(value);
      } else {
        temp.add(value);
      }

      answers = temp.join("-");
    } else {
      answers = value;
    }

    if (answers == "") {
      isQuestionAnswered = false;
    } else {
      isQuestionAnswered = true;
    }
  }
}
