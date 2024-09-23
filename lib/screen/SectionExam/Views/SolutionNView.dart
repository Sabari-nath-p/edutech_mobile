import 'package:flutter/material.dart';
import 'package:mathlab/Constants/sizer.dart';
import 'package:mathlab/Constants/textstyle.dart';
import 'package:mathlab/screen/SectionExam/Model/SQLModel.dart';
import 'package:tex_text/tex_text.dart';

class SolutionNQSView extends StatelessWidget {
  SQLModel model;
  SolutionNQSView({super.key, required this.model});
  @override
  Widget build(BuildContext context) {
    TextEditingController tctrl = TextEditingController(text: model.answers);
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
                            if (model.numericals!.question != null)
                              SingleChildScrollView(
                                child: SizedBox(
                                  width: 310,
                                  child: TexText(
                                    model.numericals!
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
                            if (model.numericals!.questionImage != null)
                              ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.network(
                                    model.numericals!.questionImage!),
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
                                  enabled: false,
                                  decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          borderSide:
                                              BorderSide(color: Colors.grey))),
                                ),
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
                          if (model.numericals!.solutionText != null)
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8),
                              child: TexText(
                                model.numericals!.solutionText!,
                                style: TextStyle(
                                    color: Colors.white.withOpacity(.9),
                                    fontFamily: "Poppins",
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                          //  if (widget.examData.questionData["question_image"] != null || type == "mix") height(10),
                          if (model.numericals!.solutionImage != null)
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.network(
                                  model.numericals!.solutionImage!),
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
