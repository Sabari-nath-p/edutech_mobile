import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:mathlab/Constants/sizer.dart';
import 'package:mathlab/Constants/textstyle.dart';
import 'package:mathlab/screen/SectionExam/Service/controller.dart';
import 'package:tex_text/tex_text.dart';

class NumericalOptionView extends StatelessWidget {
  NumericalOptionView({super.key});
  SectionExamController ctrl = Get.put(SectionExamController());
  @override
  Widget build(BuildContext context) {
    TextEditingController tctrl =
        TextEditingController(text: ctrl.currentQuestion!.answers);
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
                    if (_.currentQuestion!.numericals!.question != null)
                      SingleChildScrollView(
                        child: SizedBox(
                          width: 310,
                          child: TexText(
                            _.currentQuestion!.numericals!
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
                    if (_.currentQuestion!.numericals!.questionImage != null)
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.network(
                            _.currentQuestion!.numericals!.questionImage!),
                      ),
                  ],
                )),
            height(20),
            Container(
              width: double.infinity,
              height: 200,
              child: Stack(
                children: [
                  Positioned(
                      top: 0,
                      right: 0,
                      left: 0,
                      child: tx500("Enter your answer ", size: 14)),
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
                          controller: tctrl,
                          keyboardType: TextInputType.numberWithOptions(
                              signed: true, decimal: true),
                          onSubmitted: (newanswer) {
                            ////print(newanswer);
                            _.currentQuestion!.clickOnOption(newanswer);
                            _.update();
                            Fluttertoast.showToast(
                                msg: "Answer saved successfully");
                            // widget.examData.markAnswer(newanswer);
                            //print(widget.examData.getCurrentQuestion().answer);
                          },
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(color: Colors.grey))),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                      bottom: 0,
                      right: 100,
                      left: 100,
                      child: InkWell(
                        onTap: () {
                          _.currentQuestion!.clickOnOption(tctrl.text);
                          _.update();
                          Fluttertoast.showToast(
                              msg: "Answer saved successfully");
                        },
                        child: ButtonContainer(
                          radius: 10,
                          tx600("Save Answer", color: Colors.white),
                        ),
                      ))
                ],
              ),
            )
          ],
        );
      }),
    );
  }
}
