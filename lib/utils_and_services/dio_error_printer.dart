import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

void printDioError(DioError e, String callingMethod) {
  debugPrint('DioError in $callingMethod:\ntype: ${e.type.toString()}\nmessage: ${e.message}\nmessage: ${e.response?.data.toString()}');
}