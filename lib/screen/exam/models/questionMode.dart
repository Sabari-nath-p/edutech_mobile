class QuestionListModel {
  String? model;
  int status = -1;
  int QuestionNumber;
  var questionData;
  String? answer;
  QuestionListModel(
      {required this.questionData,
      required this.model,
      required this.QuestionNumber,
      required this.answer,
      required this.status});
}
