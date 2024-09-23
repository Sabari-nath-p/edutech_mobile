import 'dart:convert';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:mathlab/Constants/sizer.dart';
import 'package:mathlab/Constants/textstyle.dart';
import 'package:mathlab/Constants/urls.dart';
import 'package:mathlab/main.dart';
import 'package:mathlab/screen/SectionExam/SectionExamStartScreen.dart';
import 'package:mathlab/screen/SectionExam/Views/ResultViewScreen.dart';
import 'package:mathlab/screen/edPlayer.dart';
import 'package:mathlab/screen/exam/examstart.dart';
import 'package:mathlab/screen/noteScreen.dart';
import 'package:pod_player/pod_player.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../Constants/colors.dart';
import 'exam/models/ExamData.dart';
import 'exam/validationFile.dart';

class VideoPlayerScreen extends StatefulWidget {
  String chapterID;
  String subjectID;
  String courseID;
  VideoPlayerScreen(
      {super.key,
      required this.chapterID,
      required this.subjectID,
      required this.courseID});

  @override
  State<VideoPlayerScreen> createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  late PodPlayerController controller;
  bool isvideoLoaded = false;
  int selectedIndex = -1;
  List videoData = [];

  @override
  void initState() {
    super.initState();
    loadVideoList();
    loadNoteList();
    loadExamlist();
  }

  late var ctr;

