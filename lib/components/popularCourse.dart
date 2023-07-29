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

  loadCourse() async {
    final response = await http
        .get(Uri.parse("$baseurl/applicationview/course/${widget.id}"));

    if (response.statusCode == 200) {
      print(response.body);
    }
  }

  @override
  Widget build(BuildContext context) {
    return (true)
        ? Container()
        : InkWell(
            /* onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => CourseOverView(
                  courseData: data,
                )));
      },*/
            child: Container(
                width: 155,
                height: 167,
                margin: EdgeInsets.symmetric(horizontal: 8),
                child: Image.asset("assets/temp/temp1.png")),
          );
  }
}
