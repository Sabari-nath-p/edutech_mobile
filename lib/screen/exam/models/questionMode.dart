class QuestionListModel {
  String? model;
  int status = -1;

  var questionData;
  String? answer;
  QuestionListModel(
      {required this.questionData,
      required this.model,
      required this.answer,
      required this.status});
}
