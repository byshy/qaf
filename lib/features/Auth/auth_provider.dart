import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:qaf/data/api_repository.dart';
import 'package:qaf/data/local_repository.dart';
import 'package:qaf/models/core/error_res.dart';
import 'package:qaf/models/user.dart';
import 'package:qaf/utils_and_services/app_translations/app_translations.dart';
import 'package:qaf/utils_and_services/dio_error_printer.dart';
import 'package:qaf/utils_and_services/global_widgets/error_dialog.dart';
import 'package:qaf/utils_and_services/routing/navigation_service.dart';
import 'package:qaf/utils_and_services/routing/routes.dart';

import '../../di.dart';
import '../../environment.dart';

class AuthProvider with ChangeNotifier {
  final TextEditingController loginIdentifierController =
      TextEditingController(text: kReleaseMode ? '' : sl<Environment>().documentNO.toString());

  final FocusNode loginIdentifierFocus = FocusNode();

  bool isLoginLoading = false;

  String? loginIdentifierErrorString;

  void loginClickHandler() {
    loginIdentifierErrorString = null;
    isLoginLoading = true;
    notifyListeners();
    runZonedGuarded(
      () {
        login();
      },
      (e, s) {
        debugPrint('loginClickHandler stacktrace:\n$s');

        if (e is DioError && e.response != null) {
          printDioError(e, 'loginClickHandler');
          ErrorResponse error = ErrorResponse.fromJson(e.response!.data);
          debugPrint('DioError in login: ${error.toString()}');
          if (error.errors == null) {
            showErrorDialog(title: 'خطأ', message: error.message ?? AppTranslations.of()!.text('unknown_error'));
          } else {
            if (error.errors!.containsKey('DocumentNO')) {
              loginIdentifierErrorString = AppTranslations.of()!.text('id_error');
            }
          }
        } else if (e is PlatformException) {
          // Do nothing
        } else {
          debugPrint('e: ${e.toString()}');
          showErrorDialog(title: 'خطأ', message: e.toString());
        }

        isLoginLoading = false;
        notifyListeners();
      },
    );
  }

  void login() async {
    sl<ApiRepo>().login(
      data: {
        'DocumentNO': loginIdentifierController.text,
      },
    ).then((value) async {
      await postAuth(value: value);
      isLoginLoading = false;
      loginIdentifierController.text = '';
      notifyListeners();
      sl<NavigationService>().navigateToAndRemove(otpScreen);
    });
  }

  String countryCode = '966';

  void setCountryCode({required String dialCode}) {
    countryCode = dialCode.substring(1);
    notifyListeners();
  }

  void logOut() {
    sl<LocalRepo>().removeUser();
    sl<NavigationService>().popUntilAndPush(routeName: loginScreen);
    reset();
  }

  Future<void> postAuth({required User value}) async {
    sl<LocalRepo>().setUser(value);
    refreshToken();
  }

  final TextEditingController resetPassCodeController = TextEditingController();

  final FocusNode resetPassCodeFocus = FocusNode();

  bool verifyCodeLoading = false;

  void verifyCode() {
    verifyCodeLoading = true;
    notifyListeners();
    runZonedGuarded(
      () {
        sl<ApiRepo>().verifyCode(
          data: {
            'Keyverify': resetPassCodeController.text,
          },
        ).then((value) {
          verifyCodeLoading = false;
          resetPassCodeController.text = '';
          notifyListeners();
          sl<Dio>().options.headers.addAll({'Authorization': value});

          sl<NavigationService>().navigateToAndRemove(completeAccountScreen);
          // sl<NavigationService>().navigateToAndRemove(homeScreen);
        });
      },
      (e, s) {
        verifyCodeLoading = false;
        notifyListeners();

        if (e is DioError) {
          showErrorDialog(
            title: 'خطأ',
            message: AppTranslations.of()!.text('code_error'),
          );
        } else {
          showErrorDialog(
            title: 'خطأ',
            message: e.toString(),
          );
        }
      },
    );
  }
}
