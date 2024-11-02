import 'dart:convert';
import 'package:dio/dio.dart' as d;
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:http/http.dart';
import 'package:mathlab/Constants/urls.dart';
import 'package:mathlab/main.dart';
import 'package:mathlab/screen/SectionExam/Model/SQLModel.dart';
import 'package:mathlab/screen/SectionExam/Model/SectionExamModel.dart';
import 'package:mathlab/screen/SectionExam/Views/ResultViewScreen.dart';
import 'package:mathlab/screen/exam/models/questionMode.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:timer_count_down/timer_controller.dart';

class SectionExamController extends GetxController {
  SExamModel? examModel;
  late String cousreID;
  late String subjectID;
  late String moduleID;
  late String examID;
  int selectedSection = 0;
  int questionIndex = 0;
  SQLModel? currentQuestion;
  List<List<SQLModel>> questionList = [];
  List<String> section = [];
  List<String> sectionIDList = [];
  Duration? TimeDuration;
  double consumedTime = 0;

  var header = {
    "Authorization": "token $token",
    "Content-Type": "application/json",
  };

  fetchExam(
      {required String examUniqueID,
      required String mID,
      required String cID,
      required sID}) async {
    examID = examUniqueID;
    cousreID = cID;
    subjectID = sID;
    moduleID = mID;

    final Response = await get(
        Uri.parse(baseurl +
            "/applicationview/courses/${cousreID}/subjects/${subjectID}/modules/${moduleID}/exams/${examID}"),
        headers: header);
    print(Response.body);
    print(
        "$baseurl/applicationview/courses/${cousreID}/subjects/${subjectID}/modules/${moduleID}/exams/${examID}");
    if (Response.statusCode == 200) {
      examModel = SExamModel.fromJson(json.decode(Response.body));
      List<String> ttem = examModel!.durationOfExam!.split(":");
      TimeDuration = Duration(
          hours: int.parse(ttem[0]),
          minutes: int.parse(ttem[1]),
          seconds: int.parse(ttem[2]));
      for (var data in examModel!.sections!) {
        section.add(data.sectionName!);
        List<SQLModel> temp = [];
        for (Multiplechoice dt in data.multiplechoice!) {
          temp.add(SQLModel(
              questionType: "multiplechoice",
              questionNo: dt.questionNo!,
              isQuestionAnswered: false,
              isQuestionOpen: false,
              multiplechoice: dt));
        }
        for (Multiselect dt in data.multiselect!) {
          temp.add(SQLModel(
              questionType: "multiselect",
              questionNo: dt.questionNo!,
              isQuestionAnswered: false,
              isQuestionOpen: false,
              multiselect: dt));
        }

        for (Numericals dt in data.numericals!) {
          temp.add(SQLModel(
              questionType: "numericals",
              questionNo: dt.questionNo!,
              isQuestionAnswered: false,
              isQuestionOpen: false,
              numericals: dt));
        }

        temp.sort((a, b) => a.questionNo.compareTo(b.questionNo));

        questionList.add(temp);
      }
      if (questionList.length > 0 && questionList[0].length > 0) {
        currentQuestion = questionList[0][0];
        currentQuestion!.isQuestionOpen = true;
      }
      update();
    }
  }

  NextQuestion(BuildContext context) {
    if (checkQuestionEnd() == "Next") {
      questionIndex = questionIndex + 1;
      currentQuestion = questionList[selectedSection][questionIndex];
      currentQuestion!.isQuestionOpen = true;
      update();
    } else if (checkQuestionEnd() == "Next Section") {
      questionIndex = 0;
      selectedSection = selectedSection + 1;

      currentQuestion = questionList[selectedSection][questionIndex];
      currentQuestion!.isQuestionOpen = true;
      update();
    } else {
      QuickAlert.show(
          context: context,
          type: QuickAlertType.confirm,
          confirmBtnText: "Sure",
          onConfirmBtnTap: () {
            Navigator.of(context).pop();
            QuickAlert.show(
                context: context,
                type: QuickAlertType.loading,
                title: "Please wait",
                text: "your answer validating");
            submitExam();
          },
          title: "Are you sure want to submit exam");
      //submitExam();
    }
  }

