import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mathlab/Constants/sizer.dart';
import 'package:mathlab/Constants/textstyle.dart';
import 'package:mathlab/screen/SectionExam/Service/controller.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';

class QuestionPalletView extends StatelessWidget {
  const QuestionPalletView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SectionExamController>(builder: (_) {
      return Container(
        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 180),
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20), color: Colors.white),
        child: Stack(
          children: [
            Positioned(
                top: 50,
                left: 0,
                right: 0,
                child: Row(
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
                    Text("Answered"),
                    width(8),
                    Container(
                      width: 15,
                      height: 15,
                      margin: EdgeInsets.symmetric(horizontal: 2),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.orange),
                    ),
                    Text("Attended"),
                    width(8),
                    Container(
                      width: 15,
                      height: 15,
                      margin: EdgeInsets.symmetric(horizontal: 2),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.grey),
                    ),
                    Text("unattended"),
                    width(8),
                  ],
                )),
            Positioned(
                bottom: 10,
                left: 20,
                right: 20,
                child: Row(
                  children: [
                    InkWell(
                      onTap: () {
                        QuickAlert.show(
                            context: context,
                            type: QuickAlertType.loading,
                            title: "Please Wait",
                            text: "your answer validating");
                        _.submitExam();
                      },
                      child: ButtonContainer(tx600("Quit", color: Colors.white),
                          radius: 10, width: 120),
                    ),
                    width(20),
                    InkWell(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: ButtonContainer(
                          tx600("Continue", color: Colors.white),
                          color: Colors.green.shade600,
                          radius: 10,
                          width: 120),
                    ),
                  ],
                )),
            Positioned(
                top: 10,
                left: 10,
                right: 10,
                child: Center(
                    child: tx500("Select Question",
                        size: 18, color: Colors.black))),
            Positioned(
              top: 80,
              left: 0,
              right: 0,
              bottom: 65,
              child: SingleChildScrollView(
                child: Wrap(
                  crossAxisAlignment: WrapCrossAlignment.center,
                  alignment: WrapAlignment.center,
                  runSpacing: 8,
                  spacing: 8,
                  children: [
                    for (int i = 0;
                        i < _.questionList[_.selectedSection].length;
                        i++)
                      InkWell(
                        onTap: () {
                          Navigator.of(context).pop();
                          _.jumpQuestion(questionNo: i);
                        },
                        child: Container(
                          width: 50,
                          alignment: Alignment.center,
                          height: 50,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: (!_.questionList[_.selectedSection][i]
                                      .isQuestionOpen)
                                  ? Colors.grey
                                  : (_.questionList[_.selectedSection][i]
                                          .isQuestionAnswered)
                                      ? Color(0xff009E52)
                                      : Color(0xffE5B027)),
                          child: tx600("${i + 1}", color: Colors.white),
                        ),
                      )
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}
