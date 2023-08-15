import 'package:hive_flutter/hive_flutter.dart';
part 'purchaseExam.g.dart';

@HiveType(typeId: 0)
class PurchaseCourse {
  @HiveField(0)
  int? courseId;
  @HiveField(1)
  String? dateOfPurchase;
  @HiveField(2)
  String? expirationDate;

  PurchaseCourse({this.courseId, this.dateOfPurchase, this.expirationDate});

  PurchaseCourse.fromJson(Map<String, dynamic> json) {
    courseId = json['course_id'];
    dateOfPurchase = json['date_of_purchase'];
    expirationDate = json['expiration_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['course_id'] = this.courseId;
    data['date_of_purchase'] = this.dateOfPurchase;
    data['expiration_date'] = this.expirationDate;
    return data;
  }
}
