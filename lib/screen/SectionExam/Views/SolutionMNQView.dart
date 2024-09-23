import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:mathlab/Constants/sizer.dart';
import 'package:mathlab/Constants/textstyle.dart';
import 'package:mathlab/screen/SectionExam/Model/SQLModel.dart';
import 'package:mathlab/screen/exam/components.dart/question.dart';
import 'package:tex_text/tex_text.dart';

class SolutionMSQView extends StatelessWidget {
  SQLModel model;
  SolutionMSQView({super.key, required this.model});

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
                child: Column(
                  children: [
                    Image.asset("assets/image/base.png"),
                    Container(
                        key: key,
                        width: double.infinity,
                        padding: EdgeInsets.only(
                            left: 8, right: 8, top: 10, bottom: 10),
                        // margin: EdgeInsets.symmetric(horizontal: 10),
                        constraints: BoxConstraints(minHeight: 100),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Color(0xff545454)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            tx600(" Question ${model.questionNo + 1}",
                                color: Colors.white.withOpacity(.9), size: 14),
                            height(6),
                            if (model.multiselect!.question != null)
                              SingleChildScrollView(
                                child: SizedBox(
                                  width: 310,
                                  child: TexText(
                                    model.multiselect!
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
                            if (model.multiselect!.questionImage != null)
                              ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.network(
                                    model.multiselect!.questionImage!),
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
                          for (var data in model.multiselect!.options!)
                            InkWell(
                              onTap: () {
                                print(data.toJson());
                              },
                              child: Container(
                                margin: EdgeInsets.symmetric(vertical: 15),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      height: 25,
                                      width: 25,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(0),
                                          color: model.CheckOptionIsAnswer(
                                              data.optionId),
                                          border: Border.all(
                                              color: Colors.black54,
                                              width: 1.3)),
                                      child: (model.answers.contains(
                                              data.optionId.toString()))
                                          ? SizedBox(
                                              width: 20,
                                              height: 20,
                                              child: Icon(
                                                model.CheckOptionIsAnswer(
                                                            data.optionId) ==
                                                        Colors.green
                                                    ? Icons.check
                                                    : Icons.close,
                                                color: Colors.white,
                                                size: 20,
                                              ),
                                            )
                                          : tx500(
                                              String.fromCharCode(
                                                  'A'.codeUnitAt(0) + 2),
                                              size: 14),
                                    ),
                                    width(20),
                                    Expanded(
                                        child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        if (data.optionsImage != null)
                                          ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            child: Image.network(
                                                data.optionsImage!),
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
                                                child:
                                                    TexText(data.optionsText!)),
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
                            ),
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
                          if (model.multiselect!.solutionText != null)
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8),
                              child: TexText(
                                model.multiselect!.solutionText!,
                                style: TextStyle(
                                    color: Colors.white.withOpacity(.9),
                                    fontFamily: "Poppins",
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                          //  if (widget.examData.questionData["question_image"] != null || type == "mix") height(10),
                          if (model.multiselect!.solutionImage != null)
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.network(
                                  model.multiselect!.solutionImage!),
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    ));
  }
}
