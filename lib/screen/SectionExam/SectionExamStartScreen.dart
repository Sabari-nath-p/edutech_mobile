import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:mathlab/Constants/colors.dart';
import 'package:mathlab/Constants/sizer.dart';
import 'package:mathlab/Constants/textstyle.dart';
import 'package:mathlab/screen/SectionExam/SectionExamViewScreen.dart';
import 'package:mathlab/screen/SectionExam/Service/controller.dart';

class sectionExamStartScreen extends StatelessWidget {
  String exammUniqueId;
  String courseid;
  String subjectid;
  String moduleid;

  sectionExamStartScreen(
      {super.key,
      required this.exammUniqueId,
      required this.courseid,
      required this.moduleid,
      required this.subjectid});
  SectionExamController SEctrl = Get.put(SectionExamController());
  @override
  Widget build(BuildContext context) {
    if (SEctrl.examModel == null)
      SEctrl.fetchExam(
          examUniqueID: exammUniqueId,
          cID: courseid,
          mID: moduleid,
          sID: subjectid);
    return SafeArea(
      child: Scaffold(
        body: GetBuilder<SectionExamController>(builder: (_) {
          return (_.examModel == null)
              ? Center(
                  child: LoadingAnimationWidget.discreteCircle(
                      color: primaryColor, size: 30),
                )
              : Column(
                  children: [
                    height(20),
                    Row(
                      children: [
                        width(20),
                        InkWell(
                            onTap: () {
                              Navigator.of(context).pop();
                            },
                            child: Icon(Icons.arrow_back_ios_new_rounded)),
                        width(10),
                        Expanded(
                            child: Container(
                                constraints: BoxConstraints(
                                    maxWidth: 200, maxHeight: 30),
                                alignment: Alignment.centerLeft,
                                child: tx600("Exam ${_.examModel!.examName}",
                                    textAlign: TextAlign.center,
                                    size: 20,
                                    color: Colors.black))),
                        //  Icon(Icons.menu),
                        width(20)
                      ],
                    ),
                    height(30),
                    // if (examduration != "")
                    //tx600("Time", size: 18, color: Colors.black),
                    //  if (examduration != "")
                    Container(
                      margin: EdgeInsets.all(20),
                      height: 63,
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Color(0xFFFFBB33)),
                      child: Row(
                        children: [
                          tx600("${_.examModel!.durationOfExam!}",
                              size: 20, color: Colors.white),
                          Expanded(child: Container()),
                          Icon(
                            Icons.play_arrow,
                            color: Colors.white,
                          ),
                          tx500(" Start", size: 18, color: Colors.white)
                        ],
                      ),
                    ),
                    // if (instructionSet != "")
                    tx600("Instruction", size: 19, color: Colors.black),
                    // if (instructionSet != "")
                    Expanded(
                        child: Container(
                      margin:
                          EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                      height: double.infinity,
                      width: double.infinity,
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: Color.fromARGB(255, 231, 231, 231)),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            Container(
                              child: Text(
                                "${_.examModel!.instruction!}",
                                textAlign: TextAlign.justify,
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black,
                                    fontFamily: "Mullish"),
                              ),
                            )
                          ],
                        ),
                      ),
                    )),
                    // if (instructionSet != "")
                    Container(
                      alignment: Alignment.center,
                      child: tx400("Click start to begin exam", size: 15),
                    ),
                    // if (instructionSet != "")
                    Container(
                        margin:
                            EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                        child: InkWell(
                          onTap: () {
                            Get.to(() => SectionExamViewScreen(),
                                transition: Transition.rightToLeft);
                            // Navigator.of(context).push(MaterialPageRoute(
                            //     builder: (context) => examMain(
                            //           examData: examData,
                            //           second: timesecond,
                            //         )));
                          },
                          child: ButtonContainer(
                              tx600("Start", color: Colors.white),
                              radius: 10,
                              height: 50,
                              color: primaryColor),
                        )),

                    height(30)
                  ],
                );
        }),
      ),
    );
  }
}
