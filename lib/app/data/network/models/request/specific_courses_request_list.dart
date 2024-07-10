import 'package:smart_attend/app/data/local/models/courses.dart';

class SpecificCoursesRequestList {
  String userId = "";
  int days = 30;
  Courses? selectedCourse;

  SpecificCoursesRequestList(this.userId, this.days, this.selectedCourse);

  SpecificCoursesRequestList.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    days = json['days'];
    if (json['selectedCourse'] != null) {
      selectedCourse = Courses.fromJson(json['selectedCourse']);
    }
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['userId'] = userId;
    data['days'] = days;
    if (selectedCourse != null) {
      data['selectedCourse'] = selectedCourse!.toJson();
    }
    return data;
  }
}
