import 'dart:async';
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:mathlab/Constants/colors.dart';
import 'package:mathlab/Constants/sizer.dart';
import 'package:mathlab/Constants/urls.dart';
import 'package:mathlab/development.dart';
import 'package:mathlab/main.dart';
import 'package:mathlab/views/courselist.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
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
    //print(widget.courseData);
    final Response = await http.get(
        Uri.parse("$baseurl/applicationview/courses/${widget.courseData}/"));
    //print(Response.body);
    if (Response.statusCode == 200) {
      var js = json.decode(Response.body);
      setState(() {
        CourseData = js;
        isLoading = false;
      });
    }
  }

  String razorpaykey = "";
  loadRazorpaykey() {
    print("working");
    FirebaseFirestore db = FirebaseFirestore.instance;
    db.collection("key").doc("razor_pay").get().then((value) {
      razorpaykey = value.get("api_key");
      setState(() {
        print(razorpaykey);
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadCourse();
    loadRazorpaykey();
    //print(widget.courseData);
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
                                // String name = pref.getString("NAME").toString();
                                String email =
                                    pref.getString("EMAIL").toString();
                                String phone =
                                    pref.getString("PHONE").toString();
                                // //print(token);
                                String token =
                                    pref.getString("TOKEN").toString();

                                Razorpay razorpay = Razorpay();
                                razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS,
                                    _handlePaymentSuccess);
                                razorpay.on(Razorpay.EVENT_PAYMENT_ERROR,
                                    _handlePaymentError);
                                razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET,
                                    _handleExternalWallet);

                                var url = Uri.parse(baseurl +
                                    '/applicationview/courses/buycourse/');
                                //print(CourseData);
                                var queryParameters = jsonEncode({
                                  'amount': double.parse(
                                          CourseData["price"].toString())
                                      .toInt(),
                                  'course_unique_id':
                                      CourseData["course_unique_id"],
                                  'duration':
                                      CourseData["Course_duration"] ?? 30,
                                });
                                //print(queryParameters);
                                showDialog(
                                    context: context,
                                    builder: (ctx) => Container(
                                          alignment: Alignment.center,
                                          child: LoadingAnimationWidget
                                              .discreteCircle(
                                                  color: primaryColor,
                                                  size: 25),
                                        ));

                                var response = await http
                                    .post(url, body: queryParameters, headers: {
                                  'Authorization': 'token $token',
                                  'Content-Type': 'application/json',
                                });

                                //print(response.statusCode);

                                if (response.statusCode == 200) {
                                  var orderData = json.decode(response.body);

                                  var options = {
                                    'key': razorpaykey,
                                    'order_id': orderData["order"]
                                        ["order_payment_id"],
                                    'name': CourseData["field_of_study"],
                                    'prefill': {
                                      'contact': phone,
                                      'email': email
                                    }
                                  };
                                  print(options);
                                  razorpay.open(options);
                                } else {
                                  Navigator.of(context).pop();
                                  Fluttertoast.showToast(
                                      msg: "Order failed, please contact as");
                                }
                              },
                              child: ButtonContainer(
                                  false
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

  void _handlePaymentSuccess(PaymentSuccessResponse response) async {
    // Do something when payment succeeds
    SharedPreferences pref = await SharedPreferences.getInstance();
    // String name = pref.getString("NAME").toString();
    //print(response);
    //print("Payment success");
    String token = pref.getString("TOKEN").toString();

    var url = Uri.parse(baseurl + '/applicationview/payment/success/');

    var queryParameters = jsonEncode({
      'razorpay_payment_id': response.paymentId,
      'razorpay_order_id': response.orderId,
      'razorpay_signature': response.signature
    });

    print(queryParameters);

    var result = await http.post(url, body: queryParameters, headers: {
      'Authorization': 'token $token',
      'Content-Type': 'application/json',
    });
    print(result.statusCode);
    print(result.body);
    if (result.statusCode == 202) {
      Fluttertoast.showToast(msg: "Course purchased successfully");
      await fetchUserProfile(pref);
      Navigator.of(context).pop();
      Navigator.of(context).pop();
    }

    // //print(result.statusCode);
    // //print(result.body);
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    Fluttertoast.showToast(
        msg: "Payment failed please try later.Or contact mathlab");
    Navigator.of(context).pop();
    // Do something when payment fails
    //print(response);
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    // Do something when an external wallet was selected
    //print(response);
  }
}




// jsonEncode({
//       'razorpay_payment_id': response.paymentId,
//       'razorpay_order_id': response.orderId,
//       'razorpay_signature': response.signature
//     })


// var headers = {
//       'Authorization': 'token $token',
//       "Content-Type": "application/json"
//     };
//     //print(baseurl + '/applicationview/payment/success/');
//     var request = http.MultipartRequest(
//         'POST', Uri.parse(baseurl + '/applicationview/payment/success/'));
//     request.fields.addAll();
//     request.headers.addAll(headers);
//     http.StreamedResponse Response = await request.send();
