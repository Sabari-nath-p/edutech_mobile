import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mathlab/Constants/sizer.dart';
import 'package:mathlab/Constants/textstyle.dart';
import 'package:mathlab/screen/SectionExam/Service/controller.dart';
import 'package:tex_text/tex_text.dart';

class MultiSelectView extends StatelessWidget {
  MultiSelectView({super.key});

  @override
  Widget build(BuildContext context) {
    return FadeInUp(
      child: GetBuilder<SectionExamController>(builder: (_) {
        return Column(
          children: [
            Image.asset("assets/image/base.png"),
            Container(
                key: key,
                width: double.infinity,
                padding:
                    EdgeInsets.only(left: 8, right: 8, top: 10, bottom: 10),
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
                    if (_.currentQuestion!.multiselect!.question != null)
                      SingleChildScrollView(
                        child: SizedBox(
                          width: 310,
                          child: TexText(
                            _.currentQuestion!.multiselect!
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
                    if (_.currentQuestion!.multiselect!.questionImage != null)
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.network(
                            _.currentQuestion!.multiselect!.questionImage!),
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
                  for (var data in _.currentQuestion!.multiselect!.options!)
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 15),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          InkWell(
                            onTap: () {
                              _.currentQuestion!
                                  .clickOnOption(data!.optionId.toString());
                              _.update();
                            },
                            child: Container(
                              height: 25,
                              width: 25,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(0),
                                  color: (_.currentQuestion!.answers
                                          .contains(data.optionId.toString()))
                                      ? Colors.green
                                      : null,
                                  border: Border.all(
                                      color: Colors.black54, width: 1.3)),
                              child: (_.currentQuestion!.answers
                                      .contains(data.optionId.toString()))
                                  ? SizedBox(
                                      width: 20,
                                      height: 20,
                                      child: Icon(
                                        Icons.check,
                                        color: Colors.white,
                                        size: 20,
                                      ),
                                    )
                                  : tx500(
                                      // String.fromCharCode(
                                      //     'A'.codeUnitAt(data.optionNo ?? 0)),
                                      _getLetterBack(_.currentQuestion!
                                          .multiselect!.options!
                                          .indexOf(data)),
                                      size: 14),
                            ),
                          ),
                          width(20),
                          Expanded(
                              child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if (data.optionsImage != null)
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.network(data.optionsImage!),
                                ),
                              if (data.optionsText != null)
                                // if (checkOverflow(
                                //     context,
                                //     (qnmodel.questionData["options"][i]
                                //         ["options_text"])))
                                SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: SizedBox(
                                      width: 390,
                                      child: TexText(data.optionsText!)),
                                ),
                              // if (qnmodel.questionData["options"][i]
                              //         ["options_text"] !=
                              //     null)
                              //   if (!checkOverflow(
                              //       context,
                              //       (qnmodel.questionData["options"][i]
                              //           ["options_text"])))
                              //     SingleChildScrollView(
                              //         scrollDirection: Axis.horizontal,
                              //         child: TexText(qnmodel.questionData["options"]
                              //             [i]["options_text"])),
                            ],
                          ))
                        ],
                      ),
                    ),
                ],
              ),
            )
          ],
        );
      }),
    );
  }
}

String _getLetterBack(int? val) {
  if (val != null) {
    if (val == 0)
      return "A";
    else if (val == 1)
      return "B";
    else if (val == 2)
      return "C";
    else
      return "D";
  } else
    return "A";
}
