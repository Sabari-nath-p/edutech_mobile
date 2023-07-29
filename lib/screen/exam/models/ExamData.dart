import 'package:flutter/material.dart';
import 'package:mathlab/screen/exam/models/questionMode.dart';

class ExamData {
  String? title;
  String? id;
  String? instruction;
  String? duration;
  int? passMark;
  int currentQuesstion = 0;
  List<QuestionListModel> questions = [];
  String? accessType;
  ValueNotifier notifier = ValueNotifier(0);

  FetchExam(Map<String, dynamic> json) {
    title = json['title'];
    id = json['id'];
    instruction = json['instruction'];
    duration = json['duration'];
    passMark = json['pass_mark'];
    accessType = json['access_type'];
  }

  fetchQuestion(var questionSet, String model) {
    for (var qns in questionSet) {
      QuestionListModel question = QuestionListModel(
          questionData: qns, model: model, answer: "", status: -1);
      questions.add(question);
    }
  }

  jumpto(int n) {
    currentQuesstion = n;
    notifier.value++;
  }

  markAnswer(String ans) {
    questions[currentQuesstion].status = 1;
    if (questions[currentQuesstion].model == "multiplechoice")
      questions[currentQuesstion].answer = ans;
    if (questions[currentQuesstion].model == "multiselect")
      questions[currentQuesstion].answer =
          "${questions[currentQuesstion].answer}$ans";
    if (questions[currentQuesstion].model == "numeric")
      questions[currentQuesstion].answer = ans;
  }

  unMarkAnswer(String ans) {
    questions[currentQuesstion].status = 0;
    if (questions[currentQuesstion].model == "multiplechoice")
      questions[currentQuesstion].answer = "";
    if (questions[currentQuesstion].model == "multiselect")
      questions[currentQuesstion].answer =
          questions[currentQuesstion].answer!.replaceAll(ans, "");
    if (questions[currentQuesstion].model == "numeric")
      questions[currentQuesstion].answer = "";
  }

  IncrementQuestion() {
    if (currentQuesstion < questions.length - 1) currentQuesstion++;
    notifier.value++;
    print("question incremented");
  }

  DecrementQuestion() {
    if (currentQuesstion > 0) currentQuesstion--;
    notifier.value++;
    print("decremented");
  }

  QuestionListModel getCurrentQuestion() {
    questions[currentQuesstion].status =
        (questions[currentQuesstion].status == 1) ? 1 : 0;
    return questions[currentQuesstion];
  }
}
