import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qaf/utils_and_services/app_translations/app_translations.dart';
import 'package:qaf/utils_and_services/decoration/colors.dart';
import 'package:qaf/utils_and_services/decoration/images.dart';
import 'package:qaf/utils_and_services/global_widgets/custom_raised_button.dart';
import 'package:qaf/utils_and_services/routing/navigation_service.dart';
import 'package:qaf/utils_and_services/routing/routes.dart';

import '../../../di.dart';

void displayRegistrationSuccessDialog() async {
  showGeneralDialog(
    context: sl<NavigationService>().getContext(),
    barrierLabel: '',
    barrierDismissible: true,
    barrierColor: Colors.black38,
    transitionDuration: Duration.zero,
    pageBuilder: (context, anim1, anim2) {
      return AlertDialog(
        elevation: 0,
        contentPadding: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        content: Padding(
          padding: const EdgeInsets.symmetric(vertical: 36, horizontal: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(cabIcon),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 26),
                child: Text(
                  AppTranslations.of(context: context)!.text('registration_success'),
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomRaisedButton(
                    onTap: () => sl<NavigationService>().navigateToAndRemove(homeScreen),
                    color: blue072B66,
                    radius: 4,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: Text(
                        AppTranslations.of(context: context)!.text('finish'),
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    },
    transitionBuilder: (ctx, anim1, anim2, child) => BackdropFilter(
      filter: ImageFilter.blur(
        sigmaX: 4 * anim1.value,
        sigmaY: 4 * anim1.value,
      ),
      child: FadeTransition(
        child: child,
        opacity: anim1,
      ),
    ),
  );
}
