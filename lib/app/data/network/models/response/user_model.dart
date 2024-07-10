class User {
  String? id;
  String? name;
  String? userId;
  String? password;
  String? professorCode;

  User({this.id, this.name, this.userId, this.password, this.professorCode});

  User.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    name = json['name'];
    userId = json['userId'];
    password = json['password'];
    professorCode = json['professorCode'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['_id'] = id;
    data['name'] = name;
    data['userId'] = userId;
    data['password'] = password;
    data['professorCode'] = professorCode;
    return data;
  }
}
