class BaseModel {
  String? eventName;
  dynamic eventData;
  String? eventError;
  int? errorCode;

  BaseModel({this.eventName, this.eventData, this.eventError, this.errorCode});

  BaseModel.fromJson(Map<String, dynamic> json) {
    eventName = json['eventName'];
    eventData = json['eventData'];
    eventError = json['eventError'];
    errorCode = json['errorCode'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['eventName'] = eventName;
    data['eventData'] = eventData;
    data['eventError'] = eventError;
    data['errorCode'] = errorCode;
    return data;
  }
}
