import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:mathlab/Constants/urls.dart';
import 'package:mathlab/screen/SectionExam/Model/SQLModel.dart';
import 'package:mathlab/screen/SectionExam/Model/SectionExamModel.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ResultController extends GetxController {
  SExamModel? examModel;
  late String token;
  List<String> section = [];
  List<List<SQLModel>> questionList = [];

  fetchExam(var userAnwser, String slug) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    token = pref.getString("TOKEN") ?? "";

    final Response = await get(
        Uri.parse(baseurl + "/exam/addexam/${userAnwser["exam_id"]}"),
        headers: {
          "Authorization": "token $token",
          "Content-Type": "application/json",
        });

    print(Response.body);
    print(userAnwser);

    if (Response.statusCode == 200) {
      examModel = SExamModel.fromJson(json.decode(Response.body));

      for (var data in examModel!.sections!) {
        section.add(data.sectionName!);
        List<SQLModel> temp = [];
        for (Multiplechoice dt in data.multiplechoice!) {
          SQLModel tt = SQLModel(
              questionType: "multiplechoice",
              questionNo: dt.questionNo!,
              isQuestionAnswered: false,
              isQuestionOpen: false,
              multiplechoice: dt);
          if (userAnwser["response"][data.id.toString()] != null &&
              userAnwser["response"][data.id.toString()]["multiplechoice"] !=
                  null) {
            tt.answers = userAnwser["response"][data.id.toString()]
                    ["multiplechoice"][dt.mcqId.toString()] ??
                "";
          }

          temp.add(tt);
        }
        for (Multiselect dt in data.multiselect!) {
          SQLModel tt = SQLModel(
              questionType: "multiselect",
              questionNo: dt.questionNo!,
              isQuestionAnswered: false,
              isQuestionOpen: false,
              multiselect: dt);
          if (userAnwser["response"][data.id.toString()] != null &&
              userAnwser["response"][data.id.toString()]["multiselect"] !=
                  null &&
              userAnwser["response"][data.id.toString()]["multiselect"]
                      [dt.msqId.toString()] !=
                  null)
            tt.answers = tt.answers = userAnwser["response"][data.id.toString()]
                    ["multiselect"][dt.msqId.toString()]
                .join("-");
          temp.add(tt);
        }

        for (Numericals dt in data.numericals!) {
          SQLModel tt = SQLModel(
              questionType: "numericals",
              questionNo: dt.questionNo!,
              isQuestionAnswered: false,
              isQuestionOpen: false,
              numericals: dt);
          if (userAnwser["response"][data.id.toString()] != null &&
              userAnwser["response"][data.id.toString()]["numericals"] != null)
            tt.answers = userAnwser["response"][data.id.toString()]
                    ["numericals"][dt.nqId.toString()]
                .toString()
                .replaceAll("null", "");

          temp.add(tt);
        }
        if (temp.isNotEmpty) questionList.add(temp);
      }
      update();
    }
    update();
  }

  String calculcateDuration(var response) {
    List time = response["time_taken"].toString().split(":");
    Duration duration = Duration(
        hours: int.parse(time[0]),
        minutes: int.parse(time[1]),
        seconds: int.parse(time[2]));
    String hours = duration.inHours.toString().padLeft(0, '2');
    String minutes =
        duration.inMinutes.remainder(60).toString().padLeft(2, '0');
    String seconds =
        duration.inSeconds.remainder(60).toString().padLeft(2, '0');
    return "$hours:$minutes:$seconds";
  }
}
