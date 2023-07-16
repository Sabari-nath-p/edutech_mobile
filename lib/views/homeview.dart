import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:mathlab/Constants/sizer.dart';
import 'package:mathlab/Constants/textstyle.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  String name = '';

  loaddata() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      name = pref.getString("NAME").toString();
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loaddata();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          height(20),
          Row(
            children: [
              width(20),
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
              width(20),
            ],
          ),
          height(30),
          Container(
            width: MediaQuery.of(context).size.width,
            child: Row(
              children: [
                width(30),
                tx400("Hello, ${name.split(" ")[0]}", size: 20),
                Expanded(child: Container()),
                width(30)
              ],
            ),
          ),
          Container(
            alignment: Alignment.topLeft,
            margin: EdgeInsets.symmetric(horizontal: 30),
            child: tx500("Find Your Favorite Online Course",
                size: 20, color: Colors.black),
          ),
          height(10),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 30),
            height: 160,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: ImageSlideshow(children: [
                Image.network(
                  "https://static.vecteezy.com/system/resources/thumbnails/002/294/890/small/digital-education-web-banner-design-teacher-on-monitor-to-explain-the-graph-online-education-e-learning-digital-education-platform-concept-header-or-footer-banner-free-vector.jpg",
                  fit: BoxFit.cover,
                ),
                Image.network(
                  "https://th.bing.com/th/id/R.f7cbbf0e72470ebdb7df695a4438a544?rik=cGm9AJf%2bNwImaA&riu=http%3a%2f%2fwww.4qs.in%2fuploads%2f4qspvtltd%2fdigi_sig.png&ehk=AiLJeMjBsudIPf4qoolBK3KwjWXzrnkgtLyXVX7SpaE%3d&risl=&pid=ImgRaw&r=0",
                  fit: BoxFit.cover,
                )
              ]),
            ),
          ),
          //height(20),
          if (false)
            Container(
              margin: EdgeInsets.symmetric(horizontal: 30),
              child: tx700("Menu", size: 18, color: Colors.black),
            ),
          height(10),
          if (false)
            Container(
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.symmetric(horizontal: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      InkWell(
                        onTap: () {
                          /* Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => VideoPlayerScreen(
                                  chapterID: "1223",
                                  subjectID: "physics",
                                  courseID: "basicsmath",
                                )));*/
                          //    Navigator.of(context).push(MaterialPageRoute(
                          //      builder: (context) => chapterListScreen()));
                        },
                        child: Container(
                          height: 75,
                          width: 75,
                          padding: EdgeInsets.all(12),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Color(0xffBEFFD8)),
                          child: Image.network(
                              'https://cdn2.iconfinder.com/data/icons/university-set-5/512/15-256.png'),
                        ),
                      ),
                      tx400("Video", size: 13)
                    ],
                  ),
                  Column(
                    children: [
                      Container(
                        height: 75,
                        width: 75,
                        padding: EdgeInsets.all(12),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Color(0xffFFD0D0)),
                        child: Image.network(
                            'https://icon-library.com/images/icon-note/icon-note-22.jpg'),
                      ),
                      tx400("Note", size: 13)
                    ],
                  ),
                  Column(
                    children: [
                      Container(
                        height: 75,
                        width: 75,
                        padding: EdgeInsets.all(15),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Color(0xffD0D8FF)),
                        child: Image.network(
                            'https://pluspng.com/img-png/png-exam-education-exam-examination-grade-level-result-test-icon-512.png'),
                      ),
                      tx400("Exam", size: 13)
                    ],
                  ),
                  Column(
                    children: [
                      Container(
                        height: 75,
                        width: 75,
                        padding: EdgeInsets.all(12),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Color(0xffD0F4FF)),
                        child: Image.network(
                            'https://cdn2.iconfinder.com/data/icons/university-set-5/512/21-512.png'),
                      ),
                      tx400("Live", size: 13)
                    ],
                  )
                ],
              ),
            ),
          height(20),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 30),
            child: tx700("Popular Courses", size: 18, color: Colors.black),
          ),
          height(10),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                width(30),
                for (int i = 0; i < 2; i++)
                  Container(
                      width: 155,
                      height: 167,
                      margin: EdgeInsets.symmetric(horizontal: 8),
                      child: Image.asset("assets/temp/temp1.png")),
              ],
            ),
          )
        ],
      ),
    );
  }
}