  loadVideo(String videoID) async {
    //final Map<String, String> headers = <String, String>{};
    //https://vimeo.com/853555974?share=copy
    //  headers['Authorization'] = 'bc09f483c2c74f9df6c7d904de7ada01';
    String tk = 'c15bd5941857f4e8680986c11a94cf38';
    //print(videoID);
    final Map<String, String> headers = <String, String>{};
    headers['Authorization'] = 'Bearer ${tk}';
    controller = PodPlayerController(
      playVideoFrom: PlayVideoFrom.vimeo("76979871",
          hash: "8272103f6e",
          httpHeaders: headers,
          videoPlayerOptions: VideoPlayerOptions()),
    )..initialise();
    controller.play();

    ctr = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Update loading bar.
          },
          onPageStarted: (String url) {},
          onPageFinished: (String url) {},
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.startsWith('https://www.youtube.com/')) {
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(
          Uri.parse('https://player.vimeo.com/video/76979871?h=8272103f6e'));
  }

  @override
  void dispose() {
    //controller.dispose();
    super.dispose();
  }

  loadVideoList() async {
    final videoResponse = await http.get(Uri.parse(
        "$baseurl/applicationview/courses/${widget.courseID}/subjects/${widget.subjectID}/modules/${widget.chapterID}/videos/"));

    if (videoResponse.statusCode == 200) {
      var js = json.decode(videoResponse.body);
      for (var data in js) {
        data["sort_title"] = data["title"];
        videoData.add(data);
      }
      setState(() {
        loadSorting();
      });
    }
  }

  loadNoteList() async {
    final noteResponse = await http.get(Uri.parse(
        "$baseurl/applicationview/courses/${widget.courseID}/subjects/${widget.subjectID}/modules/${widget.chapterID}/notes/"));

    if (noteResponse.statusCode == 200) {
      var js = json.decode(noteResponse.body);
      //   js["sort_title"] = js["title"];

      for (var data in js) {
        data["sort_title"] = data["title"];
        videoData.add(data);
      }
      setState(() {
        loadSorting();
      });
    }
  }

  int totalExam = 0;
  List ExamList = [];
  List PercentageList = [];
  String heighestPercentage = "0.0";
  String AveragePercentage = "0.0";

  findOutPercentage() async {
    //print("loading");
    Box bx = await Hive.openBox("EXAM_RESULT");

    for (var data in ExamList) {
      var save = bx.get(data["exam_unique_id"].toString());

      if (save != null) {
        if (save["total_scored"] != null) {
          double percentage = (double.parse(save["marks_scored"].toString())
                      .toDouble() /
                  double.parse(save["total_scored"].toString()).toDouble()) *
              100;
          PercentageList.add(percentage);
        }
      }
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

  loadExamlist() async {
    final examResponse = await http.get(Uri.parse(
        "$baseurl/applicationview/courses/${widget.courseID}/subjects/${widget.subjectID}/modules/${widget.chapterID}/exams"));
    totalExam = 0;
    if (examResponse.statusCode == 200) {
      var js = json.decode(examResponse.body);
      ExamList = js;
      for (var data in js) {
        totalExam = totalExam + 1;
        data["title"] = data["exam_name"];
        data["sort_title"] = data["title"];

        videoData.add(data);
      }
      setState(() {
        //   videoData.addAll(js);
        //  loadSorting();
      });
    }
    findOutPercentage();
    loadSorting();
  }

  loadSorting() {
    sortContentList(videoData);
  }

  List<dynamic> sortContentList(List<dynamic> contentList) {
    List<String> _extractVersion(dynamic content) {
      // Use regular expression to extract version numbers
      RegExp regex = RegExp(r'(\d+(\.\d+)*)');
      RegExpMatch? match = regex.firstMatch(content["sort_title"]!);
      List<String> versionNumbers =
          match != null ? match.group(1)!.split('.') : ['0'];
      content["sort_title"] = versionNumbers
          .join('.')
          .toString(); // Update title with the modified version
      return versionNumbers;
    }

    // Sort content based on extracted version numbers
    contentList.sort((a, b) {
      List<String> versionA = _extractVersion(a);
      List<String> versionB = _extractVersion(b);

      for (int i = 0; i < versionA.length && i < versionB.length; i++) {
        int numA = int.parse(versionA[i]);
        int numB = int.parse(versionB[i]);

        if (numA != numB) {
          return numA - numB;
        }
      }

      return versionA.length - versionB.length;
    });

    return contentList;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Column(
        children: [
          Container(
            height: 55,
            color: Colors.white,
            child: Row(
              children: [
                width(20),
                InkWell(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: CircleAvatar(
                      backgroundColor: Colors.grey.withOpacity(.1),
                      child: Icon(
                        Icons.arrow_back_ios_new,
                        color: Colors.black,
                      )),
                ),
                width(5),
                SizedBox(
                    height: 45,
                    child: Image.asset("assets/icons/mathlablogo.png"))
              ],
            ),
          ),
          if (isvideoLoaded)
            Container(
                height: 215,
                child: WebViewWidget(
                    controller:
                        ctr)), // PodVideoPlayer(controller: controller)),
          if (isvideoLoaded)
            Container(
              decoration: BoxDecoration(
                  border: Border(
                      bottom: BorderSide(color: Colors.grey.withOpacity(.6)))),
              padding:
                  EdgeInsets.only(left: 20, top: 10, right: 10, bottom: 10),
              alignment: Alignment.topLeft,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    constraints: BoxConstraints(maxHeight: 56),
                    child: tx600("${videoData[selectedIndex]["title"]}",
                        color: Colors.black, size: 18),
                  ),
                  height(10),
                  tx400("Contents: ${videoData[selectedIndex]["description"]}",
                      color: Colors.black, size: 12),
                ],
              ),
            ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: 10,
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
                  if (videoData.isEmpty)
                    Center(
                      child: SizedBox(
                          height: 200,
                          width: 200,
                          child: LoadingAnimationWidget.beat(
                              color: primaryColor, size: 40)),
                    ),
                  if (videoData.isNotEmpty)
                    for (int i = 0; i < videoData.length; i++)
                      if (videoData[i]["video_id"] != null)
                        videoListCard(i)
                      else if ((videoData[i]["pdf"] != null))
                        noteListCard(i)
                      else if ((videoData[i]["exam_name"] != null))
                        ExamListCard(i)
                      else
                        TitleListCard(i),
                  height(20)
                ],
              ),
            ),
          ),
        ],
      ),
    ));
  }

  TitleListCard(int i) {
    return Container(
      width: double.infinity,
      //height: 35,
      margin: EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 10),
      padding: EdgeInsets.only(left: 10, bottom: 5, top: 5, right: 10),
      alignment: Alignment.centerLeft,
      decoration: BoxDecoration(
        //    color: Colors.white,
        border: Border(bottom: BorderSide(color: Colors.black.withOpacity(.1))),
      ),
      child: Text(
        videoData[i]["title"],
        style: TextStyle(
            fontFamily: "Poppins",
            fontWeight: FontWeight.w600,
            fontSize: 14.5,
            color: Colors.black),
      ),
    );
  }

  videoListCard(int i) {
    return InkWell(
      onTap: () {
        // //print(videoData[i]["video_id"]);
        if (videoData[i]["access_type"] == 2 ||
            checkCourseActive(int.parse(widget.courseID))) {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => edPlayer(
                    url: videoData[i]["video_id"].toString(),
                  )));
          // setState(() {
          //   if (!isvideoLoaded)
          //     loadVideo(videoData[i]["video_id"]);
          //   else {
          //     controller.changeVideo(
          //         playVideoFrom: PlayVideoFrom.vimeo(videoData[i]["video_id"]));
          //   }
          //   isvideoLoaded = true;
          //   selectedIndex = i;
          // });
        } else {
          Fluttertoast.showToast(
              msg: "Prime leature , only avilable to Enrolled user");
        }
      },
      child: Container(
        height: (i == selectedIndex) ? 80 : 80,
        constraints: BoxConstraints(),
        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                  color: Colors.grey.withOpacity(.4),
                  offset: Offset(1, 1),
                  spreadRadius: .2,
                  blurRadius: 2)
            ]),
        child: Row(
          children: [
            width(5),
            ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: SizedBox(
                height: 70,
                width: 100,
                child: Image.network(
                  "https://vumbnail.com/${videoData[i]["video_id"].toString().split("/")[0]}.jpg",
                  fit: BoxFit.fill,
                ),
              ),
            ),
            Expanded(
              child: Stack(
                fit: StackFit.loose,
                children: [
                  if (videoData[i]["access_type"] == 1)
                    Positioned(
                        right: 20,
                        bottom: 10,
                        child: ((i == selectedIndex))
                            ? SvgPicture.asset("assets/icons/progess_icon.svg")
                            : Icon(
                                Icons.lock,
                                size: 15,
                                color: Colors.black.withOpacity(.9),
                              )),
                  Positioned(
                      right: 40,
                      bottom: 8,
                      child: tx400("Video Class", size: 10)),
                  Positioned(
                      top: 10,
                      left: 10,
                      right: 10,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            constraints: BoxConstraints(maxHeight: 45),
                            child: tx600(videoData[i]["title"],
                                color: Colors.black, size: 14),
                          ),
                          // tx400("${videoData[i]["description"]}",
                          //     color: Colors.black, size: 12),
                        ],
                      )),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  noteListCard(int i) {
    return InkWell(
      onTap: () {
        if (videoData[i]["access_type"] == 2 ||
            checkCourseActive(int.parse(widget.courseID))) {
          if (isvideoLoaded) controller.pause();

          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => noteScreen(notelink: videoData[i]["pdf"])));
        } else {
          Fluttertoast.showToast(
              msg: "Prime leature , only avilable to Enrolled user");
        }
      },
      child: Container(
        height: (i == selectedIndex) ? 80 : 80,
        constraints: BoxConstraints(),
        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                  color: Colors.grey.withOpacity(.4),
                  offset: Offset(1, 1),
                  spreadRadius: .2,
                  blurRadius: 2)
            ]),
        child: Stack(
          fit: StackFit.loose,
          children: [
            Positioned(
                left: 5,
                top: 5,
                child: Container(
                  width: 100,
                  padding: EdgeInsets.all(15),
                  height: 70,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black.withOpacity(.09),
                            offset: Offset(1, 1))
                      ]),
                  child: Image.asset(
                    "assets/icons/mathlablogo.png",
                  ),
                )),
            Positioned(
                right: 40, bottom: 8, child: tx400("PDF Note", size: 10)),
            if (videoData[i]["access_type"] == 1)
              Positioned(
                  right: 20,
                  bottom: 10,
                  child: ((i == selectedIndex))
                      ? SvgPicture.asset("assets/icons/progess_icon.svg")
                      : Icon(
                          Icons.lock,
                          size: 15,
                          color: Colors.black.withOpacity(.8),
                        )),
            Positioned(
                top: 10,
                left: 110,
                right: 10,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      constraints: BoxConstraints(maxHeight: 45),
                      child: tx600(videoData[i]["title"],
                          color: Colors.black, size: 14),
                    ),
                    // Text(
                    //   "Contents :  ${videoData[i]["description"]}",
                    //   style: TextStyle(
                    //       fontFamily: "Poppins", fontWeight: FontWeight.w400),
                    //   maxLines: 1,
                    // ),
                  ],
                )),
          ],
        ),
      ),
    );
  }

  ExamListCard(int i) {
    return InkWell(
      onTap: () async {
        Box bk = await Hive.openBox("EXAM_RESULT");
        var data = bk.get(videoData[i]["exam_unique_id"].toString());
        print(videoData[i]["exam_unique_id"]);
        print(data);
        if (data == null) {
          if (videoData[i]["access_type"] == 2 ||
              videoData[i]["access_type"] == null ||
              checkCourseActive(int.parse(widget.courseID)) ||
              checkActiveExam(
                  int.parse(videoData[i]["exam_unique_id"].toString()))) {
            Get.to(
                () => sectionExamStartScreen(
                      exammUniqueId: videoData[i]["exam_unique_id"].toString(),
                      courseid: widget.courseID,
                      subjectid: widget.subjectID,
                      moduleid: widget.chapterID,
                    ),
                transition: Transition.rightToLeft);
          } else {
            Fluttertoast.showToast(
                msg: "Prime leature , only avilable to Enrolled user");
          }
        } else {
          Get.to(() => ResultViewScreen(
                UserResponse: data,
                slug:
                    '/applicationview/courses/${widget.courseID}/subjects/${widget.subjectID}/modules/${widget.chapterID}/exams/${videoData[i]["exam_unique_id"]}',
              ));
        }
      },
      child: Container(
        height: (i == selectedIndex) ? 90 : 90,
        constraints: BoxConstraints(),
        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                  color: Colors.grey.withOpacity(.4),
                  offset: Offset(1, 1),
                  spreadRadius: .2,
                  blurRadius: 2)
            ]),
        child: Stack(
          fit: StackFit.loose,
          children: [
            Positioned(
                left: 5,
                top: 5,
                child: Container(
                  width: 100,
                  padding: EdgeInsets.all(15),
                  height: 70,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black.withOpacity(.09),
                            offset: Offset(1, 1))
                      ]),
                  child: Image.asset(
                    "assets/icons/mathlablogo.png",
                  ),
                )),
            Positioned(right: 40, bottom: 8, child: tx400("Exam", size: 10)),
            if (videoData[i]["access_type"] == 1)
              Positioned(
                  right: 20,
                  bottom: 10,
                  child: ((i == selectedIndex))
                      ? SvgPicture.asset("assets/icons/progess_icon.svg")
                      : Icon(
                          Icons.lock,
                          size: 15,
                          color: Colors.black.withOpacity(.8),
                        )),
            Positioned(
                top: 10,
                left: 110,
                right: 10,
                bottom: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      constraints: BoxConstraints(maxHeight: 45),
                      child: tx600(videoData[i]["exam_name"],
                          color: Colors.black, size: 14),
                    ),
                    // tx400("${videoData[i]["instruction"]}",
                    //     color: Colors.black, size: 12),
                  ],
                )),
          ],
        ),
      ),
    );
  }
}
