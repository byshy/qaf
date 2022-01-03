import 'dart:async';

import 'package:qaf/data/local_repository.dart';
import 'package:qaf/models/user.dart';
import 'package:qaf/utils_and_services/dio_error_printer.dart';
import 'package:qaf/utils_and_services/routing/navigation_service.dart';
import 'package:qaf/utils_and_services/routing/routes.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../../di.dart';

class PreAppProvider with ChangeNotifier {
  /// Change this duration to match the duration of the animation
  final DateTime _startTime = DateTime.now().add(const Duration(seconds: 3));

  PreAppProvider() {
    refreshAccessToken();
  }

  bool refreshTokenLoading = false;

  String? refreshTokenError;

  void refreshAccessToken() {
    refreshTokenLoading = true;
    refreshTokenError = null;
    notifyListeners();
    runZonedGuarded(
      () async {
        User? user = sl<LocalRepo>().getUser();
        if (user == null) {
          navigator(screen: loginScreen);
          return;
        } else {
          navigator(screen: homeScreen);
          return;
        }
      },
      (e, s) {
        refreshTokenLoading = false;
        notifyListeners();

        if (e is DioError) {
          printDioError(e, 'refreshAccessToken');

          debugPrint('refreshAccessToken status code: ${e.response?.statusCode}');
          if (e.response?.statusCode == 401 || e.response?.statusCode == 400) {
            sl<NavigationService>().navigateToAndRemove(loginScreen);
          } else {
            sl<NavigationService>().navigateToAndRemove(homeScreen);
          }
        }
      },
    );
  }

  void setNewToken(String token) {
    User? _user = sl<LocalRepo>().getUser();
    if (_user != null) {
      _user.data!.accessToken = token;
      sl<LocalRepo>().setUser(_user);
      refreshToken();
    }
  }

  void navigator({required String screen}) {
    DateTime _endTime = DateTime.now();
    if (_endTime.isAfter(_startTime)) {
      sl<NavigationService>().navigateToAndRemove(screen);
    } else {
      Future.delayed(_startTime.difference(_endTime), () {
        sl<NavigationService>().navigateToAndRemove(screen);
      });
    }
  }
}
