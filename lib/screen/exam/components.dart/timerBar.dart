import 'package:flutter/material.dart';
import 'package:mathlab/screen/exam/models/ExamData.dart';
import 'package:mathlab/screen/exam/result.dart';
import 'package:mathlab/screen/exam/validationFile.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';

import '../../../Constants/textstyle.dart';

class TimerBar extends StatefulWidget {
  String time;
  ExamData examData;
  TimerBar({super.key, required this.time, required this.examData});

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
              child: AnimatedContainer(
                width: progress,
                margin: EdgeInsets.only(left: .5),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Color(0xFFFFBB33)),
                duration: Duration(milliseconds: 200),
                curve: Curves.fastOutSlowIn,
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
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => ExamAnswerValidation(
                              examData: widget.examData,
                            )));
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
}
