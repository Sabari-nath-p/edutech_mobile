import 'package:flutter/material.dart';

import 'Constants/sizer.dart';
import 'Constants/textstyle.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: [
            Container(
              padding: EdgeInsets.only(top: 20, bottom: 10),
              child: Row(
                children: [
                  width(20),
                  InkWell(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: Icon(Icons.arrow_back_ios_new)),
                  Expanded(
                      child: Container(
                          alignment: Alignment.center,
                          child: tx600("Notifications", size: 20))),
                  width(40)
                ],
              ),
            ),
            Expanded(
                child: Center(
              child: Padding(
                padding: const EdgeInsets.all(70.0),
                child: Image.asset("assets/image/no_notification.jpg"),
              ),
            )),
            height(50)
          ],
        ),
      ),
    );
  }
}
