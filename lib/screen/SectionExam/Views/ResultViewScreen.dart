import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:mathlab/Constants/colors.dart';
import 'package:mathlab/Constants/sizer.dart';
import 'package:mathlab/Constants/textstyle.dart';
import 'package:mathlab/screen/SectionExam/Model/SQLModel.dart';
import 'package:mathlab/screen/SectionExam/Model/SectionExamModel.dart';
import 'package:mathlab/screen/SectionExam/Service/resultController.dart';
import 'package:mathlab/screen/SectionExam/Views/SolutionMCQView.dart';
import 'package:mathlab/screen/SectionExam/Views/SolutionMNQView.dart';
import 'package:mathlab/screen/SectionExam/Views/SolutionNView.dart';
import 'package:mathlab/screen/noteScreen.dart';

class ResultViewScreen extends StatelessWidget {
  var UserResponse;
  String slug;
  // SExamModel? model;
  ResultViewScreen({super.key, required this.UserResponse, required this.slug});
  bool status = false;
  ResultController rctrl = Get.put(ResultController());
  @override
  Widget build(BuildContext context) {
    rctrl.fetchExam(UserResponse, slug);
    return Scaffold(
      body: SafeArea(child: GetBuilder<ResultController>(builder: (_) {
        status = (double.parse(UserResponse["marks_scored"].toString()) >=
            double.parse(UserResponse["qualify_score"].toString()));
        return (rctrl.examModel == null)
            ? Center(
                child: LoadingAnimationWidget.discreteCircle(
                    color: Colors.red, size: 30),
              )
            : Column(
                children: [
                  Container(
                    padding: EdgeInsets.only(top: 20, bottom: 10),
                    color: Colors.white,
                    child: Row(
                      children: [
                        width(20),
                        InkWell(
                            onTap: () {
                              Navigator.of(context).pop();
                            },
                            child: Icon(Icons.arrow_back_ios_new_rounded)),
                        Expanded(
                          child: Container(
                            alignment: Alignment.center,
                            child: tx600("Result", size: 22),
                          ),
                        ),
                        if (rctrl.examModel!.solutionPdf != null)
                          InkWell(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => noteScreen(
                                      notelink:
                                          rctrl.examModel!.solutionPdf!)));
                            },
                            child: SizedBox(
                              width: 40,
                              child: Icon(
                                Icons.book,
                                color: primaryColor,
                              ),
                            ),
                          )
                        else
                          width(40)
                      ],
                    ),
                  ),
                  height(20),
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: tx600("Score Card", size: 19),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        height: 140,
                        width: 160,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(14),
                            color: Color(0xff9B1818)),
                        child: Column(
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  width: 60,
                                  height: 60,
                                  margin: EdgeInsets.only(left: 10, top: 10),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.white,
                                  ),
                                  child: Icon(
                                    (status) ? Icons.check : Icons.close,
                                    color: Color(
                                      0xff9B1818,
                                    ),
                                    size: 35,
                                  ),
                                ),
                                width(10),
                                if (status)
                                  tx500("Status\nPassed",
                                      color: Colors.white, size: 16),
                                if (!status)
                                  tx500("Status\nFailed",
                                      color: Colors.white, size: 16)
                              ],
                            ),
                            Expanded(
                                child: InkWell(
                              onTap: () {
                                log(UserResponse.toString());
                              },
                              child: Container(
                                  alignment: Alignment.center,
                                  child: tx600(
                                      "${UserResponse["marks_scored"]}/ ${rctrl.examModel!.totalMarks}",
                                      size: 25,
                                      color: Colors.white)),
                            ))
                          ],
                        ),
                      ),
                      Container(
                        height: 140,
                        width: 170,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(14),
                            color: Color(0xff9B1818)),
                        child: Column(
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  width: 60,
                                  height: 60,
                                  margin: EdgeInsets.only(left: 10, top: 10),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.white,
                                  ),
                                  child: Icon(
                                    Icons.alarm_on_sharp,
                                    color: Color(
                                      0xff9B1818,
                                    ),
                                    size: 35,
                                  ),
                                ),
                                width(10),
                                tx500("Time\nDuration",
                                    color: Colors.white, size: 16)
                              ],
                            ),
                            Expanded(
                                child: Container(
                                    alignment: Alignment.center,
                                    child: tx600(
                                        _.calculcateDuration(UserResponse),
                                        size: 22,
                                        color: Colors.white)))
                          ],
                        ),
                      )
                    ],
                  ),
                  height(20),
                  Container(
                      width: double.infinity,
                      alignment: Alignment.center,
                      child: tx600("Answer Sheet", size: 20)),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 15,
                        height: 15,
                        margin: EdgeInsets.symmetric(horizontal: 2),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Colors.green),
                      ),
                      Text("Correct"),
                      width(8),
                      Container(
                        width: 15,
                        height: 15,
                        margin: EdgeInsets.symmetric(horizontal: 2),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: primaryColor),
                      ),
                      Text("wrong"),
                      width(8),
                      Container(
                        width: 15,
                        height: 15,
                        margin: EdgeInsets.symmetric(horizontal: 2),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Colors.orange),
                      ),
                      Text("unattended"),
                    ],
                  ),
                  Expanded(
                    child: Container(
                      alignment: Alignment.topCenter,
                      margin:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      child: SingleChildScrollView(
                        child: Wrap(
                          crossAxisAlignment: WrapCrossAlignment.center,
                          alignment: WrapAlignment.center,
                          runSpacing: 8,
                          spacing: 8,
                          children: [
                            for (int i = 0; i < rctrl.section.length; i++)
                              if (i < rctrl.questionList.length)
                                for (SQLModel data in rctrl.questionList[i])
                                  InkWell(
                                    onTap: () {
                                      print(data.answers);
                                      print(data.questionType);
                                      print(data.checkAnswerStatus());
                                      if (data.questionType == "multiplechoice")
                                        Get.to(
                                            () => SolutionMCQView(model: data),
                                            transition: Transition.rightToLeft);
                                      else if (data.questionType ==
                                          "multiselect")
                                        Get.to(
                                            () => SolutionMSQView(model: data),
                                            transition: Transition.rightToLeft);
                                      else
                                        Get.to(
                                            () => SolutionNQSView(model: data),
                                            transition: Transition.rightToLeft);
                                    },
                                    child: Container(
                                      width: 50,
                                      alignment: Alignment.center,
                                      height: 50,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(12),
                                          color: (data.checkAnswerStatus() ==
                                                  -1)
                                              ? Color(0xffE5B027)
                                              : (data.checkAnswerStatus() == 1)
                                                  ? Color(0xff009E52)
                                                  : Colors.red),
                                      child: tx600("${i + 1}",
                                          color: Colors.white),
                                    ),
                                  )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              );
      })),
    );
  }
}
