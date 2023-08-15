import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mathlab/Constants/urls.dart';
import 'package:mathlab/screen/course_overview.dart';
import 'package:http/http.dart' as http;

class PopularCourse extends StatefulWidget {
  int id;
  PopularCourse({super.key, required this.id});

  @override
  State<PopularCourse> createState() => _PopularCourseState();
}

class _PopularCourseState extends State<PopularCourse> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    loadCourse();
  }

  String ImageUrl =
      "https://th.bing.com/th/id/OIP.T173YISP_ZxI1btAPB2zbAAAAA?pid=ImgDet&w=421&h=421&rs=1";
  loadCourse() async {
    print("popular cours");
    final response = await http
        .get(Uri.parse("$baseurl/applicationview/courses/${widget.id}/"));
    print(response.body);
    if (response.statusCode == 200) {
      print(response.body);

      data = json.decode(response.body);
      print(data["cover_image"]);
      setState(() {
        if (data["cover_image"] != null) {
          ImageUrl = data["cover_image"].toString();
        }
      });
    }
  }

  var data;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => CourseOverView(
                  courseData: data["course_unique_id"].toString(),
                )));
      },
      child: Container(
        width: 155,
        height: 167,
        margin: EdgeInsets.symmetric(horizontal: 8),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Image.network(ImageUrl),
        ),
      ),
    );
  }
}
