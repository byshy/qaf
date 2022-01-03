import 'package:qaf/utils_and_services/app_translations/app_translations.dart';
import 'package:qaf/utils_and_services/decoration/colors.dart';
import 'package:qaf/utils_and_services/decoration/images.dart';
import 'package:qaf/utils_and_services/global_widgets/custom_raised_button.dart';
import 'package:qaf/utils_and_services/global_widgets/loading_indicator.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pin_put/pin_put.dart';
import 'package:provider/provider.dart';

import '../../../di.dart';
import 'auth_provider.dart';

/// In this screen the user will type in the code they received using email
/// or mobile number
class OTP extends StatefulWidget {
  const OTP({Key? key}) : super(key: key);

  @override
  _OTPState createState() => _OTPState();
}

class _OTPState extends State<OTP> {
  bool showVerifyButton = false;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: SafeArea(
        minimum: const EdgeInsets.symmetric(horizontal: 34),
        child: Consumer<AuthProvider>(
          builder: (_, instance, child) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Spacer(flex: 2),
                Image.asset(
                  coloredLogo,
                  height: 86,
                ),
                const Spacer(flex: 2),
                Text(
                  AppTranslations.of(context: context)!.text('welcome'),
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  AppTranslations.of(context: context)!.text('otp_sent'),
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: greyC8C8C8,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 40),
                PinPut(
                  fieldsCount: 4,
                  onChanged: (val) {
                    setState(() {
                      showVerifyButton = val.length == 4;
                    });
                  },
                  focusNode: instance.resetPassCodeFocus,
                  controller: instance.resetPassCodeController,
                  mainAxisSize: MainAxisSize.min,
                  eachFieldHeight: 48,
                  eachFieldWidth: 45,
                  eachFieldMargin: const EdgeInsets.symmetric(horizontal: 6),
                  submittedFieldDecoration: BoxDecoration(
                    // color: greyB5B5B5,
                    border: Border.all(color: greyB5B5B5),
                    borderRadius: BorderRadius.circular(6.0),
                  ),
                  selectedFieldDecoration: BoxDecoration(
                    border: Border.all(color: blue072B66),
                    borderRadius: BorderRadius.circular(6.0),
                  ),
                  followingFieldDecoration: BoxDecoration(
                    border: Border.all(color: greyB5B5B5),
                    borderRadius: BorderRadius.circular(6.0),
                  ),
                ),
                const SizedBox(height: 65),
                AnimatedOpacity(
                  opacity: showVerifyButton ? 1 : 0,
                  duration: const Duration(milliseconds: 400),
                  child: CustomRaisedButton(
                    radius: 5,
                    color: blue072B66,
                    onTap: showVerifyButton && (!instance.verifyCodeLoading) ? () => sl<AuthProvider>().verifyCode() : null,
                    child: instance.verifyCodeLoading
                        ? const LoadingIndicator()
                        : Text(
                            AppTranslations.of(context: context)!.text('continue'),
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                  ),
                ),
                const Spacer(flex: 3),
                InkWell(
                  onTap: () {},
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        text: AppTranslations.of(context: context)!.text('no_code'),
                        style: const TextStyle(
                          fontSize: 15,
                          color: grey707070,
                        ),
                        children: [
                          const TextSpan(
                            text: ' ',
                          ),
                          TextSpan(
                            text: AppTranslations.of(context: context)!.text('resend'),
                            style: const TextStyle(
                              color: blue2BB4ED,
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
