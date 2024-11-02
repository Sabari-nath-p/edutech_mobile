import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:get/get.dart';
import 'package:mathlab/Constants/colors.dart';
import 'package:mathlab/Constants/sizer.dart';
import 'package:mathlab/Constants/textstyle.dart';
import 'package:mathlab/screen/SectionExam/Model/SectionExamModel.dart';
import 'package:mathlab/screen/SectionExam/Service/controller.dart';
import 'package:mathlab/screen/SectionExam/Views/multiSelectView.dart';
import 'package:mathlab/screen/SectionExam/Views/multipleChoiceView.dart';
import 'package:mathlab/screen/SectionExam/Views/numericalOption.dart';
import 'package:mathlab/screen/SectionExam/Views/questionPalletVIew.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:timer_count_down/timer_count_down.dart';

class SectionExamViewScreen extends StatelessWidget {
  SectionExamViewScreen({super.key});

  SectionExamController sCtrl = Get.put(SectionExamController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 247, 247, 247),
      body: WillPopScope(
        //   canPop: false,
        onWillPop: () async {
          QuickAlert.show(
              context: context,
              title: "Are you sure want to quit",
              text: "You can quit exam by submitting the answer",
              type: QuickAlertType.confirm,
              cancelBtnText: "cancel",
              onCancelBtnTap: () {
                Get.back();
              },
              onConfirmBtnTap: () {
                Get.back();
                QuickAlert.show(
                    context: context,
                    type: QuickAlertType.loading,
                    title: "Please wait",
                    text: "your answer validating");
                sCtrl.submitExam();
              },
              confirmBtnText: "Quit");

          return false;
        },
        child: SafeArea(child: GetBuilder<SectionExamController>(builder: (_) {
          return Stack(
            children: [
              Positioned(
                top: 0,
                bottom: 0,
                right: 0,
                left: 0,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.only(top: 20, bottom: 15),
                      decoration: BoxDecoration(boxShadow: [
                        BoxShadow(color: Colors.grey.withOpacity(.2))
                      ], color: Colors.white),
                      child: Row(
                        children: [
                          SizedBox(
                            width: 20,
                          ),
                          InkWell(
                            onTap: () {
                              QuickAlert.show(
                                  context: context,
                                  title: "Are you sure want to quit",
                                  text:
                                      "You can quit exam by submitting the answer",
                                  type: QuickAlertType.confirm,
                                  cancelBtnText: "cancel",
                                  onCancelBtnTap: () {
                                    Get.back();
                                  },
                                  onConfirmBtnTap: () {
                                    Get.back();
                                    QuickAlert.show(
                                        context: context,
                                        type: QuickAlertType.loading,
                                        title: "Please wait",
                                        text: "your answer validating");
                                    _.submitExam();
                                  },
                                  confirmBtnText: "Quit");
                            },
                            child: Icon(
                              Icons.arrow_back_ios_new_outlined,
                              size: 20,
                            ),
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          Expanded(
                              child: tx500(_.examModel!.examName!,
                                  color: Colors.black87)),
                          Countdown(
                            seconds: _.TimeDuration!.inSeconds,
                            build: (BuildContext context, double time) {
                              _.consumedTime = time;

                              Duration duration =
                                  Duration(seconds: time.toInt());

                              String hours =
                                  duration.inHours.toString().padLeft(0, '2');
                              String minutes = duration.inMinutes
                                  .remainder(60)
                                  .toString()
                                  .padLeft(2, '0');
                              String seconds = duration.inSeconds
                                  .remainder(60)
                                  .toString()
                                  .padLeft(2, '0');
                              return tx600("$hours:$minutes:$seconds",
                                  color: (time < 120)
                                      ? Colors.red
                                      : Colors.black54);
                            },
                            // controller: _.timeController,
                            interval: Duration(seconds: 1),
                            onFinished: () {
                              QuickAlert.show(
                                  context: context,
                                  type: QuickAlertType.loading,
                                  title: "Times Up !",
                                  text: "your answer validating");

                              _.submitExam();
                            },
                          ),
                          width(15)
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Expanded(
                        child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            tx500("Sections"),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                for (var data in _.section)
                                  if (_.questionList[_.section.indexOf(data)]
                                          .length >
                                      0)
                                    GestureDetector(
                                      onTap: () {
                                        _.selectedSection =
                                            _.section.indexOf(data);
                                        _.jumpQuestion(questionNo: 0);
                                        _.update();
                                      },
                                      child: Container(
                                        height: 25,
                                        margin:
                                            EdgeInsets.symmetric(horizontal: 2),
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            color: (_.section.indexOf(data) ==
                                                    _.selectedSection)
                                                ? primaryColor
                                                : Colors.black45
                                                    .withOpacity(.1)),
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 12),
                                        child: tx500(data,
                                            size: 14,
                                            color: (_.section.indexOf(data) ==
                                                    _.selectedSection)
                                                ? Colors.white
                                                : Colors.black87),
                                      ),
                                    )
                              ],
                            ),
                            height(20),
                            if (_.currentQuestion!.questionType ==
                                "multiplechoice")
                              MultipleChoiceView()
                            else if (_.currentQuestion!.questionType ==
                                "multiselect")
                              MultiSelectView()
                            else
                              NumericalOptionView(),
                            SizedBox(
                              height: 70,
                            )
                          ],
                        ),
                      ),
                    ))
                  ],
                ),
              ),
              Positioned(
                  bottom: 20,
                  right: 0,
                  left: 0,
                  child: KeyboardVisibilityBuilder(
                      builder: (context, isKeyboardVisible) {
                    print(isKeyboardVisible);
                    return Visibility(
                      visible: !isKeyboardVisible,
                      child: Row(
                        children: [
                          width(20),
                          Visibility(
                            visible: _.checkQuestionisFirst() != "",
                            child: InkWell(
                              onTap: () {
                                sCtrl.PreviousQuestion();
                              },
                              child: ButtonContainer(
                                  Icon(
                                    Icons.arrow_back_ios,
                                    color: Colors.white,
                                  ),
                                  radius: 10),
                            ),
                          ),
                          Expanded(
                              child: Container(
                                  alignment: Alignment.center,
                                  child: InkWell(
                                    onTap: () {
                                      showDialog(
                                          context: context,
                                          builder: (context) => Material(
                                              color: Colors.transparent,
                                              child: QuestionPalletView()));
                                    },
                                    child: ButtonContainer(
                                        tx600("Question", color: Colors.white),
                                        width: 120,
                                        radius: 10),
                                  ))),
                          InkWell(
                            onTap: () {
                              // examContent.IncrementQuestion();
                              sCtrl.NextQuestion(context);
                            },
                            child: ButtonContainer(
                                tx600(_.checkQuestionEnd(),
                                    color: Colors.white),
                                radius: 10),
                          ),
                          width(20),
                        ],
                      ),
                    );
                  }))
            ],
          );
        })),
      ),
    );
  }
}
