import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:mathlab/Constants/sizer.dart';
import 'package:mathlab/Constants/textstyle.dart';
import 'package:mathlab/screen/SectionExam/Views/ResultViewScreen.dart';
import 'package:mathlab/screen/exam/models/ExamData.dart';

import 'exam/validationFile.dart';

class ResultPage extends StatefulWidget {
  const ResultPage({super.key});

  @override
  State<ResultPage> createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  @override
  void initState() {
    // TODO: implement initState
    loadAttendedExam();
    super.initState();
  }

  List exams = [];
  loadAttendedExam() async {
    //print("working");
    print("exam result loading");
    Box bk = await Hive.openBox("EXAM_RESULT");

    for (var data in bk.keys) {
      // //print((data));
      print(bk.keys);
      // //print(bk.get(data));
      print(data);

      var dt = bk.get(data);
      if (dt != null) exams.add(dt);
    }
    print(exams);
    totalExam = exams.length;

    findPercentage();
  }

  findPercentage() {
    for (var data in exams) {
      if (data["total_scored"] != null) {
        double percentage =
            (double.parse(data["marks_scored"].toString()).toDouble() /
                    double.parse(data["total_scored"].toString()).toDouble()) *
                100;
        PercentageList.add(percentage);
      }

      print(PercentageList);
    }
    double hight = 0;
    double sum = 0;
    for (var data in PercentageList) {
      if (hight < data) {
        hight = data;
        sum = sum + data;
      }
    }

    heighestPercentage = hight.toStringAsFixed(1);
    AveragePercentage = (sum / PercentageList.length).toStringAsFixed(1);
    setState(() {});
  }

  List PercentageList = [];
  int totalExam = 0;
  String heighestPercentage = "0.0";
  String AveragePercentage = "0.0";

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: SingleChildScrollView(
        child: Column(
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
            if (PercentageList.isNotEmpty)
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white),
                margin: EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "  Score Analytics",
                      style: TextStyle(
                          fontFamily: "Poppins",
                          fontWeight: FontWeight.w600,
                          fontSize: 17.5,
                          color: Colors.black),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white),
                          width: 110,
                          height: 70,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "${PercentageList.length}/$totalExam",
                                style: TextStyle(
                                    fontFamily: "Poppins",
                                    fontWeight: FontWeight.w600,
                                    fontSize: 20.5,
                                    color: Colors.black),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                "No of Exams",
                                style: TextStyle(
                                    fontFamily: "Poppins",
                                    fontWeight: FontWeight.w600,
                                    fontSize: 8,
                                    color: Colors.black),
                              )
                            ],
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white),
                          width: 110,
                          height: 70,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "$heighestPercentage%",
                                style: TextStyle(
                                    fontFamily: "Poppins",
                                    fontWeight: FontWeight.w600,
                                    fontSize: 20.5,
                                    color: Colors.black),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                "Highest Percentage",
                                style: TextStyle(
                                    fontFamily: "Poppins",
                                    fontWeight: FontWeight.w600,
                                    fontSize: 8,
                                    color: Colors.black),
                              )
                            ],
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white),
                          width: 110,
                          height: 70,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "$AveragePercentage%",
                                style: TextStyle(
                                    fontFamily: "Poppins",
                                    fontWeight: FontWeight.w600,
                                    fontSize: 20.5,
                                    color: Colors.black),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                "Average Percentage",
                                style: TextStyle(
                                    fontFamily: "Poppins",
                                    fontWeight: FontWeight.w600,
                                    fontSize: 8,
                                    color: Colors.black),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            for (var data in exams)
              InkWell(
                onTap: () {
                  // ExamData examData = ExamData();
                  // examData.id = int.parse(data["exam_id"]);
                  // examData.fetchAnswer(data["response"]);
                  print(data);
                  Get.to(
                      () => ResultViewScreen(
                            UserResponse: data,
                            slug: "",
                          ),
                      transition: Transition.rightToLeft);
                  // Navigator.of(context).push(MaterialPageRoute(
                  //     builder: (context) => ExamAnswerValidation(
                  //         examData: examData, data: data)));
                },
                child: Container(
                  //height: 90,
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  margin: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white),
                  child: Row(
                    children: [
                      SvgPicture.asset("assets/icons/exam.svg"),
                      width(20),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              data["exam_name"].toString(),
                              style: TextStyle(
                                fontFamily: "Poppins",
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            height(8),
                            tx500(
                                "Mark Scored : ${data["marks_scored"].toString()} / ${data["total_scored"]}",
                                size: 12)
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            if (exams.isEmpty)
              Container(
                height: MediaQuery.of(context).size.height,
                padding: const EdgeInsets.all(60),
                child: Center(
                  child: LottieBuilder.network(
                    "https://lottie.host/770cb31f-b2d7-49e6-b5aa-c5dddb38a756/amtSUlPjmr.json",
                  ),
                ),
              )
          ],
        ),
      ),
    );
  }
}
