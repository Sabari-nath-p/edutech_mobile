import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mathlab/Constants/colors.dart';
import 'package:mathlab/Constants/sizer.dart';
import 'package:mathlab/Constants/textstyle.dart';
import 'package:mathlab/screen/exam/examstart.dart';
import 'package:mathlab/screen/noteScreen.dart';
import 'package:pod_player/pod_player.dart';

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
    loadVideoList();

    super.initState();
  }

  loadVideo(String videoID) async {
    controller = PodPlayerController(
      playVideoFrom: PlayVideoFrom.vimeo(videoID),
    )..initialise();
    controller.play();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  loadVideoList() {
    print("working");
    FirebaseFirestore db = FirebaseFirestore.instance;
    db
        .collection("course")
        .doc(widget.courseID)
        .collection("subjects")
        .doc(widget.subjectID)
        .collection("contents")
        .where("chapter", isEqualTo: widget.chapterID)
        .get()
        .then((value) {
      print(value.docs);
      for (var data in value.docs) {
        setState(() {
          videoData.add(data.data());
        });
      }
    }).onError((error, stackTrace) {
      print(error);
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
                height: 215, child: PodVideoPlayer(controller: controller)),
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
                  tx400("Leature by : ${videoData[selectedIndex]["lecturer"]}",
                      color: Colors.black, size: 12),
                ],
              ),
            ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  for (int i = 0; i < videoData.length; i++)
                    if (videoData[i]["content_type"] == "video")
                      videoListCard(i)
                    else if ((videoData[i]["content_type"] == "note"))
                      noteListCard(i)
                    else if ((videoData[i]["content_type"] == "exam"))
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
        if (videoData[i]["access_type"] == "free") {
          setState(() {
            if (!isvideoLoaded)
              loadVideo(videoData[i]["video_id"]);
            else {
              controller.changeVideo(
                  playVideoFrom: PlayVideoFrom.vimeo(videoData[i]["video_id"]));
            }
            isvideoLoaded = true;
            selectedIndex = i;
          });
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
            if (videoData[i]["access_type"] == "paid")
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
                    tx400("Lecture by :  ${videoData[i]["lecturer"]}",
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
        if (videoData[i]["access_type"] == "free") {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) =>
                  noteScreen(notelink: videoData[i]["pdf_link"])));
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
            if (videoData[i]["access_type"] == "paid")
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
                    tx400("Contents :  ${videoData[i]["contents"]}",
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
      onTap: () {
        if (videoData[i]["access_type"] == "free") {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => ExamStart()));
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
                child: SvgPicture.asset(
                  "assets/icons/exam.svg",
                  color: Colors.black,
                )),
            if (videoData[i]["access_type"] == "paid")
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
                    tx400("${videoData[i]["description"]}",
                        color: Colors.black, size: 12),
                  ],
                )),
          ],
        ),
      ),
    );
  }
}
