import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mathlab/Constants/sizer.dart';
import 'package:mathlab/Constants/textstyle.dart';

class enrolledCourse extends StatefulWidget {
  const enrolledCourse({super.key});

  @override
  State<enrolledCourse> createState() => _enrolledCourseState();
}

class _enrolledCourseState extends State<enrolledCourse> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            //  height(20),
            Container(
              padding: EdgeInsets.only(top: 20, bottom: 10),
              color: Colors.white,
              child: Row(
                children: [
                  width(20),
                  InkWell(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: SizedBox(
                      width: 40,
                      height: 40,
                      child: CircleAvatar(
                          backgroundColor: Colors.grey.withOpacity(.1),
                          radius: 10,
                          child: Icon(
                            Icons.arrow_back_ios_new,
                            color: Colors.black,
                          )),
                    ),
                  ),
                  width(20),
                  tx700("Enrolled Course", size: 20),
                  //Icon(Icons.arrow_back_ios_new_outlined)
                ],
              ),
            ),

            for (int i = 0; i < 3; i++)
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20, vertical: 3),
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10)),
                child: Row(
                  children: [
                    SvgPicture.asset(
                      "assets/icons/class.svg",
                      color: Colors.grey,
                    ),
                    width(10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        tx600("Full Stack Development",
                            size: 15, color: Colors.black),
                        tx400("Validity : 21-June-2024 ",
                            size: 12, color: Colors.black),
                      ],
                    )
                  ],
                ),
              )
          ],
        ),
      ),
    );
  }
}
