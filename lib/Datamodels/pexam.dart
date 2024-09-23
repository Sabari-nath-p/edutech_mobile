import 'package:hive_flutter/hive_flutter.dart';
part 'pexam.g.dart';

@HiveType(typeId: 1)
class PEXAM {
  @HiveField(0)
  int? courseId;
  @HiveField(1)
  String? dateOfPurchase;
  @HiveField(2)
  String? expirationDate;

  PEXAM({this.courseId, this.dateOfPurchase, this.expirationDate});

  PEXAM.fromJson(Map<String, dynamic> json) {
    courseId = json['exam_id'];
    dateOfPurchase = json['date_of_purchase'];
    expirationDate = json['expiration_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['exam_id'] = this.courseId;
    data['date_of_purchase'] = this.dateOfPurchase;
    data['expiration_date'] = this.expirationDate;
    return data;
  }
}
