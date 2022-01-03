import 'package:qaf/utils_and_services/decoration/images.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:qaf/utils_and_services/app_translations/app_translations.dart';
import 'package:qaf/utils_and_services/decoration/colors.dart';
import 'package:qaf/utils_and_services/global_widgets/custom_raised_button.dart';
import 'package:qaf/utils_and_services/global_widgets/loading_indicator.dart';
import 'package:provider/provider.dart';

import '../../di.dart';
import 'auth_provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          image: DecorationImage(
            image: AssetImage(appBG),
            alignment: Alignment.bottomCenter,
            colorFilter: ColorFilter.mode(
              Color(0xFFF1F1F1),
              BlendMode.srcIn,
            ),
          ),
        ),
        child: Material(
          type: MaterialType.transparency,
          child: AnnotatedRegion<SystemUiOverlayStyle>(
            value: const SystemUiOverlayStyle(
              statusBarBrightness: Brightness.light,
            ),
            child: Consumer<AuthProvider>(
              builder: (_, instance, child) {
                return SafeArea(
                  minimum: const EdgeInsets.symmetric(horizontal: 34),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const Spacer(flex: 2),
                      Image.asset(
                        coloredLogo,
                        height: 86,
                      ),
                      const SizedBox(height: 45),
                      Text(
                        AppTranslations.of(context: context)!.text('welcome'),
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 66),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 14),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(2),
                          border: Border.all(
                            color: greyB5B5B5,
                          ),
                        ),
                        child: Directionality(
                          textDirection: TextDirection.ltr,
                          child: IntrinsicHeight(
                            child: Row(
                              children: [
                                CountryCodePicker(
                                  onChanged: (val) => sl<AuthProvider>().setCountryCode(dialCode: val.dialCode!),
                                  initialSelection: 'SA',
                                  showCountryOnly: false,
                                  showOnlyCountryWhenClosed: false,
                                  alignLeft: false,
                                  builder: (code) {
                                    return IntrinsicHeight(
                                      child: Row(
                                        children: [
                                          Image.asset(
                                            code!.flagUri!,
                                            package: 'country_code_picker',
                                            height: 15,
                                            width: 20,
                                            fit: BoxFit.fitHeight,
                                          ),
                                          const SizedBox(width: 10),
                                          Text(
                                            code.dialCode.toString(),
                                            style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          VerticalDivider(
                                            color: grey707070.withOpacity(0.25),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                                Expanded(
                                  child: TextField(
                                    controller: instance.loginIdentifierController,
                                    focusNode: instance.loginIdentifierFocus,
                                    textInputAction: TextInputAction.next,
                                    textAlign: TextAlign.left,
                                    keyboardType: TextInputType.number,
                                    onEditingComplete: () => FocusScope.of(context).unfocus(),
                                    decoration: const InputDecoration(
                                      contentPadding: EdgeInsets.zero,
                                      border: InputBorder.none,
                                      hintText: '123456789',
                                      hintStyle: TextStyle(
                                        color: grey969696,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 30),
                      CustomRaisedButton(
                        color: blue072B66,
                        radius: 5,
                        onTap: instance.isLoginLoading ? null : () => instance.loginClickHandler(),
                        child: instance.isLoginLoading
                            ? const LoadingIndicator()
                            : Text(
                                AppTranslations.of(context: context)!.text('continue'),
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                      ),
                      const Spacer(flex: 3),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
