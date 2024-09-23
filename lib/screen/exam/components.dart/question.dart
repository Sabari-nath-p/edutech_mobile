import 'package:flutter/material.dart';
import 'package:mathlab/Constants/sizer.dart';
import 'package:mathlab/Constants/textstyle.dart';
import 'package:mathlab/screen/exam/ExamMain.dart';
import 'package:mathlab/screen/exam/models/questionMode.dart';
import 'package:tex_text/tex_text.dart';

import '../models/ExamData.dart';

class questionView extends StatefulWidget {
  QuestionListModel examData;
  int currentQuestion;
  questionView(
      {super.key, required this.examData, required this.currentQuestion});

  @override
  State<questionView> createState() => _questionViewState();
}

class _questionViewState extends State<questionView> {
  final GlobalKey key = GlobalKey();
  late RenderBox renderBox;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      calculateClippedPixels();
    });
  }

  void calculateClippedPixels() {
    renderBox = key.currentContext!.findRenderObject() as RenderBox;

    final double totalWidth = renderBox.size.width;
    final double visibleWidth = renderBox.constraints.maxWidth;

    final double clippedWidth = totalWidth - visibleWidth;

    //print("Total Width: $totalWidth");
    //print("Visible Width: $visibleWidth");
    //print("Clipped Width: $clippedWidth pixels");
  }

  //String questionText = "";
  @override
  Widget build(BuildContext context) {
    String? questionText = widget.examData.questionData["question"];
    //String type = widget.examData.questionData["type"];
    //   calculateClippedPixels();
    return Column(
      children: [
        Image.asset("assets/image/base.png"),
        Container(
          key: key,
          width: double.infinity,
          padding: EdgeInsets.only(left: 8, right: 8, top: 10, bottom: 10),
          margin: EdgeInsets.symmetric(horizontal: 10),
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
                  tx600(" Question ${widget.currentQuestion + 1}",
                      color: Colors.white.withOpacity(.9), size: 14),
                  Expanded(child: Container()),
                  tx500(
                      "Section ${widget.examData.questionData["section"] ?? "A"}  ",
                      size: 12,
                      color: Colors.white)
                ],
              ),
              height(6),

              if (widget.examData.questionData["question"] != null)
                if (questionText != null)
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: SizedBox(
                      width: 350,
                      child: TexText(
                        questionText, // questionText!,
                        mathStyle: MathStyle.display,
                        style: TextStyle(
                            color: Colors.white.withOpacity(.9),
                            fontFamily: "Poppins",
                            fontSize: 15,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
              if (questionText != null)
                if (!checkOverflow(context, questionText) && false)
                  SingleChildScrollView(
                    //  width: MediaQuery.of(context).size.width - 40,
                    scrollDirection: Axis.horizontal,
                    //padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: TexText(
                      questionText,
                      mathStyle: MathStyle.textCramped,
                      style: TextStyle(
                          color: Colors.white.withOpacity(.9),
                          fontFamily: "Poppins",
                          fontSize: 15,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
              //  if (widget.examData.questionData["question_image"] != null || type == "mix") height(10),
              if (widget.examData.questionData["question_image"] != null)
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                      widget.examData.questionData["question_image"]),
                ),
            ],
          ),
        ),
        if (false)
          Container(
            margin: EdgeInsets.only(left: 17),
            alignment: Alignment.topLeft,
            height: 180,
            child: Stack(
              //crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (false)
                  Positioned(
                      top: 0,
                      right: 0,
                      left: 0,
                      child: Image.asset(
                        "assets/image/questionbg.png",
                        fit: BoxFit.fill,
                      )),
              ],
            ),
          ),
        if (false)
          Container(
            height: 150,
            child: Image.network(
                "https://www.aplustopper.com/wp-content/uploads/2019/08/Plus-One-Physics-Chapter-Wise-Questions-and-Answers-Chapter-3-Motion-in-a-Straight-Line-1M-Q4.jpg"),
          )
      ],
    );
  }
}

bool checkOverflow(BuildContext context, String text) {
  // Create a TextPainter to measure the text layout
  final TextPainter textPainter = TextPainter(
    text: TextSpan(
      text: text,
      style: DefaultTextStyle.of(context).style,
    ),
    maxLines: 2, // Same as the maxLines set in the Text widget
    textDirection: TextDirection.ltr,
  );

  textPainter.layout(maxWidth: 330); // Same as the fixed width of the container

  // Check if the text exceeds the specified maxLines
  if (textPainter.didExceedMaxLines) {
    return false;
  } else {
    return true;
  }
}
