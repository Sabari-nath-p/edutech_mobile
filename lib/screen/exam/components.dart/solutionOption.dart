import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mathlab/Constants/sizer.dart';
import 'package:mathlab/Constants/textstyle.dart';
import 'package:mathlab/screen/exam/components.dart/question.dart';
import 'package:tex_text/tex_text.dart';
import '../models/ExamData.dart';
import '../models/questionMode.dart';

class solutionOption extends StatefulWidget {
  QuestionListModel examData;

  solutionOption({
    super.key,
    required this.examData,
  });

  @override
  State<solutionOption> createState() => _solutionOptionState();
}

class _solutionOptionState extends State<solutionOption> {
  int selectedOption = -1;
  List multipleOption = [];
  TextEditingController numericController = TextEditingController();

  loadOption() {
    qnmodel = widget.examData;
    questionType = qnmodel.model!;
    if (questionType == "multiplechoice") {
      setState(() {
        if (qnmodel.answer.toString() != "")
          selectedOption = int.parse(qnmodel.answer.toString());
        else
          selectedOption = -1;
      });
    } else if (questionType == "multiselect") {
      setState(() {
        if (qnmodel.answer.toString().contains("0")) multipleOption.add(0);
        if (qnmodel.answer.toString().contains("1")) multipleOption.add(1);
        if (qnmodel.answer.toString().contains("2")) multipleOption.add(2);
        if (qnmodel.answer.toString().contains("3")) multipleOption.add(3);
      });
    } else if (questionType == "numericals") {
      setState(() {
        numericController.text = qnmodel.answer.toString();
      });
    }
  }

  String questionType = "";
  late QuestionListModel qnmodel;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    qnmodel = widget.examData;
    questionType = qnmodel.model!;
    loadOption();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
                blurRadius: 10,
                spreadRadius: .1,
                color: Colors.grey.withOpacity(.2),
                offset: Offset(.2, 10))
          ]),
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.all(10),
      child: Column(
        children: [
          if (questionType == "multiplechoice" || questionType == "multiselect")
            for (int i = 0; i < 4; i++)
              if (questionType == "multiplechoice")
                Container(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                          height: 25,
                          width: 25,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              border: Border.all(
                                  color: checkchoice(qnmodel, i), width: 1.3)),
                          child: CircleAvatar(
                            backgroundColor: checkchoice(qnmodel, i),
                            child: tx500(
                                String.fromCharCode('A'.codeUnitAt(0) + i),
                                color: Colors.white,
                                size: 14),
                          )),
                      width(20),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (qnmodel.questionData["option${i + 1}_image"] !=
                                null)
                              Image.network(
                                  qnmodel.questionData["option${i + 1}_image"]),
                            if (qnmodel.questionData["option${i + 1}_text"] !=
                                null)
                              TexText(
                                  qnmodel.questionData["option${i + 1}_text"],
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                    fontFamily: "Mullish",
                                    color: Colors.black87,
                                  )),
                          ],
                        ),
                      )
                    ],
                  ),
                )
              else if (questionType == "multiselect")
                Container(
                  margin: EdgeInsets.symmetric(vertical: 10),
                  alignment: Alignment.center,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 25,
                        width: 25,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(0),
                            color: checkselect(qnmodel, i),
                            border:
                                Border.all(color: Colors.black54, width: 1.3)),
                        child: (multipleOption.contains(i))
                            ? SizedBox(
                                width: 20,
                                height: 20,
                                child: Container(
                                  color: checkselect(qnmodel, i),
                                ),
                              )
                            : tx500(String.fromCharCode('A'.codeUnitAt(0) + i),
                                color: Colors.white, size: 14),
                      ),
                      width(20),
                      Expanded(
                          child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (qnmodel.questionData["options"][i]
                                  ["options_image"] !=
                              null)
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.network(qnmodel
                                  .questionData["options"][i]["options_image"]),
                            ),
                          if (qnmodel.questionData["options"][i]
                                  ["options_text"] !=
                              null)
                            if (checkOverflow(
                                context,
                                (qnmodel.questionData["options"][i]
                                    ["options_text"])))
                              Container(
                                  child: TexText(qnmodel.questionData["options"]
                                      [i]["options_text"])),
                          if (qnmodel.questionData["options"][i]
                                  ["options_text"] !=
                              null)
                            if (!checkOverflow(
                                context,
                                (qnmodel.questionData["options"][i]
                                    ["options_text"])))
                              SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: TexText(qnmodel.questionData["options"]
                                      [i]["options_text"])),
                        ],
                      ))
                    ],
                  ),
                ),
          if (questionType == "numericals")
            Container(
              width: double.infinity,
              height: 150,
              child: Stack(
                children: [
                  Positioned(
                      top: 0,
                      left: 0,
                      child: tx500("Entered Answer ", size: 14)),
                  Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    bottom: 0,
                    child: Center(
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10)),
                        constraints: BoxConstraints(
                            maxWidth: 150,
                            maxHeight: 55,
                            minHeight: 55,
                            minWidth: 100),
                        child: TextField(
                          enabled: false,
                          controller: numericController,
                          keyboardType: TextInputType.numberWithOptions(
                              signed: true, decimal: true),
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(color: Colors.grey))),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
        ],
      ),
    );
  }

  Color checkchoice(QuestionListModel qmodel, int question) {
    // //print(positive_marks);
    String answer = qmodel.answer.toString();
    List alpa = ["A", "B", "C", "D"];
    // //print(alpa.indexOf(qmodel.questionData["answer"].toString()));

    int correctAnswer = alpa.indexOf(qmodel.questionData["answer"].toString());
    //print("answer");
    //print(correctAnswer);
    ////print(answer == correctAnswer);
    // //print(selectedOption == question);

    if (answer == correctAnswer.toString() && selectedOption == question) {
      return Colors.green;
    } else if (question ==
            alpa.indexOf(qmodel.questionData["answer"].toString()) &&
        selectedOption == -1) {
      return Colors.orange;
    } else if (question ==
            alpa.indexOf(qmodel.questionData["answer"].toString()) &&
        selectedOption != correctAnswer) {
      return Colors.green;
    } else if (selectedOption == question)
      return Colors.red;
    else {
      return Colors.black54;
    }
    // //print(total)q
  }

  Color checkselect(QuestionListModel qnmodel, int question) {
    if (multipleOption.contains(question) &&
        qnmodel.questionData["options"][question]["is_answer"]) {
      return Colors.green;
    } else if (multipleOption.isEmpty &&
        qnmodel.questionData["options"][question]["is_answer"]) {
      return Colors.orange;
    } else if (multipleOption.contains(question) &&
        !qnmodel.questionData["options"][question]["is_answer"]) {
      return Colors.red;
    } else if (!multipleOption.contains(question) &&
        qnmodel.questionData["options"][question]["is_answer"]) {
      return Colors.green;
    } else
      return Colors.black54;
  }
}
