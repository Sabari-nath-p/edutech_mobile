import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mathlab/Constants/sizer.dart';
import 'package:mathlab/Constants/textstyle.dart';
import 'package:mathlab/screen/SectionExam/Model/SQLModel.dart';
import 'package:mathlab/screen/SectionExam/Service/controller.dart';
import 'package:tex_text/tex_text.dart';

class MultipleChoiceView extends StatelessWidget {
  MultipleChoiceView({super.key});

  @override
  Widget build(BuildContext context) {
    return FadeInUp(
      child: GetBuilder<SectionExamController>(builder: (_) {
        return Column(children: [
          Image.asset("assets/image/base.png"),
          Container(
              key: key,
              width: double.infinity,
              padding: EdgeInsets.only(left: 8, right: 8, top: 10, bottom: 10),
              // margin: EdgeInsets.symmetric(horizontal: 10),
              constraints: BoxConstraints(minHeight: 100),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Color(0xff545454)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  tx600(" Question ${_.questionIndex + 1}",
                      color: Colors.white.withOpacity(.9), size: 14),
                  height(6),
                  if (_.currentQuestion!.multiplechoice!.question != null)
                    SingleChildScrollView(
                      child: SizedBox(
                        width: 310,
                        child: TexText(
                          _.currentQuestion!.multiplechoice!
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
                  if (_.currentQuestion!.multiplechoice!.questionImage != null)
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(
                          _.currentQuestion!.multiplechoice!.questionImage!),
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
                    _.currentQuestion!.answers,
                    _.currentQuestion!.multiplechoice!.option1Image,
                    _.currentQuestion!.multiplechoice!.option1Text,
                    "A"),
                _multipleChoiceOption(
                    _.currentQuestion!.answers,
                    _.currentQuestion!.multiplechoice!.option2Image,
                    _.currentQuestion!.multiplechoice!.option2Text,
                    "B"),
                _multipleChoiceOption(
                    _.currentQuestion!.answers,
                    _.currentQuestion!.multiplechoice!.option3Image,
                    _.currentQuestion!.multiplechoice!.option3Text,
                    "C"),
                _multipleChoiceOption(
                    _.currentQuestion!.answers,
                    _.currentQuestion!.multiplechoice!.option4Image,
                    _.currentQuestion!.multiplechoice!.option4Text,
                    "D")
              ],
            ),
          ),
        ]);
      }),
    );
  }
}

Widget _multipleChoiceOption(String currentAnswer, String? answerImage,
    String? answerString, String option) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 10),
    child: InkWell(
      onTap: () {
        SectionExamController ctrl = Get.put(SectionExamController());
        ctrl.currentQuestion!.clickOnOption(option);
        ctrl.update();
      },
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
          Container(
            height: 25,
            width: 25,
            alignment: Alignment.center,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                    color: (currentAnswer == option)
                        ? Colors.green
                        : Colors.black54,
                    width: 1.3)),
            child: (currentAnswer == option)
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
                    backgroundColor: Colors.green,
                  )
                : tx500(option, size: 14),
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
    ),
  );
}
