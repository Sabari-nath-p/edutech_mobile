import 'package:flutter/material.dart';
import 'package:mathlab/Constants/sizer.dart';
import 'package:mathlab/Constants/textstyle.dart';
import 'package:mathlab/main.dart';
import 'package:mathlab/screen/exam/components.dart/question.dart';
import 'package:tex_text/tex_text.dart';
import '../models/ExamData.dart';
import '../models/questionMode.dart';

class ExamOptions extends StatefulWidget {
  ExamData examData;
  ExamOptions({super.key, required this.examData});

  @override
  State<ExamOptions> createState() => _ExamOptionsState();
}

class _ExamOptionsState extends State<ExamOptions> {
  int selectedOption = -1;
  List multipleOption = [];
  TextEditingController numericController = TextEditingController();
  final GlobalKey key = GlobalKey();
  late RenderBox renderBox;

  void calculateClippedPixels() {
    renderBox = key.currentContext!.findRenderObject() as RenderBox;

    final double totalWidth = renderBox.size.width;
    final double visibleWidth = renderBox.constraints.maxWidth;

    final double clippedWidth = totalWidth - visibleWidth;

    //print("Total Width: $totalWidth");
    //print("Visible Width: $visibleWidth");
    //print("Clipped Width: $clippedWidth pixels");
  }

  loadOption() {
    multipleOption = [];
    qnmodel = widget.examData.getCurrentQuestion();
    questionType = qnmodel.model!;
    if (questionType == "multiplechoice") {
      setState(() {
        if (qnmodel.answer.toString() != "")
          selectedOption = int.parse(qnmodel.answer.toString());
        else
          selectedOption = -1;
      });
    } else if (questionType == "multiselect") {
      setState(() {
        if (qnmodel.answer.toString().contains("0")) multipleOption.add(0);
        if (qnmodel.answer.toString().contains("1")) multipleOption.add(1);
        if (qnmodel.answer.toString().contains("2")) multipleOption.add(2);
        if (qnmodel.answer.toString().contains("3")) multipleOption.add(3);
      });
    } else if (questionType == "numericals") {
      setState(() {
        numericController.text = qnmodel.answer.toString();
      });
    }
  }

  loadNotifier() {
    widget.examData.notifier.addListener(() {
      //print("Working");
      setState(() {
        selectedOption = -1;
        loadOption();
      });
    });
  }

  String questionType = "";
  late QuestionListModel qnmodel;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    qnmodel = widget.examData.getCurrentQuestion();
    questionType = qnmodel.model!;
    loadOption();
    loadNotifier();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
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
      margin: EdgeInsets.all(10),
      child: Column(
        children: [
          if (questionType == "multiplechoice" || questionType == "multiselect")
            for (int i = 0; i < 4; i++)
              if (questionType == "multiplechoice")
                Container(
                  margin: EdgeInsets.symmetric(vertical: 10),
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        if (selectedOption != i) {
                          selectedOption = i;
                          widget.examData.markAnswer(i.toString());
                        } else {
                          selectedOption = -1;
                          widget.examData.unMarkAnswer(i.toString());
                        }
                      });
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
                                  color: (selectedOption == i)
                                      ? Colors.green
                                      : Colors.black54,
                                  width: 1.3)),
                          child: (selectedOption == i)
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
                              : tx500(
                                  String.fromCharCode('A'.codeUnitAt(0) + i),
                                  size: 14),
                        ),
                        width(10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              if (qnmodel
                                      .questionData["option${i + 1}_image"] !=
                                  null)
                                Image.network(qnmodel
                                    .questionData["option${i + 1}_image"]),
                              if (qnmodel.questionData["option${i + 1}_text"] !=
                                  null)
                                TexText(
                                    qnmodel.questionData["option${i + 1}_text"],
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
                )
              else if (questionType == "multiselect")
                Container(
                  margin: EdgeInsets.symmetric(vertical: 15),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () {
                          setState(() {
                            if (multipleOption.indexOf(i) == -1) {
                              widget.examData.markAnswer(i.toString());
                              multipleOption.add(i);
                            } else {
                              widget.examData.unMarkAnswer(i.toString());
                              multipleOption.remove(i);
                            }
                          });
                        },
                        child: Container(
                          height: 25,
                          width: 25,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(0),
                              color: (multipleOption.contains(i))
                                  ? Colors.green
                                  : null,
                              border: Border.all(
                                  color: Colors.black54, width: 1.3)),
                          child: (multipleOption.contains(i))
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
                                  String.fromCharCode('A'.codeUnitAt(0) + i),
                                  size: 14),
                        ),
                      ),
                      width(20),
                      Expanded(
                          child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (qnmodel.questionData["options"][i]
                                  ["options_image"] !=
                              null)
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.network(qnmodel
                                  .questionData["options"][i]["options_image"]),
                            ),
                          if (qnmodel.questionData["options"][i]
                                  ["options_text"] !=
                              null)
                            // if (checkOverflow(
                            //     context,
                            //     (qnmodel.questionData["options"][i]
                            //         ["options_text"])))
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: SizedBox(
                                  width: 390,
                                  child: TexText(qnmodel.questionData["options"]
                                      [i]["options_text"])),
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
          if (questionType == "numericals")
            Container(
              width: double.infinity,
              height: 150,
              child: Stack(
                children: [
                  Positioned(
                      top: 0,
                      left: 0,
                      child: tx500("Enter your answer", size: 14)),
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
                          controller: numericController,
                          keyboardType: TextInputType.numberWithOptions(
                              signed: true, decimal: true),
                          onChanged: (newanswer) {
                            ////print(newanswer);
                            widget.examData.markAnswer(newanswer);
                            //print(widget.examData.getCurrentQuestion().answer);
                          },
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(color: Colors.grey))),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            )
        ],
      ),
    );
  }
}
