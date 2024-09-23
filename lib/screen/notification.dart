import 'package:engagespot_sdk/engagespot_sdk.dart';
import 'package:engagespot_sdk/models/Notifications.dart';
import 'package:flutter/material.dart';
import 'package:lit_relative_date_time/controller/relative_date_format.dart';
import 'package:lit_relative_date_time/model/relative_date_time.dart';

import '../Constants/sizer.dart';
import '../Constants/textstyle.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  String GetRelativeTime(String time, BuildContext context) {
    //RelativeTime(context).format(DateTime.parse(time));

    String rtime = "";
    if (time != "null") {
      RelativeDateTime _relativeDateTime = RelativeDateTime(
          dateTime: DateTime.now(), other: DateTime.parse(time));
      RelativeDateFormat _relativeDateFormatter = RelativeDateFormat(
        Localizations.localeOf(context),
      );
      rtime = _relativeDateFormatter.format(_relativeDateTime);
    }
    return time == "null" ? "" : rtime;
  }

  NotificationSet? notifications;
  loadNotification() async {
    //print("Notifications");
    notifications = await Engagespot.getNotifications();
    Engagespot.markAsRead();
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadNotification();
  }

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
                child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: SingleChildScrollView(
                  child: Column(
                children: [
                  if (notifications == null ||
                      notifications!.notificationMessage!.length == 0)
                    Container(
                      height: 50 * 8.5,
                      alignment: Alignment.center,
                      child: Text(
                        "No Notification",
                        style: TextStyle(
                            fontFamily: "Poppins",
                            fontSize: 15,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  if (notifications != null)
                    for (var data in notifications!.notificationMessage!)
                      Container(
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border(
                                bottom: BorderSide(
                                    color: Color(0xff919EAB).withOpacity(.2)))),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                SizedBox(
                                  width: 5 * 3.8,
                                ),
                                SizedBox(
                                  width: 9.55 * 3.8,
                                  height: 9.55 * 3.8,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child:
                                        (data.icon != null && data.icon != "")
                                            ? Image.network(
                                                data.icon!,
                                                fit: BoxFit.cover,
                                              )
                                            : Image.asset(
                                                "assets/icons/notification_pp.png",
                                                fit: BoxFit.cover,
                                              ),
                                  ),
                                ),
                                SizedBox(
                                  width: 13,
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        height: 8.5,
                                      ),
                                      RichText(
                                        text: new TextSpan(
                                          text: data.title,
                                          style: TextStyle(
                                              fontFamily: "Poppins",
                                              fontWeight: FontWeight.w600,
                                              color: Colors.black,
                                              fontSize: 11),
                                          children: <TextSpan>[
                                            TextSpan(
                                              text: " " + data.message!,
                                              style: TextStyle(
                                                  fontFamily: "Poppins",
                                                  fontWeight: FontWeight.w400,
                                                  color: Colors.black,
                                                  fontSize: 11),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: 3.8,
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        children: [
                                          SizedBox(
                                              width: 13,
                                              child: Icon(
                                                Icons.alarm,
                                                size: 14,
                                              )),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          Text(
                                            GetRelativeTime(
                                                data.createdAt.toString(),
                                                context),
                                            style: TextStyle(
                                                fontFamily: "Poppins",
                                                fontSize: 12,
                                                fontWeight: FontWeight.w400,
                                                color: Color(0xff555555)),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 4,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 5,
                            )
                          ],
                        ),
                      ),
                ],
              )),
            ))
            // Expanded(
            //     child: Center(
            //   child: Padding(
            //     padding: const EdgeInsets.all(70.0),
            //     child: Image.asset("assets/image/no_notification.jpg"),
            //   ),
            // )),
            //  height(50)
          ],
        ),
      ),
    );
  }
}
