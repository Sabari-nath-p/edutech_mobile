import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:mathlab/Constants/colors.dart';
import 'package:mathlab/Constants/sizer.dart';
import 'package:mathlab/Constants/urls.dart';
import 'package:mathlab/development.dart';
import 'package:mathlab/views/courselist.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tex_text/tex_text.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import '../Constants/textstyle.dart';

class CourseOverView extends StatefulWidget {
  String courseData;
  CourseOverView({super.key, required this.courseData});

  @override
  State<CourseOverView> createState() => _CourseOverViewState();
}

class _CourseOverViewState extends State<CourseOverView> {
  var CourseData;
  // _CourseOverViewState({required this.CourseData});

  loadCourse() async {
    print(widget.courseData);
    final Response = await http.get(
        Uri.parse("$baseurl/applicationview/courses/${widget.courseData}/"));
    print(Response.body);
    if (Response.statusCode == 200) {
      var js = json.decode(Response.body);
      setState(() {
        CourseData = js;
        isLoading = false;
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadCourse();
    print(widget.courseData);
  }

  bool isLoading = true;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xff26202C),
        body: (isLoading)
            ? Container(
                width: double.infinity,
                height: double.infinity,
                color: Colors.white,
                child:
                    LoadingAnimationWidget.beat(color: primaryColor, size: 40))
            : Column(
                children: [
                  height(10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      width(20),
                      InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: SizedBox(
                            height: 60,
                            child: Icon(
                              Icons.arrow_back_ios_rounded,
                              color: Colors.white,
                            )
                            //Image.asset("assets/icons/mathlablogo.png"),
                            ),
                      ),
                      Expanded(
                          child: Container(
                        alignment: Alignment.center,
                        child: tx500("Course Overview",
                            color: Colors.white.withOpacity(.8), size: 18),
                      )),
                      SizedBox(
                          height: 60,
                          child: Icon(
                            Icons.share,
                            color: Colors.white,
                          )
                          //Image.asset("assets/icons/mathlablogo.png"),
                          ),
                      width(20),
                    ],
                  ),
                  Container(
                    height: 140,
                    width: 390,
                    child: Stack(
                      children: [
                        Positioned(
                            left: 30,
                            top: 20,
                            width: 280,
                            bottom: 10,
                            child: tx700(CourseData["field_of_study"],
                                size: 24, color: Colors.white)),
                        if (false)
                          Positioned(
                              top: 20,
                              right: 30,
                              width: 100,
                              child: Image.network(
                                  "https://cdn2.iconfinder.com/data/icons/data-organization-and-management-7/64/vector_525_17-512.png"))
                      ],
                    ),
                  ),
                  Expanded(
                    child: Stack(
                      children: [
                        Positioned(
                          top: 0,
                          left: 0,
                          right: 0,
                          bottom: 0,
                          child: Container(
                            //  height: 614,
                            //   width: 390,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(
                                      40,
                                    ),
                                    topRight: Radius.circular(40)),
                                color: Colors.white),
                            child: SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  height(10),
                                  Container(
                                    alignment: Alignment.center,
                                    child: Container(
                                      width: 120,
                                      height: 5,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          color: Colors.grey),
                                    ),
                                  ),
                                  height(20),
                                  Container(
                                      margin:
                                          EdgeInsets.only(left: 20, bottom: 10),
                                      child: tx700("Description :-",
                                          color: Colors.black, size: 18)),
                                  Container(
                                    margin:
                                        EdgeInsets.symmetric(horizontal: 20),
                                    padding: EdgeInsets.all(1),
                                    child: Text(
                                      "${CourseData["Course_description"]}",
                                      textAlign: TextAlign.justify,
                                      style: TextStyle(
                                          fontSize: 13,
                                          color: Colors.black,
                                          fontFamily: "Poppins"),
                                    ),
                                  ),
                                  height(20),
                                  Container(
                                      margin: EdgeInsets.only(left: 20),
                                      child: tx700("Course Benefit ",
                                          color: Colors.black, size: 18)),
                                  Container(
                                    margin: EdgeInsets.only(left: 20),
                                    child: Wrap(
                                      children: [
                                        for (var Data
                                            in CourseData["user_benefit"]
                                                .toString()
                                                .split(","))
                                          Container(
                                            margin: EdgeInsets.all(3),
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 12, vertical: 8),
                                            decoration: BoxDecoration(
                                                color:
                                                    Colors.grey.withOpacity(.2),
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                            child: tx400(Data, size: 12),
                                          )
                                      ],
                                    ),
                                  ),
                                  height(20),
                                  Container(
                                      margin: EdgeInsets.only(left: 20),
                                      child: tx700("This Course Includes :",
                                          color: Colors.black, size: 18)),
                                  Container(
                                    margin: EdgeInsets.only(left: 20),
                                    child: Wrap(
                                      children: [
                                        for (var Data in CourseData["subjects"])
                                          Container(
                                            margin: EdgeInsets.all(3),
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 12, vertical: 8),
                                            decoration: BoxDecoration(
                                                color:
                                                    Colors.grey.withOpacity(.2),
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                            child: tx400(
                                                Data.toString().split(":")[1],
                                                size: 12),
                                          )
                                      ],
                                    ),
                                  ),
                                  height(80)
                                ],
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                            bottom: 10,
                            left: 20,
                            right: 20,
                            child: InkWell(
                              onTap: () async {
                                SharedPreferences pref =
                                    await SharedPreferences.getInstance();
                                String name = pref.getString("NAME").toString();
                                String email =
                                    pref.getString("EMAIL").toString();
                                launchUrl(
                                    Uri.parse(
                                        "https://wa.me/918281441545?text=I'm%20$name%20interested%20to%20purchase%20${CourseData["field_of_study"]}%20course\n\n\my%20ID%20is%20$email"),
                                    mode: LaunchMode.externalApplication);
                              },
                              child: ButtonContainer(
                                  (isloading)
                                      ? LoadingAnimationWidget
                                          .staggeredDotsWave(
                                              color: Colors.white, size: 30)
                                      : tx700("Buy ${CourseData["price"]} /-",
                                          color: Colors.white),
                                  color: Color(0xff26202C),
                                  radius: 12,
                                  height: 50),
                            ))
                      ],
                    ),
                  )
                ],
              ),
      ),
    );
  }

  bool isloading = false;
  Future<void> createPaymentIntent(int price) async {
    final url = Uri.parse('https://api.stripe.com/v1/payment_intents');
    final secretKey =
        'sk_test_51NE9LVSDCM0Xaplj0DR0MyIpoLzmugLbDQGuuNYtIoSdqMYVWOmiWPgG0PIAUDsbBjJVEQvSbQa6TU6kajeigIwg005qYvK4LX';

    try {
      final response = await http.post(
        url,
        headers: {
          'Authorization': 'Basic ${base64Encode(utf8.encode('$secretKey:'))}',
        },
        body: {
          'amount': (price * 100).toString(),
          'currency': 'inr',
          'payment_method': 'pm_card_visa',
        },
      );

      if (response.statusCode == 200) {
        // Request succeeded, handle the response here.
        print('Payment Intent Created: ${response.body}');
        var js = json.decode(response.body);
        String clientID = js["client_secret"];
        proceedpayment(clientID);
      } else {
        // Handle the error if the server returns a non-200 status code.
        setState(() {
          isloading = false;
        });
        print(
            'Failed to create payment intent. Status code: ${response.statusCode}');
      }
    } catch (error) {
      // Handle any network or other errors that may occur during the request.
      print('Error creating payment intent: $error');
    }
  }

  proceedpayment(String clientID) async {
    try {
      var gpay = const PaymentSheetGooglePay(
        merchantCountryCode: "IN",
        currencyCode: "IND",
      );

      await Stripe.instance.initPaymentSheet(
          paymentSheetParameters: SetupPaymentSheetParameters(
        paymentIntentClientSecret: clientID,
        style: ThemeMode.light,
        merchantDisplayName: "Sabarinath",
        googlePay: gpay,
      ));

      displayPaymentSheet();
    } catch (e) {
      print(e.toString());
      setState(() {
        isloading = false;
      });
    }
  }

  void displayPaymentSheet() async {
    try {
      await Stripe.instance.presentPaymentSheet();
      print("Done");
      Fluttertoast.showToast(msg: "Payment Sucessfull");

      setState(() {
        isloading = false;
      });
    } catch (e) {
      setState(() {
        isloading = false;
      });
      print(e);
      print("Failed");
    }
  }
}
