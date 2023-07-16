import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mathlab/Constants/colors.dart';
import 'package:mathlab/Constants/sizer.dart';
import 'package:mathlab/Constants/textstyle.dart';
import 'package:mathlab/screen/homescreen.dart';
import 'package:mathlab/screen/videoplayer.dart';
import 'package:shared_preferences/shared_preferences.dart';

class chapterListScreen extends StatefulWidget {
  String subjectId;
  var data;
  chapterListScreen({super.key, required this.subjectId, required this.data});

  @override
  State<chapterListScreen> createState() => _chapterListScreenState();
}

class _chapterListScreenState extends State<chapterListScreen> {
  List chapters = [];

  loadChapters() {
    FirebaseFirestore db = FirebaseFirestore.instance;
    db
        .collection("course")
        .doc("plusone")
        .collection("subjects")
        .doc(widget.subjectId)
        .collection("chapter")
        .get()
        .then((value) {
      for (var data in value.docs) {
        setState(() {
          chapters.add(data);
        });
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
    loadChapters();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Container(
        //margin: EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 100,
              padding: EdgeInsets.symmetric(horizontal: 30),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(70)),
                  color: primaryColor.withOpacity(.9)),
              child: Row(
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: CircleAvatar(
                        backgroundColor: Colors.white.withOpacity(.1),
                        child: Icon(
                          Icons.arrow_back_ios_new,
                          color: Colors.white,
                        )),
                  ),
                  width(8),
                  tx700("${widget.data["name"]}", size: 25, color: Colors.white)
                ],
              ),
            ),
            Expanded(
                child: SingleChildScrollView(
              child: Container(
                margin: EdgeInsets.only(left: 15, right: 50),
                child: Column(
                  children: [
                    height(20),
                    for (var data in chapters)
                      InkWell(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => VideoPlayerScreen(
                                chapterID: data.id,
                                subjectID: widget.subjectId,
                                courseID: "plusone"),
                          ));
                        },
                        child: chapterCard(data.data()),
                      )
                  ],
                ),
              ),
            ))
          ],
        ),
      ),
    ));
  }

  chapterCard(var data) {
    return Container(
      height: 50,
      margin: EdgeInsets.symmetric(vertical: 3),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        // border: Border.all(color: primaryColor)
      ),
      child: Row(
        children: [
          width(10),
          Container(
            width: 35,
            height: 35,
            alignment: Alignment.center,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.grey.withOpacity(.2)),
            child: tx700(data["chapter_no"], color: Colors.black54, size: 18),
          ),
          width(10),
          Expanded(child: tx500(data["name"], size: 15, color: Colors.black)),
          Icon(
            Icons.play_arrow,
            color: primaryColor,
            size: 30,
          ),
          width(10)
        ],
      ),
    );
  }
}
