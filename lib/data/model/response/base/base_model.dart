import 'package:flutter/cupertino.dart';

class BaseResponse<T> extends ChangeNotifier {
  int? status;
  String? message;
  T? data;

  BaseResponse({this.status, this.message, this.data});

  factory BaseResponse.fromJson(
      Map<String, dynamic>? json, Function(Map<String, dynamic>) create) {
    return BaseResponse<T>(
      status: json?["status"] ?? {},
      message: json?["message"] ?? {},
      data: create(json?["data"] ?? {}),
    );
  }
}
