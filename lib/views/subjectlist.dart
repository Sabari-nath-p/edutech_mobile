import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:mathlab/Constants/sizer.dart';
import 'package:mathlab/Constants/textstyle.dart';
import 'package:mathlab/screen/chapterlist.dart';

List subjects = [];

class SubjectListView extends StatefulWidget {
  const SubjectListView({super.key});

  @override
  State<SubjectListView> createState() => _SubjectListViewState();
}

class _SubjectListViewState extends State<SubjectListView> {
  loadSubjects() {
    FirebaseFirestore db = FirebaseFirestore.instance;
    db
        .collection("course")
        .doc("plusone")
        .collection("subjects")
        .get()
        .then((value) {
      for (var data in value.docs) {
        print(data.id);
        setState(() {
          subjects.add(data);
        });
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (subjects.isEmpty) loadSubjects();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            body: Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
                color: Colors.white,
                // border: Border(
                //   bottom: BorderSide(color: Colors.grey.withOpacity(.7))),
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20))),
            padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    SizedBox(
                      width: 140,
                      height: 60,
                      child: Image.asset("assets/icons/mathlablogo.png"),
                    ),
                    Expanded(child: Container()),
                    CircleAvatar(
                      radius: 25,
                      child: Image.network(
                          "https://www.clipartkey.com/mpngs/m/208-2089363_user-profile-image-png.png"),
                    ),
                  ],
                ),
                height(10),
                tx700("Select \nSubjects", color: Colors.black, size: 25),
              ],
            ),
          ),
          Expanded(
              child: SingleChildScrollView(
            child: Column(
              children: [
                height(20),
                for (var data in subjects)
                  InkWell(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => chapterListScreen(
                                subjectId: data.id,
                                data: data.data(),
                              )));
                    },
                    child: subjectCard(data.data()),
                  )
              ],
            ),
          ))
        ],
      ),
    )));
  }

  subjectCard(var data) {
    return Container(
      height: 80,
      padding: EdgeInsets.all(5),
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 4),
      decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.withOpacity(.4)),
          borderRadius: BorderRadius.circular(20)),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(20)),
        child: Row(
          children: [
            Container(
              width: 65,
              margin: EdgeInsets.all(5),
              decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(.09),
                  borderRadius: BorderRadius.circular(15)),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image.network(
                  "${data["thumbnail"]}",
                  fit: BoxFit.cover,
                ),
              ),
            ),
            width(6),
            Expanded(
                child: tx600("${data["name"]}", color: Colors.black, size: 17)),
            Container(
              width: 65,
              margin: EdgeInsets.all(5),
              decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(.09),
                  borderRadius: BorderRadius.circular(10)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  tx700("${data["chapters"]}", size: 17, color: Colors.black),
                  tx700("Chapters", size: 8, color: Colors.black),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
