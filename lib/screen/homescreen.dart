import 'package:bottom_bar/bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mathlab/Constants/colors.dart';
import 'package:mathlab/views/homeview.dart';
import 'package:mathlab/views/profile.dart';
import 'package:mathlab/views/subjectlist.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentPage = 0;
  final _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: PageView(
        controller: _pageController,
        children: [HomeView(), SubjectListView(), Container(), profileView()],
        onPageChanged: (index) {
          // Use a better state management solution
          // setState is used for simplicity
          setState(() => _currentPage = index);
        },
      ),
      bottomNavigationBar: BottomBar(
        selectedIndex: _currentPage,
        onTap: (int index) {
          _pageController.jumpToPage(index);
          setState(() => _currentPage = index);
        },
        items: <BottomBarItem>[
          BottomBarItem(
            icon: SvgPicture.asset("assets/icons/home.svg"),
            title: Text('Home'),
            activeColor: primaryColor,
          ),
          BottomBarItem(
            icon: SvgPicture.asset("assets/icons/class.svg"),
            title: Text('Classes'),
            activeColor: primaryColor,
          ),
          BottomBarItem(
            icon: Icon(Icons.person),
            title: Text('Account'),
            activeColor: Colors.greenAccent.shade700,
          ),
          BottomBarItem(
            icon: SvgPicture.asset("assets/icons/profile.svg"),
            title: Text('Profile'),
            activeColor: primaryColor,
          ),
        ],
      ),
    ));
  }
}
