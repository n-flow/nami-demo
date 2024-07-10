import 'package:smart_attend/app/utils/date_formats.dart';

class Courses {

  String courseId = "";
  String courseName = "";
  int attendanceDate = 0;
  bool isAttendance = false;

  Courses(this.courseId, this.courseName, this.attendanceDate, this.isAttendance);

  Courses.fromJson(Map<String, dynamic> json) {
    courseId = json['courseId'];
    courseName = json['courseName'];
    attendanceDate = json['attendanceDate'];
    isAttendance = json['isAttendance'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['courseId'] = courseId;
    data['courseName'] = courseName;
    data['attendanceDate'] = attendanceDate;
    data['isAttendance'] = isAttendance;
    return data;
  }

}

List<Courses> getCoursesList() {

  var data = <Courses>[];

  data.add(Courses("1", "MTL 100", getDateTime(), false));
  data.add(Courses("2", "PYL 100", getDateTime(), false));
  data.add(Courses("3", "CML 100", getDateTime(), false));
  data.add(Courses("4", "APL 105", getDateTime(), false));
  data.add(Courses("5", "NEN 100", getDateTime(), false));

  return data;
}