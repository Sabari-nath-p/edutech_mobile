import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:mathlab/Constants/urls.dart';
import 'package:mathlab/screen/exam/models/ExamData.dart';
import 'package:mathlab/screen/exam/models/questionMode.dart';
import 'package:mathlab/screen/exam/result.dart';
import 'package:quickalert/quickalert.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';
import 'package:http/http.dart' as http;
import '../../../Constants/textstyle.dart';

class TimerBar extends StatefulWidget {
  String time;
  ExamData examData;
  ValueNotifier notifier;

  TimerBar({
    super.key,
    required this.time,
    required this.notifier,
    required this.examData,
  });

  @override
  State<TimerBar> createState() => _TimerBarState();
}

class _TimerBarState extends State<TimerBar> {
  final StopWatchTimer timer = StopWatchTimer(mode: StopWatchMode.countDown);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    startTimer();
    counter = int.parse(widget.time.toString());
    loadListerner();
  }

  loadListerner() async {
    widget.notifier.addListener(() {
      validateAnswer();

      QuickAlert.show(
          context: context,
          type: QuickAlertType.loading,
          title: "Please Wait",
          text: "your answer validating");
      Fluttertoast.showToast(msg: "Answer Validating");
    });
  }

  double progress = 0;
  int counter = 0;
  startTimer() {
    int tm = int.parse(widget.time.toString());

    timer.setPresetSecondTime(tm);
    timer.secondTime.listen((event) {
      setState(() {
        counter = event;
        progress = 344 * event / tm;
      });
    });
    timer.onStartTimer();
    timer.fetchEnded.listen((event) {
      // widget.examData.notifier.value = -101;
      Fluttertoast.showToast(msg: "Timeout");
      Fluttertoast.showToast(msg: "Answer");
      QuickAlert.show(
          context: context,
          type: QuickAlertType.loading,
          title: "Timeout",
          text: "Please wait your answer validating");
      //print("working");
      validateAnswer();
    });
  }

  @override
  void dispose() async {
    super.dispose();
    await timer.dispose(); // Need to call dispose function.
  }

  @override
  Widget build(BuildContext context) {
    Duration duration = Duration(seconds: counter);
    String hours = duration.inHours.toString().padLeft(0, '2');
    String minutes =
        duration.inMinutes.remainder(60).toString().padLeft(2, '0');
    String seconds =
        duration.inSeconds.remainder(60).toString().padLeft(2, '0');
    return Container(
      margin: EdgeInsets.only(left: 20, right: 20, bottom: 20, top: 5),
      height: 63,
      padding: EdgeInsets.symmetric(horizontal: 0),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20), color: Color(0xFFDBDBDB)),
      child: Stack(
        children: [
          Positioned(
              top: 0,
              bottom: 0,
              left: 0,
              width: progress,
              child: InkWell(
                onTap: () {},
                child: AnimatedContainer(
                  width: progress,
                  margin: EdgeInsets.only(left: .5),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Color(0xFFFFBB33)),
                  duration: Duration(milliseconds: 200),
                  curve: Curves.fastOutSlowIn,
                ),
              )),
          Positioned(
            left: 20,
            right: 20,
            bottom: 0,
            top: 0,
            child: Row(
              children: [
                tx600("${hours}:${minutes}:${seconds}",
                    size: 20, color: Colors.white),
                Expanded(child: Container()),
                InkWell(
                  onTap: () {
                    // widget.examData.notifier.value = -101;
                    validateAnswer();

                    Fluttertoast.showToast(msg: "Answer Validating");
                  },
                  child: tx600(
                    " Submit",
                    size: 13,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  double total = 0;
  List answerStatus = [];
  validateAnswer() {
    var examData = widget.examData;
    //print("working1");
    var questionData = examData.questions;
    for (var data in questionData) {
      if (data.status == 1) {
        if (data.model == "multiplechoice") {
          checkchoice(data);
        } else if (data.model == "multiselect") {
          checkselect(data);
          //print("multi_select");
        } else if (data.model == "numericals") {
          checknumerical(data);
        }
      } else {
        answerStatus.add(0);
      }
    }

    //print(total);
    //print(answerStatus);
    loadResult();
  }

  loadResult() async {
    //print(int.parse(widget.time.toString()) - counter);

    var response = {
      for (int i = 0; i < widget.examData.questions.length; i++)
        "${i + 1}": widget.examData.questions[i].answer,
      "time": int.parse(widget.time.toString()) - counter,
      "title": widget.examData.title,
      "total_mark": widget.examData.totalmark,
      "passmark": widget.examData.passMark
    };

    //print(json.encode(response));

    SharedPreferences pref = await SharedPreferences.getInstance();
    String token = pref.getString("TOKEN").toString();
    //print(token);
    final Response =
        await http.post(Uri.parse("$baseurl/applicationview/examresponseadd/"),
            body: json.encode({
              "exam_id": widget.examData.id.toString(),
              "marks_scored": total.toStringAsFixed(0),
              "qualify_score": 00,
              "response": response
            }),
            headers: {
          "Content-Type": "application/json",
          "Authorization": "token $token",
          "Vary": "Accept"
        });
    //print(Response.body);
    if (Response.statusCode == 201 || Response.statusCode == 200) {
      Box bk = await Hive.openBox("EXAM_RESULT");
      var js = json.decode(Response.body);
      bk.put(js["data"]["exam_id"].toString(), js["data"]);
      Navigator.of(context).pop();
      Navigator.of(context).pop();
      Navigator.of(context).pop();
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => ExamResult(
                total: total,
                answerStatus: answerStatus,
                examData: widget.examData,
                seconds: int.parse(widget.time.toString()) - counter,
              )));
    }
    // Navigator.of(context).push(MaterialPageRoute(
    //     builder: (context) => ExamResult(
    //           total: total,
    //           answerStatus: answerStatus,
    //           examData: widget.examData,
    //           seconds: int.parse(widget.time.toString()) - counter,
    //         )));
  }

  checknumerical(QuestionListModel qmodel) {
    if (qmodel.answer.toString() != "") {
      double positive_marks =
          double.parse(qmodel.questionData["positive_marks"].toString())
              .toDouble();
      double negetive_mark =
          double.parse(qmodel.questionData["negetive_mark"].toString())
              .toDouble();
      // //print(positive_marks);
      //print(qmodel.answer.toString());
      double answer = double.parse(qmodel.answer.toString()).toDouble();
      double maxAnswer =
          double.parse(qmodel.questionData["ans_max_range"].toString())
              .toDouble();
      double minAnswer =
          double.parse(qmodel.questionData["ans_min_range"].toString())
              .toDouble();
      //print(answer);
      //print("numerical");
      if (maxAnswer >= answer && minAnswer <= answer) {
        answerStatus.add(1);
        total = total + positive_marks;
      } else {
        total = total - negetive_mark;
        answerStatus.add(2);
      }
    } else {
      answerStatus.add(0);
    }
  }

  checkchoice(QuestionListModel qmodel) {
    double positive_marks =
        double.parse(qmodel.questionData["positive_marks"].toString())
            .toDouble();
    double negetive_mark =
        double.parse(qmodel.questionData["negetive_mark"].toString())
            .toDouble();
    // //print(positive_marks);
    String answer = qmodel.answer.toString();

    ////print(answer);
    if (answer == "0" && qmodel.questionData["answer"].toString() == "A") {
      answerStatus.add(1);
      total = total + positive_marks;
    } else if (answer == "1" &&
        qmodel.questionData["answer"].toString() == "B") {
      answerStatus.add(1);
      total = total + positive_marks;
    } else if (answer == "2" &&
        qmodel.questionData["answer"].toString() == "C") {
      answerStatus.add(1);
      total = total + positive_marks;
    } else if (answer == "3" &&
        qmodel.questionData["answer"].toString() == "D") {
      answerStatus.add(1);
      total = total + positive_marks;
    } else {
      total = total - negetive_mark;
      answerStatus.add(2);
    }
    // //print(total);
  }

  checkselect(QuestionListModel qmodel) {
    String answer = qmodel.answer.toString();
    double positive_marks =
        double.parse(qmodel.questionData["positive_marks"].toString())
            .toDouble();
    double negetive_mark =
        double.parse(qmodel.questionData["negetive_mark"].toString())
            .toDouble();

    //print("answer + ");
    //print(answer);
    //print("multi_select");
    int i = -1;
    int status = 0;
    for (var data in qmodel.questionData["options"]) {
      i++;
      //print(data["is_answer"]);
      if (!data["is_answer"] && answer.contains(i.toString())) {
        total = total - negetive_mark;
        status = 1;
        answerStatus.add(2);
        break;
      } else if (data["is_answer"] && !answer.contains(i.toString())) {
        total = total - negetive_mark;
        answerStatus.add(2);
        status = 1;
        break;
      }
    }

    if (status == 0) {
      total = total + positive_marks;
      answerStatus.add(1);
    }
  }
}
