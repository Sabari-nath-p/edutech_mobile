import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:mathlab/Constants/sizer.dart';
import 'package:mathlab/Constants/textstyle.dart';

class ResultPage extends StatefulWidget {
  const ResultPage({super.key});

  @override
  State<ResultPage> createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          height(20),
          Container(
            alignment: Alignment.center,
            child: tx600("Attended Exam", size: 21, color: Colors.black),
          ),
          Container(
            width: 200,
            height: 2,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.black.withOpacity(.7)),
          ),
          Expanded(
              child: Padding(
            padding: const EdgeInsets.all(60),
            child: Center(
              child: LottieBuilder.network(
                  "https://lottie.host/770cb31f-b2d7-49e6-b5aa-c5dddb38a756/amtSUlPjmr.json",),
            ),
          ))
        ],
      ),
    );
  }
}
