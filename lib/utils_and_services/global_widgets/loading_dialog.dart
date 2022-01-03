import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qaf/utils_and_services/routing/navigation_service.dart';

import '../../di.dart';
import 'loading_indicator.dart';

void showLoadingDialog() {
  showDialog(
    context: sl<NavigationService>().getContext(),
    barrierDismissible: false,
    builder: (_) => Platform.isIOS
        ? const CupertinoAlertDialog(
            content: Padding(
              padding: EdgeInsets.symmetric(vertical: 40),
              child: CupertinoActivityIndicator(),
            ),
          )
        : AlertDialog(
            content: Padding(
              padding: const EdgeInsets.symmetric(vertical: 40),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  Center(
                    child: LoadingIndicator(
                      size: 30,
                      color: Colors.blue,
                    ),
                  ),
                ],
              ),
            ),
          ),
  );
}