  String checkQuestionisFirst() {
    if (questionIndex == 0 && selectedSection == 0)
      return "";
    else if (questionIndex == 0 && selectedSection != 0)
      return "Previous Section";
    else
      return "Previous";
  }

  String checkQuestionEnd() {
    if (questionIndex == questionList[selectedSection].length - 1 &&
        selectedSection == section.length - 1)
      return "Submit";
    else if (questionIndex == questionList[selectedSection].length - 1)
      return "Next Section";
    else
      return "Next";
  }

  jumpQuestion({required int questionNo}) {
    questionIndex = questionNo;
    currentQuestion = questionList[selectedSection][questionIndex];
    currentQuestion!.isQuestionOpen = true;
    update();
  }

  PreviousQuestion() {
    if (questionIndex > 0 && checkQuestionisFirst() == "Previous") {
      questionIndex = questionIndex - 1;
      currentQuestion = questionList[selectedSection][questionIndex];
      update();
    } else if (questionIndex == 0 &&
        checkQuestionisFirst() == "Previous Section") {
      selectedSection = selectedSection - 1;
      questionIndex = questionList[selectedSection].length - 1;
      currentQuestion = questionList[selectedSection][questionIndex];
      update();
      //  currentQuestion!.isQuestionOpen = true;
    }
  }

  bool checkTypeAttended(String type, int section) {
    for (var data in questionList[section]) {
      if (data.questionType == type && data.answers != "") return true;
    }

    return false;
  }

  Map<String, dynamic> getSectionResponse(int section) {
    var response = {
      "multiplechoice": {
        for (var data in questionList[section])
          if (data.questionType == "multiplechoice" && data.answers != "")
            data.multiplechoice!.mcqId.toString(): data.answers
      },
      "multiselect": {
        for (var data in questionList[section])
          if (data.questionType == "multiselect" && data.answers != "")
            data.multiselect!.msqId.toString():
                data.answers.split("-").sublist(1)
      },
      "numericals": {
        for (var data in questionList[section])
          if (data.questionType == "numericals" && data.answers != "")
            data.numericals!.nqId.toString():
                double.parse(data.answers).toDouble()
      }
    };

    return response;
  }

  String calculcateDuration() {
    Duration duration =
        Duration(seconds: TimeDuration!.inSeconds - consumedTime.toInt());
    String hours = duration.inHours.toString().padLeft(0, '2');
    String minutes =
        duration.inMinutes.remainder(60).toString().padLeft(2, '0');
    String seconds =
        duration.inSeconds.remainder(60).toString().padLeft(2, '0');
    return "$hours:$minutes:$seconds";
  }

  Future<void> submitExam() async {
    var dio = d.Dio();

    var request = {
      for (int i = 0; i < examModel!.sections!.length; i++)
        examModel!.sections![i].id.toString(): getSectionResponse(i)
    };

    var requestBody = json.encode({
      "exam_id": examModel!.examUniqueId!,
      "time_taken": calculcateDuration(),
      "exam_response": request
    });
    print(requestBody);

    //requestBody = json.encode();

    try {
      d.Response response = await dio.post(
        baseurl + "/applicationview/examresponseadd/",
        options: d.Options(
          headers: {
            "Authorization": "Token $token",
            "Content-Type": "application/json",
            "Vary": "Accept",
            // "Content-Length": "1000",
          },
        ),
        data: requestBody,
      );
      if (response.statusCode == 201) {
        Get.back();
        Get.back();
        Get.back();
        Box bx = await Hive.openBox("EXAM_RESULT");
        bx.put(response.data["data"]["exam_id"].toString(),
            response.data["data"]["response"]);
        Get.to(
            () => ResultViewScreen(
                  UserResponse: response.data["data"]["response"],
                  slug:
                      "applicationview/courses/${cousreID}/subjects/${subjectID}/modules/${moduleID}/exams/${examID}",
                ),
            transition: Transition.rightToLeft);
      }
    } on d.DioException catch (e) {
      if (e.response != null) {
        Fluttertoast.showToast(msg: "Server error please try after sometimes");
        Get.back();
      } else {
        Fluttertoast.showToast(msg: "Server error please try after sometimes");
        Get.back();
      }
    } catch (e) {
      Fluttertoast.showToast(msg: "Server error please try after sometimes");
      Get.back();
    }
  }
}
