import 'package:flutter/material.dart';
import 'package:mathlab/screen/exam/models/questionMode.dart';

class ExamData {
  String? title;
  int? id;
  String? instruction;
  String? duration;
  int? passMark;
  int currentQuesstion = 0;
  int totalmark = 0;
  List<QuestionListModel> questions = [];
  int? accessType;
  ValueNotifier notifier = ValueNotifier(0);

  FetchExam(Map<String, dynamic> json) {
    title = json['exam_name'];
    id = json['exam_unique_id'];
    instruction = json['instruction'];
    duration = json['duration_of_exam'];
    // passMark = json['pass_mark'];
    accessType = json['access_type'];
    totalmark = json["total_marks"];
  }

  fetchAnswer(var answer) {
    print("fetching answer");
    print(answer);
    int j = -1;
    for (int i = 1; answer[i.toString()] != null; i++) {
      j++;
     // print(i);
      questions[j].answer = answer[i.toString()];
      if (answer[i.toString()] == "" || answer[i.toString()] == null) {
        questions[j].status = -1;
      } else
        questions[j].status = 1;
      print(questions[j].status);
      print(questions[j].answer);
    }
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
    if (questions[currentQuesstion].model == "numericals")
      questions[currentQuesstion].answer = ans;
  }

  unMarkAnswer(String ans) {
    questions[currentQuesstion].status = 0;
    if (questions[currentQuesstion].model == "multiplechoice")
      questions[currentQuesstion].answer = "";
    if (questions[currentQuesstion].model == "multiselect")
      questions[currentQuesstion].answer =
          questions[currentQuesstion].answer!.replaceAll(ans, "");
    if (questions[currentQuesstion].model == "numericals")
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
