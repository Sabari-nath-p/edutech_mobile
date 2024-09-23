import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:mathlab/Constants/sizer.dart';
import 'package:mathlab/Constants/textstyle.dart';
import 'package:mathlab/Constants/urls.dart';
import 'package:pinput/pinput.dart';

class ForgotPasswordScreen extends StatefulWidget {
  ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  int Stage = 0;
  bool loading = false;
  TextEditingController emailController = TextEditingController();
  TextEditingController otpController = TextEditingController();
  TextEditingController passworController = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();

  String validationID = "";
  sendOtp() async {
    setState(() {
      loading = true;
    });
    final Response = await post(Uri.parse(baseurl + "/users/otp-request/"),
        body: {"email": emailController.text.trim()});
    setState(() {
      loading = false;
    });
    if (Response.statusCode == 200) {
      validationID = jsonDecode(Response.body)["validation_id"];

      Fluttertoast.showToast(
          msg: "Otp has been send successfully to the email");
      Stage = 1;
    } else {
      Fluttertoast.showToast(msg: "OTP sending failed");
    }
  }

  verifyOtp() async {
    setState(() {
      loading = true;
    });
    final Response =
        await post(Uri.parse(baseurl + "/users/check-otp/"), body: {
      "email": emailController.text.trim(),
      "otp": otpController.text.trim(),
      "validation_id": validationID
    });
    setState(() {
      loading = false;
    });
    if (Response.statusCode == 200) {
      // validationID = jsonDecode(Response.body)["validation_id"];

      Fluttertoast.showToast(msg: "OTP verification successfully completed");
      Stage = 2;
    } else {
      Fluttertoast.showToast(msg: "Invalid OTP");
    }
  }

  ResetPassword() async {
    setState(() {
      loading = true;
    });
    final Response =
        await post(Uri.parse(baseurl + "/users/reset-password/"), body: {
      "email": emailController.text.trim(),
      "otp": otpController.text.trim(),
      "password": passworController.text,
      "confirm_password": confirmPassword.text,
      "validation_id": validationID
    });
    setState(() {
      loading = false;
    });

    print(Response.body);
    print(Response.statusCode);
    if (Response.statusCode == 200) {
      // validationID = jsonDecode(Response.body)["validation_id"];

      Fluttertoast.showToast(msg: "Password Has bee reset");
      Navigator.pop(context);
      Stage = 2;
    } else {
      var data = json.decode(Response.body);
      if (data == "Unauthorised User. Can't Reset Password") {
        Fluttertoast.showToast(msg: "Incorrect OTP");
      } else if (data["password"] != null) {
        Fluttertoast.showToast(msg: data["password"].toString());
      } else
        Fluttertoast.showToast(msg: "Something went wrong");
      Stage = 2;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
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
                          child: tx600("Forgot Password", size: 20))),
                  width(40)
                ],
              ),
            ),
            Expanded(
                child: SingleChildScrollView(
              child: Column(
                children: [
                  _buildTextField(
                      labelText: "Email ID",
                      hintText: "Enter email id",
                      controller: emailController,
                      enabled: (Stage == 0)),
                  if (Stage == 0)
                    Padding(
                        padding: EdgeInsets.symmetric(horizontal: 30),
                        child: InkWell(
                          onTap: () {
                            if (emailController.text.isNotEmpty) {
                              sendOtp();
                            } else {
                              Fluttertoast.showToast(
                                  msg: "Please enter email id");
                            }
                          },
                          child: ButtonContainer(
                              (loading)
                                  ? LoadingAnimationWidget.staggeredDotsWave(
                                      color: Colors.white, size: 24)
                                  : tx600("Send OTP", color: Colors.white),
                              radius: 10),
                        )),
                  if (Stage > 0) SizedBox(height: 10),
                  if (Stage > 0)
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 30),
                        child: Text(
                          "Enter OTP",
                          // style: GoogleFonts.inter(fontSize: 16.sp, fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                  //SizedBox(height: 8),
                  if (Stage > 0)
                    Container(
                      // width: 300,
                      height: 90,
                      margin: EdgeInsets.symmetric(horizontal: (30)),
                      child: Pinput(
                        controller: otpController,
                        enabled: Stage == 1,
                        length: 6,
                        // :
                        //     AndroidSmsAutofillMethod.smsUserConsentApi,
                        defaultPinTheme: PinTheme(
                            width: (45),
                            height: (45),
                            textStyle: TextStyle(
                                //  color: Colors.white,
                                fontWeight: FontWeight.w600,
                                fontSize: 18),
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: Color.fromARGB(255, 186, 186, 186)),
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10))),
                      ),
                    ),
                  if (Stage == 1)
                    Padding(
                        padding: EdgeInsets.symmetric(horizontal: 30),
                        child: InkWell(
                          onTap: () {
                            if (otpController.text.isNotEmpty) {
                              verifyOtp();
                            } else {
                              Fluttertoast.showToast(msg: "Please enter otp");
                            }
                          },
                          child: ButtonContainer(
                              (loading)
                                  ? LoadingAnimationWidget.staggeredDotsWave(
                                      color: Colors.white, size: 24)
                                  : tx600("Verify OTP", color: Colors.white),
                              radius: 10),
                        )),

                  if (Stage == 2)
                    _buildTextField(
                        labelText: "Password",
                        hintText: "Enter new password",
                        controller: passworController,
                        obscure: true),
                  if (Stage == 2)
                    _buildTextField(
                        labelText: "Confirm Password",
                        hintText: "Enter confirm password",
                        controller: confirmPassword,
                        obscure: true),
                  if (Stage == 2)
                    Padding(
                        padding: EdgeInsets.symmetric(horizontal: 30),
                        child: InkWell(
                          onTap: () {
                            if (passworController.text.isNotEmpty &&
                                confirmPassword.text.isNotEmpty &&
                                confirmPassword.text ==
                                    passworController.text) {
                              ResetPassword();
                            } else if (confirmPassword.text !=
                                passworController.text) {
                              Fluttertoast.showToast(
                                  msg:
                                      "New password and confirm password are mismatch");
                            } else {
                              Fluttertoast.showToast(
                                  msg: "Please enter password");
                            }
                          },
                          child: ButtonContainer(
                              (loading)
                                  ? LoadingAnimationWidget.staggeredDotsWave(
                                      color: Colors.white, size: 24)
                                  : tx600("Reset Password",
                                      color: Colors.white),
                              radius: 10),
                        )),
                ],
              ),
            ))
          ],
        ),
      )),
    );
  }
}

Widget _buildTextField({
  required String labelText,
  required String hintText,
  TextEditingController? controller,
  bool enabled = true,
  bool obscure = false,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      SizedBox(height: 8),
      Text(
        labelText,
        // style: GoogleFonts.inter(fontSize: 16.sp, fontWeight: FontWeight.w500),
      ),
      SizedBox(height: 8),
      Container(
        height: 48,
        width: 327,
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 222, 222, 222),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: const Color.fromRGBO(242, 244, 245, 1)),
        ),
        child: TextField(
          controller: controller,
          enabled: enabled,
          obscureText: obscure,
          decoration: InputDecoration(
            border: InputBorder.none,
            fillColor: Colors.black12,
            contentPadding: EdgeInsets.symmetric(horizontal: 18),
            hintText: hintText,
            hintStyle: TextStyle(
              color: Colors.grey[600],
              fontSize: 14,
            ),
          ),
          style: TextStyle(
            color: const Color.fromRGBO(27, 27, 27, 1),
            fontSize: 16,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
      SizedBox(height: 16),
    ],
  );
}
