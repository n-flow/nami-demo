import 'package:smart_attend/app/data/local/models/courses.dart';

class MarkAttendanceRequest {
  String userId = "";
  Courses? selectedCourse;

  MarkAttendanceRequest(this.userId, this.selectedCourse);

  MarkAttendanceRequest.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    if (json['selectedCourse'] != null) {
      selectedCourse = Courses.fromJson(json['selectedCourse']);
    }
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['userId'] = userId;
    if (selectedCourse != null) {
      data['selectedCourse'] = selectedCourse!.toJson();
    }
    return data;
  }
}
