import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:keyboard_actions/external/platform_check/platform_check.dart';
import 'package:qaf/utils_and_services/routing/navigation_service.dart';

import '../../di.dart';

void showErrorDialog({
  required String title,
  required String message,
  VoidCallback? onOkTap,
}) {
  showDialog(
    context: sl<NavigationService>().getContext(),
    builder: (_) {
      return PlatformCheck.isIOS
          ? CupertinoAlertDialog(
              title: Text(title),
              content: Text(message),
              actions: [
                TextButton(
                  child: const Text('إغلاق'),
                  onPressed: onOkTap ?? () => sl<NavigationService>().navigateToPrevious(),
                ),
              ],
            )
          : AlertDialog(
              title: Text(title),
              content: Text(message),
              actions: [
                TextButton(
                  child: const Text('إغلاق'),
                  onPressed: onOkTap ?? () => sl<NavigationService>().navigateToPrevious(),
                ),
              ],
            );
    },
  );
}
