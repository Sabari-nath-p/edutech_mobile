import 'dart:convert';
import 'dart:io';

import 'package:flutter/services.dart';
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
    print(videoID);
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
    controller.dispose();
    super.dispose();
  }

  loadVideoList() async {
    print("working");
    print(
        "$baseurl/baseurl/applicationview/courses/${widget.courseID}/subjects/${widget.subjectID}/modules/${widget.chapterID}/videos/");
    final videoResponse = await http.get(Uri.parse(
        "$baseurl/applicationview/courses/${widget.courseID}/subjects/${widget.subjectID}/modules/${widget.chapterID}/videos/"));
    print(videoResponse.statusCode);
    if (videoResponse.statusCode == 200) {
      var js = json.decode(videoResponse.body);
      setState(() {
        videoData.addAll(js);
        loadSorting();
      });
    }
  }

  loadNoteList() async {
    final noteResponse = await http.get(Uri.parse(
        "$baseurl/applicationview/courses/${widget.courseID}/subjects/${widget.subjectID}/modules/${widget.chapterID}/notes/"));

    if (noteResponse.statusCode == 200) {
      var js = json.decode(noteResponse.body);
      setState(() {
        videoData.addAll(js);
        loadSorting();
      });
    }
  }

  loadExamlist() async {
    final examResponse = await http.get(Uri.parse(
        "$baseurl/applicationview/courses/${widget.courseID}/subjects/${widget.subjectID}/modules/${widget.chapterID}/exams"));

    if (examResponse.statusCode == 200) {
      var js = json.decode(examResponse.body);
      setState(() {
        videoData.addAll(js);
        loadSorting();
      });
    }
  }

  loadSorting() {
    setState(() {
      videoData.sort((a, b) => a['created_date'].compareTo(b['created_date']));
    });
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
                        ExamListCard(i),
                  height(20)
                ],
              ),
            ),
          ),
        ],
      ),
    ));
  }

  videoListCard(int i) {
    return InkWell(
      onTap: () {
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
        child: Stack(
          fit: StackFit.loose,
          children: [
            Positioned(
                left: 20,
                top: 25,
                child: ((i == selectedIndex))
                    ? SvgPicture.asset("assets/icons/progess_icon.svg")
                    : SvgPicture.asset(
                        "assets/icons/video.svg",
                        color: Colors.black.withOpacity(.8),
                      )),
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
                top: 10,
                left: 60,
                right: 10,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      constraints: BoxConstraints(maxHeight: 45),
                      child: tx600(videoData[i]["title"],
                          color: Colors.black, size: 14),
                    ),
                    tx400("${videoData[i]["description"]}",
                        color: Colors.black, size: 12),
                  ],
                )),
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
                left: 20,
                top: 30,
                child: SvgPicture.asset(
                  "assets/icons/class.svg",
                  color: Colors.black.withOpacity(.7),
                )),
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
                left: 60,
                right: 10,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      constraints: BoxConstraints(maxHeight: 45),
                      child: tx600(videoData[i]["title"],
                          color: Colors.black, size: 14),
                    ),
                    tx400("Contents :  ${videoData[i]["description"]}",
                        color: Colors.black, size: 12),
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
        if (data == null) {
          if (videoData[i]["access_type"] == 2 ||
              checkCourseActive(int.parse(widget.courseID))) {
            if (isvideoLoaded) controller.pause();
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => ExamStart(
                      examid: videoData[i]["exam_unique_id"].toString(),
                      courseid: widget.courseID,
                      subjectid: widget.subjectID,
                      moduleid: widget.chapterID,
                    )));
          } else {
            Fluttertoast.showToast(
                msg: "Prime leature , only avilable to Enrolled user");
          }
        } else {
          ExamData examData = ExamData();
          examData.id = int.parse(data["exam_id"]);
          // examData.fetchAnswer(data["response"]);

          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) =>
                  ExamAnswerValidation(examData: examData, data: data)));
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
                left: 20,
                top: 25,
                child: SvgPicture.asset(
                  "assets/icons/exam.svg",
                  color: Colors.black,
                )),
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
                left: 60,
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
                    tx400("${videoData[i]["instruction"]}",
                        color: Colors.black, size: 12),
                  ],
                )),
          ],
        ),
      ),
    );
  }
}
