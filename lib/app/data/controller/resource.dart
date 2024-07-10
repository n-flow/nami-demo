import 'dart:convert';

import 'package:equatable/equatable.dart';

class Resource<T> extends Equatable {
  final Status? status;
  final T? data;
  final String? message;

  const Resource({this.status, this.data, this.message});

  static Resource<T> success<T>({T? data}) {
    return Resource(status: Status.success, data: data);
  }

  static Resource<T> error<T>({String? msg, T? data}) {
    return Resource(status: Status.error, data: data, message: msg);
  }

  static Resource<T> loading<T>({String? msg, T? data}) {
    return Resource(status: Status.loading, data: data, message: msg);
  }

  static Resource<T> moreLoading<T>({String? msg, T? data}) {
    return Resource(status: Status.moreLoading, data: data, message: msg);
  }

  @override
  List<Object?> get props => [status, data, message];

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": data != null ? jsonEncode(data) : "DATA",
        "message": message,
      };
}

enum Status { success, error, loading, moreLoading }
