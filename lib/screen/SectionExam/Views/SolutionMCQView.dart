import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:mathlab/Constants/sizer.dart';
import 'package:mathlab/Constants/textstyle.dart';
import 'package:mathlab/screen/SectionExam/Model/SQLModel.dart';
import 'package:mathlab/screen/SectionExam/Service/controller.dart';
import 'package:tex_text/tex_text.dart';

class SolutionMCQView extends StatelessWidget {
  SQLModel model;

  SolutionMCQView({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
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
            SizedBox(
              height: 20,
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: SingleChildScrollView(
                  child: Column(children: [
                    Image.asset("assets/image/base.png"),
                    Container(
                        key: key,
                        width: double.infinity,
                        padding: EdgeInsets.only(
                            left: 10, right: 10, top: 10, bottom: 10),
                        // margin: EdgeInsets.symmetric(horizontal: 10),
                        constraints: BoxConstraints(minHeight: 100),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Color(0xff545454)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            tx600(" Question ${model.questionNo}",
                                color: Colors.white.withOpacity(.9), size: 14),
                            height(6),
                            if (model.multiplechoice!.question != null)
                              SingleChildScrollView(
                                child: SizedBox(
                                  width: 310,
                                  child: TexText(
                                    model!.multiplechoice!
                                        .question!, // questionText!,
                                    mathStyle: MathStyle.textCramped,
                                    style: TextStyle(
                                        color: Colors.white.withOpacity(.9),
                                        fontFamily: "Poppins",
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                              ),
                            if (model!.multiplechoice!.questionImage != null)
                              ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.network(
                                    model.multiplechoice!.questionImage!),
                              ),
                          ],
                        )),
                    Container(
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
                      margin: EdgeInsets.symmetric(vertical: 20),
                      child: Column(
                        children: [
                          _multipleChoiceOption(
                              model.answers,
                              model.multiplechoice!.option1Image,
                              model.multiplechoice!.option1Text,
                              "A",
                              model.multiplechoice!.answer!),
                          _multipleChoiceOption(
                              model.answers,
                              model.multiplechoice!.option2Image,
                              model.multiplechoice!.option2Text,
                              "B",
                              model.multiplechoice!.answer!),
                          _multipleChoiceOption(
                              model.answers,
                              model.multiplechoice!.option3Image,
                              model.multiplechoice!.option3Text,
                              "C",
                              model.multiplechoice!.answer!),
                          _multipleChoiceOption(
                            model.answers,
                            model.multiplechoice!.option4Image,
                            model.multiplechoice!.option4Text,
                            "D",
                            model.multiplechoice!.answer!,
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      padding: EdgeInsets.all(10),
                      //  margin: EdgeInsets.symmetric(horizontal: 20),
                      constraints: BoxConstraints(minHeight: 100),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Color(0xff545454)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Row(
                            children: [
                              tx600(" Solution ",
                                  color: Colors.white.withOpacity(.9),
                                  size: 14),
                              Expanded(child: Container()),
                            ],
                          ),
                          height(6),
                          if (model.multiplechoice!.solutionText != null)
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8),
                              child: TexText(
                                model.multiplechoice!.solutionText!,
                                style: TextStyle(
                                    color: Colors.white.withOpacity(.9),
                                    fontFamily: "Poppins",
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                          //  if (widget.examData.questionData["question_image"] != null || type == "mix") height(10),
                          if (model.multiplechoice!.solutionImage != null)
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.network(
                                  model.multiplechoice!.solutionImage!),
                            ),
                        ],
                      ),
                    ),
                  ]),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget _multipleChoiceOption(String currentAnswer, String? answerImage,
    String? answerString, String option, String answer) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 10),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Container(
        //   width: 20,
        //   height: 20,
        //   margin: EdgeInsets.only(right: 5),
        //   alignment: Alignment.center,
        //   decoration: BoxDecoration(
        //       color: Color(0xffF3F3F3),
        //       borderRadius: BorderRadius.circular(2)),
        //   child: tx500(
        //       String.fromCharCode('A'.codeUnitAt(0) + i),
        //       size: 14),
        // ),
        InkWell(
          onTap: () {},
          child: Container(
            height: 25,
            width: 25,
            alignment: Alignment.center,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                    color: (currentAnswer == option)
                        ? (currentAnswer == answer)
                            ? Colors.green
                            : Colors.redAccent
                        : (option == answer)
                            ? Colors.orangeAccent
                            : Colors.black54,
                    width: 1.3)),
            child: (currentAnswer == option)
                ? CircleAvatar(
                    child: SizedBox(
                      width: 20,
                      height: 20,
                      child: Icon(
                        (currentAnswer == answer) ? Icons.check : Icons.close,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                    backgroundColor:
                        (currentAnswer == answer) ? Colors.green : Colors.red,
                  )
                : (option == answer)
                    ? CircleAvatar(
                        child: SizedBox(
                          width: 20,
                          height: 20,
                          child: Icon(
                            Icons.check,
                            color: Colors.white,
                            size: 20,
                          ),
                        ),
                        backgroundColor: Colors.orange,
                      )
                    : tx500(option, size: 14),
          ),
        ),
        width(10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              if (answerImage != null) Image.network(answerImage),
              if (answerString != null)
                TexText(answerString,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      fontFamily: "Mullish",
                      color: Colors.black87,
                    )),
              // if (qnmodel.questionData["option${i + 1}_text"] !=
              //     null)
              //   if (checkOverflow(
              //       context,
              //       qnmodel
              //           .questionData["option${i + 1}_text"]))
              //     SingleChildScrollView(
              //       scrollDirection: Axis.horizontal,
              //       child: TexText(
              //           qnmodel.questionData[
              //               "option${i + 1}_text"],
              //           style: TextStyle(
              //             fontSize: 15,
              //             fontWeight: FontWeight.w600,
              //             fontFamily: "Mullish",
              //             color: Colors.black87,
              //           )),
              //     ),
            ],
          ),
        )
      ],
    ),
  );
}
