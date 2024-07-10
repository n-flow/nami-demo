import 'package:smart_attend/app/data/local/models/courses.dart';

class CoursesRequest {
  String userId = "";
  List<Courses> coursesList = [];

  CoursesRequest(this.userId, this.coursesList);

  CoursesRequest.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];

    if (json['coursesList'] != null) {
      json['coursesList'].forEach((v) {
        coursesList.add(Courses.fromJson(v));
      });
    }

    coursesList = json['coursesList'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['userId'] = userId;
    data['coursesList'] = coursesList.map((v) => v.toJson()).toList();
    return data;
  }
}
